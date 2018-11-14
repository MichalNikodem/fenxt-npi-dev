 create or replace view dm_Invoices_attr as select 
_sys_transform_id,
TenantId,
InvoiceId,
InvoiceNumber,
REPLACE(REPLACE(Description, CHR(13), ''), CHR(10), '') as Description,
StatusTranslation,
AddedByUserName,
AddedByUserNameLabel,
InvoiceHyperlink,
InvoicePaymentMethod
from out_Invoices_attr 
 where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Invoices_attr');
