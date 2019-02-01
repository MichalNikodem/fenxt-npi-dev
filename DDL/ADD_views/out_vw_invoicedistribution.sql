CREATE OR REPLACE VIEW out_vw_invoicedistribution AS
SELECT
	InvoiceDistributionId::VARCHAR(512) as "cp__invoicedistributionid",
	AccountId::VARCHAR(512) as "r__accounts",
	InvoiceId::VARCHAR(512) as "r__invoices_fact",
	ProjectId::VARCHAR(512) as "r__projects",
	TenantId::VARCHAR(128) as x__client_id
FROM out_InvoiceDistribution
;