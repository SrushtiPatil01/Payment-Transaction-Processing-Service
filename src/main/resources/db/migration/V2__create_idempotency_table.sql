CREATE TABLE idempotency_records (
    id              BIGSERIAL PRIMARY KEY,
    idempotency_key VARCHAR(255) NOT NULL,
    merchant_id     VARCHAR(100) NOT NULL,
    response_body   TEXT NOT NULL,
    http_status     INTEGER NOT NULL,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    expires_at      TIMESTAMP NOT NULL,
    CONSTRAINT uq_idempotency_key UNIQUE (idempotency_key, merchant_id)
);

CREATE INDEX idx_idemp_key ON idempotency_records(idempotency_key);
CREATE INDEX idx_idemp_expires ON idempotency_records(expires_at);