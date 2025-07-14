CREATE TABLE "Accounts" (
    "Id" SERIAL PRIMARY KEY,
    "Owner" VARCHAR(255) NOT NULL,
    "Balance" NUMERIC(18, 2) NOT NULL
);

INSERT INTO "Accounts" ("Owner", "Balance") VALUES ('Alice', 1000.00);
INSERT INTO "Accounts" ("Owner", "Balance") VALUES ('Bob', 500.00);
