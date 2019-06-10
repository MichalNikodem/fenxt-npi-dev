drop table if exists out_Invoices_fact;
CREATE TABLE out_Invoices_fact
(
    _sys_transform_id int NOT NULL encoding rle,
    TenantId varchar(255) encoding rle,
    InvoiceFactId varchar(255),
    VendorId varchar(255),
    FiscalPeriodId varchar(255),
    InvoiceAttrId varchar(255),
    InvoiceAmount varchar(255),
    InvoiceBalance varchar(255),
    InvoiceTaxAmount varchar(255),
    InvoiceDiscountAmount varchar(255),
    DateAdded varchar(255),
    DateChanged varchar(255),
    DueDate varchar(255),
    PostDate varchar(255),
    PostStatusId varchar(255),
    Date varchar(255)
)  ORDER BY TenantId,
          _sys_transform_id
SEGMENTED BY hash(TenantId) ALL NODES
PARTITION BY (_sys_transform_id);