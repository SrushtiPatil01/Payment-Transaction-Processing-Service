CREATE TABLE payment_methods (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id     VARCHAR(100) NOT NULL,
    type            VARCHAR(30) NOT NULL,
    tokenized_value VARCHAR(255) NOT NULL,
    last_four_digits VARCHAR(4) NOT NULL,
    expiry_month    VARCHAR(2),
    expiry_year     VARCHAR(4),
    is_default      BOOLEAN NOT NULL DEFAULT FALSE,
    active          BOOLEAN NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_pm_customer ON payment_methods(customer_id);