-- Step 1: Create partitioned table
CREATE TABLE transactions_partitioned (
    LIKE transactions INCLUDING ALL
) PARTITION BY RANGE (created_at);

-- Step 2: Create monthly partitions
CREATE TABLE transactions_y2024_m01 PARTITION OF transactions_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');
CREATE TABLE transactions_y2024_m02 PARTITION OF transactions_partitioned
    FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');
CREATE TABLE transactions_y2024_m03 PARTITION OF transactions_partitioned
    FOR VALUES FROM ('2024-03-01') TO ('2024-04-01');
CREATE TABLE transactions_y2024_m04 PARTITION OF transactions_partitioned
    FOR VALUES FROM ('2024-04-01') TO ('2024-05-01');
CREATE TABLE transactions_y2024_m05 PARTITION OF transactions_partitioned
    FOR VALUES FROM ('2024-05-01') TO ('2024-06-01');
CREATE TABLE transactions_y2024_m06 PARTITION OF transactions_partitioned
    FOR VALUES FROM ('2024-06-01') TO ('2024-07-01');
CREATE TABLE transactions_y2024_m07 PARTITION OF transactions_partitioned
    FOR VALUES FROM ('2024-07-01') TO ('2024-08-01');
CREATE TABLE transactions_y2024_m08 PARTITION OF transactions_partitioned
    FOR VALUES FROM ('2024-08-01') TO ('2024-09-01');
CREATE TABLE transactions_y2024_m09 PARTITION OF transactions_partitioned
    FOR VALUES FROM ('2024-09-01') TO ('2024-10-01');
CREATE TABLE transactions_y2024_m10 PARTITION OF transactions_partitioned
    FOR VALUES FROM ('2024-10-01') TO ('2024-11-01');
CREATE TABLE transactions_y2024_m11 PARTITION OF transactions_partitioned
    FOR VALUES FROM ('2024-11-01') TO ('2024-12-01');
CREATE TABLE transactions_y2024_m12 PARTITION OF transactions_partitioned
    FOR VALUES FROM ('2024-12-01') TO ('2025-01-01');

-- Default partition for future dates
CREATE TABLE transactions_default PARTITION OF transactions_partitioned DEFAULT;

-- Step 3: Migrate data (run during maintenance window)
-- INSERT INTO transactions_partitioned SELECT * FROM transactions;

-- Step 4: Swap tables
-- ALTER TABLE transactions RENAME TO transactions_old;
-- ALTER TABLE transactions_partitioned RENAME TO transactions;

-- Create function to auto-create partitions
CREATE OR REPLACE FUNCTION create_monthly_partition()
RETURNS void AS $$
DECLARE
    start_date DATE;
    end_date DATE;
    partition_name TEXT;
BEGIN
    start_date := date_trunc('month', NOW() + INTERVAL '1 month');
    end_date := start_date + INTERVAL '1 month';
    partition_name := 'transactions_y' || to_char(start_date, 'YYYY') ||
                      '_m' || to_char(start_date, 'MM');

    EXECUTE format(
        'CREATE TABLE IF NOT EXISTS %I PARTITION OF transactions FOR VALUES FROM (%L) TO (%L)',
        partition_name, start_date, end_date
    );
END;
$$ LANGUAGE plpgsql;