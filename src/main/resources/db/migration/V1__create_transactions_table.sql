CREATE TABLE transactions (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    reference_id    VARCHAR(50) NOT NULL UNIQUE,
    merchant_id     VARCHAR(100) NOT NULL,
    customer_id     VARCHAR(100) NOT NULL,
    amount          NUMERIC(19,4) NOT NULL,
    currency        VARCHAR(3) NOT NULL,
    status          VARCHAR(30) NOT NULL,
    type            VARCHAR(20) NOT NULL,
    payment_method_id VARCHAR(100),
    description     TEXT,
    failure_reason  TEXT,
    gateway_transaction_id VARCHAR(100),
    parent_transaction_id UUID,
    refunded_amount NUMERIC(19,4) NOT NULL DEFAULT 0,
    version         BIGINT NOT NULL DEFAULT 0,
    idempotency_key VARCHAR(255),
    metadata        JSONB,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    settled_at      TIMESTAMP
);

CREATE INDEX idx_txn_merchant ON transactions(merchant_id);
CREATE INDEX idx_txn_customer ON transactions(customer_id);
CREATE INDEX idx_txn_status ON transactions(status);
CREATE INDEX idx_txn_created ON transactions(created_at);
CREATE UNIQUE INDEX idx_txn_reference ON transactions(reference_id);
CREATE INDEX idx_txn_idempotency ON transactions(idempotency_key);
CREATE INDEX idx_txn_merchant_created ON transactions(merchant_id, created_at DESC);