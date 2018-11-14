CREATE or replace view out_vw_vendors as
select
    AddedByUserName::VARCHAR(512) as a__addedbyusername,
    CustomerNumber::VARCHAR(512) as a__customernumber,
    StatusTranslation::VARCHAR(512) as a__statustranslation,
    VendorName::VARCHAR(512) as a__vendorname,
    VendorUserID::VARCHAR(512) as a__vendoruserid,
    VendorId::VARCHAR(512) as cp__vendorid,
    AddedByUserNameLabel::VARCHAR(512) as l__addedbyusername__addedbyuserlabel,
    GoodData_Attr('{"state":"payables.vendor.detail","id":'||VendorId||'}')::VARCHAR(512) as l__vendorname__vendornamehyperlink,
    TenantId::VARCHAR(128) as x__client_id
from out_Vendors
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Vendors')
;