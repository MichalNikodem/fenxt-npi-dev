CREATE OR REPLACE VIEW out_vw_archarge AS
SELECT
	ARChargePaymentStatus::VARCHAR(512) as "a__archarge",
	ARChargeItemDescription::VARCHAR(512) as "a__archarged",
	ARChargeInvoiceId::VARCHAR(512) as "a__archargeinvoiceid",
	ARChargeLineItemSequence::VARCHAR(512) as "a__archargeline",
	ARChargePostStatus::VARCHAR(512) as "a__archargepoststatus",
	ARChargeType::VARCHAR(512) as "a__archargetype",
	ARChargeId::VARCHAR(512) as "cp__archargeid",
	Gooddata_Date((CASE WHEN ((out_ARCharges.dateadded)::date < '1900-01-01'::date) THEN '1900-01-01'::date WHEN ((out_ARCharges.dateadded)::date > '2050-01-01'::date) THEN '2050-01-01'::date ELSE (out_ARCharges.dateadded)::date END)::date)::DATE as "d__dateadded",
	Gooddata_Date((CASE WHEN ((out_ARCharges.datechanged)::date < '1900-01-01'::date) THEN '1900-01-01'::date WHEN ((out_ARCharges.datechanged)::date > '2050-01-01'::date) THEN '2050-01-01'::date ELSE (out_ARCharges.datechanged)::date END)::date)::DATE as "d__datechanged",
	Gooddata_Date((CASE WHEN ((out_ARCharges.duedate)::date < '1900-01-01'::date) THEN '1900-01-01'::date WHEN ((out_ARCharges.duedate)::date > '2050-01-01'::date) THEN '2050-01-01'::date ELSE (out_ARCharges.duedate)::date END)::date)::DATE as "d__duedate",
	Gooddata_Date((CASE WHEN ((out_ARCharges.postdate)::date < '1900-01-01'::date) THEN '1900-01-01'::date WHEN ((out_ARCharges.postdate)::date > '2050-01-01'::date) THEN '2050-01-01'::date ELSE (out_ARCharges.postdate)::date END)::date)::DATE as "d__postdate",
	ARChargeAmount::NUMERIC(12,2) as "f__archarge",
	ARChargeBalance::NUMERIC(12,2) as "f__archargebalance",
	ARClientId::VARCHAR(512) as "r__arclients",
	TenantId::VARCHAR(128) as x__client_id
FROM out_ARCharges
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_ARCharges')
;