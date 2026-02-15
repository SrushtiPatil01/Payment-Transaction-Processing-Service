CREATE TABLE audit_logs (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    transaction_id  UUID NOT NULL,
    action          VARCHAR(50) NOT NULL,
    performed_by    VARCHAR(100) NOT NULL,
    previous_state  TEXT,
    new_state       TEXT,
    details         TEXT,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_audit_txn ON audit_logs(transaction_id);
CREATE INDEX idx_audit_created ON audit_logs(created_at);