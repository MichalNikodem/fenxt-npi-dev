CREATE or replace view out_vw_invoices_attr as
select
    AddedByUserName::VARCHAR(512) as a__addedbyusername,
    InvoiceId::VARCHAR(512) as a__description,
    InvoiceNumber::VARCHAR(512) as a__invoicenumber,
    InvoicePaymentMethod::VARCHAR(512) as a__invoicepaymentmethod,
    StatusTranslation::VARCHAR(512) as a__statustranslation,
    InvoiceId::VARCHAR(512) as cp__invoiceattrid,
    AddedByUserNameLabel::VARCHAR(512) as l__addedbyusername__addedbyuserlabel,
    Description::VARCHAR(512) as l__description__invoicesdescriptionlabel,
    InvoiceHyperlink::VARCHAR(512) as l__invoiceattrid__invoiceidhyperlink,
    InvoiceHyperlink::VARCHAR(512) as l__invoicenumber__invoicenumberhyperlink,
    TenantId::VARCHAR(128) as x__client_id
from out_Invoices_attr
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Invoices_attr')
;