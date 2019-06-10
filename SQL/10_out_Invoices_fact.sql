INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Invoices_fact',now(),null);
insert /*+ direct */ into out_Invoices_fact
	select 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	i.TenantId as "TenantId",
	 GoodData_Attr(i.InvoiceId) as "InvoiceFactId"
	,Gooddata_Attr(VendorId)  as "VendorId"
	,Gooddata_Attr(fp.FiscalPeriodId)  as "FiscalPeriodId"
	,Gooddata_Attr(i.InvoiceId)  as "InvoiceAttrId"
	,cast(i.Amount as decimal(15,2)) as "InvoiceAmount"
	,cast((case when i.Status = 5 then 0 else i.Balance end) as decimal(15,2)) as "InvoiceBalance"
	,cast(i.TaxAmount as decimal(15,2)) as "InvoiceTaxAmount"
	,cast(i.DiscountAmount as decimal(15,2)) as "InvoiceDiscountAmount"
	,Gooddata_date(i.DateAdded) as "DateAdded"
	,Gooddata_date(i.DateChanged) as "DateChanged"
	,Gooddata_date(i.DueDate) as "DueDate"
	,Gooddata_date(i.PostDate) as "PostDate"
	,GoodData_Attr('inv-'||i.InvoiceId) as "PostStatusId"
	,GoodData_date(i.Date) as "Date"
from stg_csv_Invoice_merge i
left join stg_csv_FiscalPeriod_merge fp on i.PostDate >= fp.StartDate and i.POSTDATE <= fp.EndDate and i.TenantId = fp.TenantId

;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_Invoices_fact',null,now());
select analyze_statistics('out_Invoices_fact')
;