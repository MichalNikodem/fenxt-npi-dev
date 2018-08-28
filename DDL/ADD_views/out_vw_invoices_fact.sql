CREATE OR REPLACE VIEW out_vw_invoices_fact AS
SELECT
	InvoiceFactId::VARCHAR(512) as "cp__invoicefactid",
	Date::DATE as "d__date",
	DateAdded::DATE as "d__dateadded",
	DateChanged::DATE as "d__datechanged",
	DueDate::DATE as "d__duedate",
	PostDate::DATE as "d__postdate",
	InvoiceAmount::NUMERIC(15,2) as "f__invoiceamount",
	InvoiceBalance::NUMERIC(15,2) as "f__invoicebalance",
	InvoiceDiscountAmount::NUMERIC(15,2) as "f__invoicediscountamount",
	InvoiceTaxAmount::NUMERIC(15,2) as "f__invoicetaxamount",
	FiscalPeriodId::VARCHAR(512) as "r__fiscalperiods",
	InvoiceAttrId::VARCHAR(512) as "r__invoices_attr",
	PostStatusId::VARCHAR(512) as "r__poststatus",
	VendorId::VARCHAR(512) as "r__vendors",
	TenantId::VARCHAR(128) as x__client_id
FROM out_Invoices_fact
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Invoices_fact')
;