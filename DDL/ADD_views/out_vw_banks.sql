CREATE OR REPLACE VIEW out_vw_banks AS
SELECT
	AccountId::VARCHAR(512) as "a__accountid",
	AccountNumber::VARCHAR(512) as "a__accountnumber",
	AddedByUserName::VARCHAR(512) as "a__addedbyusername",
	AccountType::VARCHAR(512) as "a__banksaccounttype",
	LastReconciledByUserName::VARCHAR(512) as "a__bankslastreconciledbyusername",
	RoutingNumber::VARCHAR(512) as "a__banksroutingnumber",
	Bankid::VARCHAR(512) as "a__description",
	IsReconciled::VARCHAR(512) as "a__isreconciled",
	Name::VARCHAR(512) as "a__name",
	BankId::VARCHAR(512) as "cp__bankid",
	AddedByUserNameLabel::VARCHAR(512) as "l__addedbyusername__addedbyuserlabel",
	AccountTypeTranslation::VARCHAR(512) as "l__banksaccounttype__banksaccounttypetranslation",
	LastReconciledByUserNameLabel::VARCHAR(512) as "l__bankslastreconciledbyusername__reconciledbyuserlabel",
	Description::VARCHAR(512) as "l__description__banksdescriptionlabel",
	TenantId::VARCHAR(128) as x__client_id
FROM out_Banks
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Banks')

UNION ALL

SELECT
	GoodData_Attr('<No Bank>')::VARCHAR(512) as "a__accountid",
	GoodData_Attr('<No Bank>')::VARCHAR(512) as "a__accountnumber",
	GoodData_Attr(0)::VARCHAR(512) as "a__addedbyusername",
	GoodData_Attr(1)::VARCHAR(512) as "a__banksaccounttype",
	GoodData_Attr(null)::VARCHAR(512) as "a__bankslastreconciledbyusername",
	GoodData_Attr('<No Bank>')::VARCHAR(512) as "a__banksroutingnumber",
	GoodData_Attr(-1)::VARCHAR(512) as "a__description",
	'false'::VARCHAR(512) as "a__isreconciled",
	GoodData_Attr('<No Bank>')::VARCHAR(512) as "a__name",
	GoodData_Attr(-1)::VARCHAR(512) as "cp__bankid",
	GoodData_Attr('')::VARCHAR(512) as "l__addedbyusername__addedbyuserlabel",
	GoodData_Attr('Checking')::VARCHAR(512) as "l__banksaccounttype__banksaccounttypetranslation",
	GoodData_Attr('')::VARCHAR(512) as "l__bankslastreconciledbyusername__reconciledbyuserlabel",
	GoodData_Attr('<No Bank>')::VARCHAR(512) as "l__description__banksdescriptionlabel",
	TenantId::VARCHAR(128) as x__client_id
from out_Tenants
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Tenants')
;