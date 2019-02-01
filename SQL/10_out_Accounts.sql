drop table if exists tmp_AccountSegmentValue_Pregrouped CASCADE;
 CREATE TABLE tmp_AccountSegmentValue_Pregrouped
                                (   accountid integer,
                                    tenantid VARCHAR(512),
                                    accountsegment1 VARCHAR(512),
                                    accountsegment2 VARCHAR(512),
                                    accountsegment3 VARCHAR(512),
                                    accountsegment4 VARCHAR(512),
                                    accountsegment5 VARCHAR(512),
                                    accountsegment6 VARCHAR(512),
                                    accountsegment7 VARCHAR(512),
                                    accountsegment8 VARCHAR(512),
                                    accountsegment9 VARCHAR(512),
                                    accountsegment10 VARCHAR(512))

ORDER BY tenantid,
         accountid

SEGMENTED BY HASH(tenantid,accountid) ALL NODES KSAFE 1;

truncate table tmp_AccountSegmentValue_Pregrouped;

INSERT /*+ Direct */ INTO tmp_AccountSegmentValue_Pregrouped

SELECT

    accountid,
    tenantid,
    MAX(CASE WHEN SegmentID = 1 THEN asv1.AccountSegmentValue || ' - ' || asv1.Description
         END) accountsegment1,
    MAX(CASE WHEN SegmentID = 2 THEN asv1.AccountSegmentValue || ' - ' || asv1.Description
         END) accountsegment2,
    MAX(CASE WHEN SegmentID = 3 THEN asv1.AccountSegmentValue || ' - ' || asv1.Description
         END) accountsegment3,
    MAX(CASE WHEN SegmentID = 4 THEN asv1.AccountSegmentValue || ' - ' || asv1.Description
         END) accountsegment4,
    MAX(CASE WHEN SegmentID = 5 THEN asv1.AccountSegmentValue || ' - ' || asv1.Description
         END) accountsegment5,
    MAX(CASE WHEN SegmentID = 6 THEN asv1.AccountSegmentValue || ' - ' || asv1.Description
         END) accountsegment6,
    MAX(CASE WHEN SegmentID = 7 THEN asv1.AccountSegmentValue || ' - ' || asv1.Description
         END) accountsegment7,
    MAX(CASE WHEN SegmentID = 8 THEN asv1.AccountSegmentValue || ' - ' || asv1.Description
         END) accountsegment8,
    MAX(CASE WHEN SegmentID = 9 THEN asv1.AccountSegmentValue || ' - ' || asv1.Description
         END) accountsegment9,
    MAX(CASE WHEN SegmentID = 10 THEN asv1.AccountSegmentValue || ' - ' || asv1.Description
         END) accountsegment10

    FROM stg_csv_AccountSegmentValue_merge asv1

    group by tenantid,
             accountid
;

truncate table wrk_out_Accounts;

insert /*+ direct */ into wrk_out_Accounts
                            (
                            TenantId,
                            AccountId,
                            AccountNumber,
                            AccountDescription,
                            AccountCategory,
                            AccountCategoryTranslation,
                            FundDescription,
                            Class,
                            StatusTranslation,
                            AccountCodeDescription,
                            DateAdded,
                            DateChanged,
                            AddedByUserId,
                            AddedByUserName,
                            AddedByUserNameLabel,
                            ChangedByUserId,
                            ChangedByUserName,
                            ChangedByUserNameLabel,
                            AccountDateId,
                            IsContra,
                            Dummy,
                            accountsegment1,
                            accountsegment2,
                            accountsegment3,
                            accountsegment4,
                            accountsegment5,
                            accountsegment6,
                            accountsegment7,
                            accountsegment8,
                            accountsegment9,
                            accountsegment10,
                            _sys_hash)

SELECT

TenantId::VARCHAR(512)  as TenantId,
AccountId,
AccountNumber,
AccountDescription,
AccountCategory,
AccountCategoryTranslation,
FundDescription,
Class,
StatusTranslation,
AccountCodeDescription,
DateAdded,
DateChanged,
AddedByUserId,
AddedByUserName,
AddedByUserNameLabel,
ChangedByUserId,
ChangedByUserName,
ChangedByUserNameLabel,
AccountDateId,
IsContra,
Dummy,
accountsegment1,
accountsegment2,
accountsegment3,
accountsegment4,
accountsegment5,
accountsegment6,
accountsegment7,
accountsegment8,
accountsegment9,
accountsegment10,
MD5(
COALESCE(( AccountNumber )::VARCHAR(1000),'') || '|' ||
COALESCE(( AccountDescription )::VARCHAR(1000),'') || '|' ||
COALESCE(( AccountCategory )::VARCHAR(1000),'') || '|' ||
COALESCE(( AccountCategoryTranslation )::VARCHAR(1000),'') || '|' ||
COALESCE(( FundDescription )::VARCHAR(1000),'') || '|' ||
COALESCE(( Class )::VARCHAR(1000),'') || '|' ||
COALESCE(( StatusTranslation )::VARCHAR(1000),'') || '|' ||
COALESCE(( AccountCodeDescription )::VARCHAR(1000),'') || '|' ||
COALESCE(( DateAdded )::VARCHAR(1000),'') || '|' ||
COALESCE(( DateChanged )::VARCHAR(1000),'') || '|' ||
COALESCE(( AddedByUserId )::VARCHAR(1000),'') || '|' ||
COALESCE(( AddedByUserName )::VARCHAR(1000),'') || '|' ||
COALESCE(( AddedByUserNameLabel )::VARCHAR(1000),'') || '|' ||
COALESCE(( ChangedByUserId )::VARCHAR(1000),'') || '|' ||
COALESCE(( ChangedByUserName )::VARCHAR(1000),'') || '|' ||
COALESCE(( ChangedByUserNameLabel )::VARCHAR(1000),'') || '|' ||
COALESCE(( AccountDateId )::VARCHAR(1000),'') || '|' ||
COALESCE(( IsContra )::VARCHAR(1000),'') || '|' ||
COALESCE(( Dummy )::VARCHAR(1000),'') || '|' ||
COALESCE(( accountsegment1 )::VARCHAR(1000),'') || '|' ||
COALESCE(( accountsegment2 )::VARCHAR(1000),'') || '|' ||
COALESCE(( accountsegment3 )::VARCHAR(1000),'') || '|' ||
COALESCE(( accountsegment4 )::VARCHAR(1000),'') || '|' ||
COALESCE(( accountsegment5 )::VARCHAR(1000),'') || '|' ||
COALESCE(( accountsegment6 )::VARCHAR(1000),'') || '|' ||
COALESCE(( accountsegment7 )::VARCHAR(1000),'') || '|' ||
COALESCE(( accountsegment8 )::VARCHAR(1000),'') || '|' ||
COALESCE(( accountsegment9 )::VARCHAR(1000),'') || '|' ||
COALESCE(( accountsegment10 )::VARCHAR(1000),'')
    )

from    (

        select

         a.TenantId as "TenantId"
        ,tmp_prg.accountsegment1
        ,tmp_prg.accountsegment2
        ,tmp_prg.accountsegment3
        ,tmp_prg.accountsegment4
        ,tmp_prg.accountsegment5
        ,tmp_prg.accountsegment6
        ,tmp_prg.accountsegment7
        ,tmp_prg.accountsegment8
        ,tmp_prg.accountsegment9
        ,tmp_prg.accountsegment10
        ,a.AccountId::VARCHAR(512) as "AccountId"
        ,a.AccountNumber::VARCHAR(512) as "AccountNumber"
        ,a.AccountDescription::VARCHAR(512) as "AccountDescription"
        ,a.AccountCategory::VARCHAR(512) as "AccountCategory"
        ,a.AccountCategoryTranslation::VARCHAR(512) as "AccountCategoryTranslation"
        ,f.Description::VARCHAR(512) as "FundDescription"
        ,class.Description::VARCHAR(512) as "Class"
        ,a.StatusTranslation::VARCHAR(512) as "StatusTranslation"
        ,ac.Description::VARCHAR(512) as "AccountCodeDescription"
        ,GoodData_date(a.DateAdded)  as "DateAdded"
        ,GoodData_date(a.DateChanged)  as "DateChanged"
        ,a.AddedByUserId::VARCHAR(512) as "AddedByUserId"
        ,a.AddedByUserId::VARCHAR(512) as "AddedByUserName"
        ,au.Name::VARCHAR(512) as "AddedByUserNameLabel"
        ,a.LastChangedByUserId::VARCHAR(512) as "ChangedByUserId"
        ,a.LastChangedByUserId::VARCHAR(512) as "ChangedByUserName"
        ,eu.Name::VARCHAR(512) as "ChangedByUserNameLabel"
        ,a.AccountId::VARCHAR(512) as "AccountDateId"
        ,a.IsContraAccount as "IsContra"
        ,1::VARCHAR(512) as "Dummy"
        from stg_csv_account_merge a
        join stg_csv_user_merge au on a.AddedByUserId = au.UserId
                                  and a.TenantId = au.TenantId
                                  and au._sys_is_deleted = false
        join stg_csv_user_merge eu on a.LastChangedByUserId = eu.UserId
                                  and a.TenantId = eu.TenantId
                                  and eu._sys_is_deleted = false
        join stg_csv_fund_merge f on a.FundId = f.FundId
                                 and a.TenantId = f.TenantId
        join stg_csv_tableentry_merge class on a.ClassId = class.TableEntryId
                                           and a.TenantId = class.TenantId
                                           and class._sys_is_deleted = false
        join stg_csv_accountcode_merge ac on a.AccountCodeId = ac.AccountCodeId
                                         and a.TenantId = ac.TenantId
        left join tmp_AccountSegmentValue_Pregrouped tmp_prg ON tmp_prg.accountid = a.AccountId
                                                            AND tmp_prg.tenantid = a.tenantid
        ) as a ;

#{consolidate(param_definition_file="out_accounts.json")}