insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions_attr','out_transactions','tmp_start',now(),nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr#out_transactions']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['out_transactions']}','yyyy-mm-dd hh24:mi:ss.us'));

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions_attr','tmp_user','tmp_start',now(),nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr#tmp_user']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['tmp_user']}','yyyy-mm-dd hh24:mi:ss.us'));

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions_attr','tmp_tableentry','tmp_start',now(),nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr#tmp_tableentry']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['tmp_tableentry']}','yyyy-mm-dd hh24:mi:ss.us'));

DROP TABLE IF EXISTS tmp_ids;
CREATE LOCAL TEMPORARY TABLE tmp_ids (
                                    TenantId varchar(255) NOT NULL, 
                                    TranDistributionId int NOT NULL
                                         )

ON COMMIT PRESERVE ROWS 

ORDER BY TenantId ,
         TranDistributionId

SEGMENTED BY HASH(TenantId,TranDistributionId) ALL NODES KSAFE 1 ;

ALTER TABLE tmp_ids ADD PRIMARY KEY (TenantId,TranDistributionId) ;

INSERT /*+direct*/ INTO tmp_ids

SELECT 
TenantId,
TranDistributionId
FROM    (SELECT
        ids.TenantId,
        ids.TranDistributionId,
        row_number() over (partition by ids.TenantId, ids.TranDistributionId) RowNumber
        from (
                         select TenantId, TranDistributionId from out_transactions where (TenantId,classid) in (select TenantId, TableEntryId from tmp_tableentry where _sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr#tmp_tableentry']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_tableentry']}','yyyy-mm-dd hh24:mi:ss.us'))
               union all select TenantId, TranDistributionId from out_transactions where (TenantId,TransactionCode1Id) in (select TenantId, TableEntryId from tmp_tableentry where _sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr#tmp_tableentry']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_tableentry']}','yyyy-mm-dd hh24:mi:ss.us'))
               union all select TenantId, TranDistributionId from out_transactions where (TenantId,TransactionCode2Id) in (select TenantId, TableEntryId from tmp_tableentry where _sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr#tmp_tableentry']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_tableentry']}','yyyy-mm-dd hh24:mi:ss.us'))
               union all select TenantId, TranDistributionId from out_transactions where (TenantId,TransactionCode3Id) in (select TenantId, TableEntryId from tmp_tableentry where _sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr#tmp_tableentry']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_tableentry']}','yyyy-mm-dd hh24:mi:ss.us'))
               union all select TenantId, TranDistributionId from out_transactions where (TenantId,TransactionCode4Id) in (select TenantId, TableEntryId from tmp_tableentry where _sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr#tmp_tableentry']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_tableentry']}','yyyy-mm-dd hh24:mi:ss.us'))
               union all select TenantId, TranDistributionId from out_transactions where (TenantId,TransactionCode5Id) in (select TenantId, TableEntryId from tmp_tableentry where _sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr#tmp_tableentry']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_tableentry']}','yyyy-mm-dd hh24:mi:ss.us'))
               union all select TenantId, TranDistributionId from out_transactions where (TenantId,AddedById) in (select TenantId, UserId from tmp_user where _sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr#tmp_user']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_user']}','yyyy-mm-dd hh24:mi:ss.us'))
               union all select TenantId, TranDistributionId from out_transactions where (TenantId,LastChangedById) in (select TenantId, UserId from tmp_user where _sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr#tmp_user']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['tmp_user']}','yyyy-mm-dd hh24:mi:ss.us'))
               union all select TenantId, TranDistributionId from out_transactions where (_sys_updated_at > nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr#out_transactions']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01') and _sys_updated_at <= to_timestamp('${LAST_TMP_TS['out_transactions']}','yyyy-mm-dd hh24:mi:ss.us'))
              ) ids 
        ) as SourceTable

where RowNumber = 1

;

truncate table wrk_out_transactions_attr;

insert /*+ direct */ into wrk_out_transactions_attr 
                        (TenantId,
                         PostStatusTranslation,
                         PostDate,
                         TransactionTypeTranslation,
                         EncumbranceStatusTranslation,
                         TransactionCode1,
                         TransactionCode1IsActive,
                         TransactionCode2,
                         TransactionCode2IsActive,
                         TransactionCode3,
                         TransactionCode3IsActive,
                         TransactionCode4,
                         TransactionCode4IsActive,
                         TransactionCode5,
                         TransactionCode5IsActive,
                         DateAdded,
                         DateChanged,
                         TransactionAttrDistributionId,
                         TransactionId,
                         AddedByUserNameId,
                         AddedByUserName,
                         LastChangedByUserName,
                         Class,
                         TransactionAttributeId,
                         IsBeginningBalance,
                         _sys_is_deleted,
                         _sys_hash)
select
ij.TenantId,
ij.PostStatusTranslation,
ij.PostDate,
ij.TransactionTypeTranslation,
ij.EncumbranceStatusTranslation,
ij.TransactionCode1,
ij.TransactionCode1IsActive,
ij.TransactionCode2,
ij.TransactionCode2IsActive,
ij.TransactionCode3,
ij.TransactionCode3IsActive,
ij.TransactionCode4,
ij.TransactionCode4IsActive,
ij.TransactionCode5,
ij.TransactionCode5IsActive,
ij.DateAdded,
ij.DateChanged,
ij.TransactionAttrDistributionId,
ij.TransactionId,
ij.AddedByUserNameId,
ij.AddedByUserName,
ij.LastChangedByUserName,
ij.Class,
ij.TransactionAttributeId,
ij.IsBeginningBalance,
ij._sys_is_deleted,
md5(
    --COALESCE((TenantId)::VARCHAR(1000),'') || '|' ||
    COALESCE((PostStatusTranslation)::VARCHAR(1000),'') || '|' ||
    COALESCE((PostDate)::VARCHAR(1000),'') || '|' ||
    COALESCE((TransactionTypeTranslation)::VARCHAR(1000),'') || '|' ||
    COALESCE((EncumbranceStatusTranslation)::VARCHAR(1000),'') || '|' ||
    COALESCE((TransactionCode1)::VARCHAR(1000),'') || '|' ||
    COALESCE((TransactionCode1IsActive)::VARCHAR(1000),'') || '|' ||
    COALESCE((TransactionCode2)::VARCHAR(1000),'') || '|' ||
    COALESCE((TransactionCode2IsActive)::VARCHAR(1000),'') || '|' ||
    COALESCE((TransactionCode3)::VARCHAR(1000),'') || '|' ||
    COALESCE((TransactionCode3IsActive)::VARCHAR(1000),'') || '|' ||
    COALESCE((TransactionCode4)::VARCHAR(1000),'') || '|' ||
    COALESCE((TransactionCode4IsActive)::VARCHAR(1000),'') || '|' ||
    COALESCE((TransactionCode5)::VARCHAR(1000),'') || '|' ||
    COALESCE((TransactionCode5IsActive)::VARCHAR(1000),'') || '|' ||
    COALESCE((DateAdded)::VARCHAR(1000),'') || '|' ||
    COALESCE((DateChanged)::VARCHAR(1000),'') || '|' ||
    --COALESCE((TransactionAttrDistributionId)::VARCHAR(1000),'') || '|' ||
    COALESCE((TransactionId)::VARCHAR(1000),'') || '|' ||
    COALESCE((AddedByUserNameId)::VARCHAR(1000),'') || '|' ||
    COALESCE((AddedByUserName)::VARCHAR(1000),'') || '|' ||
    COALESCE((LastChangedByUserName)::VARCHAR(1000),'') || '|' ||
    COALESCE((Class)::VARCHAR(1000),'') || '|' ||
    COALESCE((TransactionAttributeId)::VARCHAR(1000),'') || '|' ||
    COALESCE((IsBeginningBalance)::VARCHAR(1000),'')
    ) as _sys_hash
from (
        select
        t.TenantId as "TenantId",
        t.PostStatusTranslation::VARCHAR(512) as "PostStatusTranslation",
        t.PostDate  as "PostDate",
        t.TransactionTypeTranslation::VARCHAR(512) as "TransactionTypeTranslation",
        t.EncumbranceStatusTranslation::VARCHAR(512) as "EncumbranceStatusTranslation",
        tc1.Description as "TransactionCode1",
        case when tc1.IsActive then 'Active'
            else 'Inactive' end as "TransactionCode1IsActive",
        tc2.Description as "TransactionCode2",
        case when tc2.IsActive then 'Active'
            else 'Inactive' end as "TransactionCode2IsActive",
        tc3.Description as "TransactionCode3",
        case when tc3.IsActive then 'Active'
            else 'Inactive' end as "TransactionCode3IsActive",
        tc4.Description as "TransactionCode4",
        case when tc4.IsActive then 'Active'
            else 'Inactive' end as "TransactionCode4IsActive",
        tc5.Description as "TransactionCode5",
        case when tc5.IsActive then 'Active'
            else 'Inactive' end as "TransactionCode5IsActive",
        t.DateAdded  as "DateAdded",
        t.DateChanged  as "DateChanged",
        t.TranDistributionId::VARCHAR(512) as "TransactionAttrDistributionId",
        t.TransactionId::VARCHAR(512) as "TransactionId",
        t.AddedById::VARCHAR(512) as "AddedByUserNameId",
        au.Name::VARCHAR(512) as "AddedByUserName",
        eu.Name::VARCHAR(512) as "LastChangedByUserName",
        c.Description::VARCHAR(512) as "Class",
        t.TransactionId::VARCHAR(512) as "TransactionAttributeId",
        'false'::VARCHAR(512) as "IsBeginningBalance",
        t._sys_is_deleted
        from (
                select
                trans.TenantId,
                trans.TransactionTypeTranslation,
                EncumbranceStatusTranslation,
                AddedById,
                DateAdded,
                LastChangedById,
                DateChanged,
                BatchId,
                PostStatusTranslation,
                AccountId,
                PostDate,
                FiscalPeriodId,
                GrantId,
                trans.TranDistributionId,
                TransactionId,
                Projectid,
                ClassId,
                TDAmount,
                TransactionCode1Id,
                TransactionCode2Id,
                TransactionCode3Id,
                TransactionCode4Id,
                TransactionCode5Id,
                _sys_is_deleted,
                _sys_hash,
                _sys_updated_at
                from out_transactions trans
                INNER JOIN tmp_ids ids ON ids.TenantId = trans.TenantId
                                      AND ids.TranDistributionId = trans.TranDistributionId
                ) as t
                join stg_csv_user_merge au
                    on t.AddedById = au.UserId
                    and t.TenantId = au.TenantId
                    and au._sys_is_deleted = false
                join stg_csv_user_merge eu
                    on t.LastChangedById = eu.UserId
                    and t.TenantId = eu.TenantId
                    and eu._sys_is_deleted = false
                left join stg_csv_tableentry_merge tc1 on t.TransactionCode1Id = tc1.TableEntryId
                                                      and t.TenantId = tc1.TenantId
                                                      and tc1._sys_is_deleted = false
                left join stg_csv_tableentry_merge tc2 on t.TransactionCode2Id = tc2.TableEntryId
                                                      and t.TenantId = tc2.TenantId
                                                      and tc2._sys_is_deleted = false
                left join stg_csv_tableentry_merge tc3 on t.TransactionCode3Id = tc3.TableEntryId
                                                      and t.TenantId = tc3.TenantId
                                                      and tc3._sys_is_deleted = false
                left join stg_csv_tableentry_merge tc4 on t.TransactionCode4Id = tc4.TableEntryId
                                                      and t.TenantId = tc4.TenantId
                                                      and tc4._sys_is_deleted = false
                left join stg_csv_tableentry_merge tc5 on t.TransactionCode5Id = tc5.TableEntryId
                                                      and t.TenantId = tc5.TenantId
                                                      and tc5._sys_is_deleted = false
                left join stg_csv_tableentry_merge c on t.ClassId = c.TableEntryId
                                                    and t.TenantId = c.TenantId
                                                    and c._sys_is_deleted = false
    ) ij ;

insert /*+ direct */ into wrk_out_transactions_attr
                        (TenantId,
                         PostStatusTranslation,
                         PostDate,
                         TransactionTypeTranslation,
                         EncumbranceStatusTranslation,
                         TransactionCode1,
                         TransactionCode1IsActive,
                         TransactionCode2,
                         TransactionCode2IsActive,
                         TransactionCode3,
                         TransactionCode3IsActive,
                         TransactionCode4,
                         TransactionCode4IsActive,
                         TransactionCode5,
                         TransactionCode5IsActive,
                         DateAdded,
                         DateChanged,
                         TransactionAttrDistributionId,
                         TransactionId,
                         AddedByUserNameId,
                         AddedByUserName,
                         LastChangedByUserName,
                         Class,
                         TransactionAttributeId,
                         IsBeginningBalance,
                         _sys_is_deleted,
                         _sys_hash)
select 
ij.TenantId,
ij.PostStatusTranslation,
ij.PostDate,
ij.TransactionTypeTranslation,
ij.EncumbranceStatusTranslation,
ij.TransactionCode1,
ij.TransactionCode1IsActive,
ij.TransactionCode2,
ij.TransactionCode2IsActive,
ij.TransactionCode3,
ij.TransactionCode3IsActive,
ij.TransactionCode4,
ij.TransactionCode4IsActive,
ij.TransactionCode5,
ij.TransactionCode5IsActive,
ij.DateAdded,
ij.DateChanged,
ij.TransactionAttrDistributionId,
ij.TransactionId,
ij.AddedByUserNameId,
ij.AddedByUserName,
ij.LastChangedByUserName,
ij.Class,
ij.TransactionAttributeId,
ij.IsBeginningBalance,
ij._sys_is_deleted,
md5(
--COALESCE((TenantId)::VARCHAR(1000),'') || '|' ||
COALESCE((PostStatusTranslation)::VARCHAR(1000),'') || '|' ||
COALESCE((PostDate)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionTypeTranslation)::VARCHAR(1000),'') || '|' ||
COALESCE((EncumbranceStatusTranslation)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode1)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode1IsActive)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode2)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode2IsActive)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode3)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode3IsActive)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode4)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode4IsActive)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode5)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionCode5IsActive)::VARCHAR(1000),'') || '|' ||
COALESCE((DateAdded)::VARCHAR(1000),'') || '|' ||
COALESCE((DateChanged)::VARCHAR(1000),'') || '|' ||
--COALESCE((TransactionAttrDistributionId)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionId)::VARCHAR(1000),'') || '|' ||
COALESCE((AddedByUserNameId)::VARCHAR(1000),'') || '|' ||
COALESCE((AddedByUserName)::VARCHAR(1000),'') || '|' ||
COALESCE((LastChangedByUserName)::VARCHAR(1000),'') || '|' ||
COALESCE((Class)::VARCHAR(1000),'') || '|' ||
COALESCE((TransactionAttributeId)::VARCHAR(1000),'') || '|' ||
COALESCE((IsBeginningBalance)::VARCHAR(1000),'')
) as _sys_hash  
from (
select
    t.TenantId as "TenantId"
    ,t.PostStatusTranslation::VARCHAR(512) as "PostStatusTranslation"
    ,t.PostDate as "PostDate"
    ,t.TransactionTypeTranslation::VARCHAR(512) as "TransactionTypeTranslation"
    ,t.EncumbranceStatusTranslation::VARCHAR(512) as "EncumbranceStatusTranslation"
    ,tc1.Description::VARCHAR(512) as "TransactionCode1"
    ,case when tc1.IsActive then 'Active' else 'Inactive' end as "TransactionCode1IsActive"
    ,tc2.Description::VARCHAR(512) as "TransactionCode2"
    ,case when tc2.IsActive then 'Active' else 'Inactive' end as "TransactionCode2IsActive"
    ,tc3.Description::VARCHAR(512) as "TransactionCode3"
    ,case when tc3.IsActive then 'Active' else 'Inactive' end as "TransactionCode3IsActive"
    ,tc4.Description::VARCHAR(512) as "TransactionCode4"
    ,case when tc4.IsActive then 'Active' else 'Inactive' end as "TransactionCode4IsActive"
    ,tc5.Description::VARCHAR(512) as "TransactionCode5"
    ,case when tc5.IsActive then 'Active' else 'Inactive' end as "TransactionCode5IsActive"
    ,cast(null as varchar(255))  as "DateAdded"
    ,cast(null as varchar(255))  as "DateChanged"
    ,(1000000000000 + t.SummaryId)::VARCHAR(512) as "TransactionAttrDistributionId"
    ,(1000000000000 + t.SummaryId)::VARCHAR(512) as "TransactionId"
    ,null::VARCHAR(512) as "AddedByUserNameId"
    ,null::VARCHAR(512) as "AddedByUserName"
    ,null::VARCHAR(512) as "LastChangedByUserName"
    ,t.Class::VARCHAR(512) as "Class"
    ,(1000000000000 + t.SummaryId)::VARCHAR(512) as "TransactionAttributeId"
    ,'true'::VARCHAR(512) as "IsBeginningBalance"
    ,t._sys_is_deleted
from stg_csv_summarizedtransaction_merge t
left join stg_csv_tableentry_merge tc1 on t.TransactionCode1 = tc1.TableEntryId and t.TenantId = tc1.TenantId and tc1._sys_is_deleted = false
left join stg_csv_tableentry_merge tc2 on t.TransactionCode2 = tc2.TableEntryId and t.TenantId = tc2.TenantId and tc2._sys_is_deleted = false
left join stg_csv_tableentry_merge tc3 on t.TransactionCode3 = tc3.TableEntryId and t.TenantId = tc3.TenantId and tc3._sys_is_deleted = false
left join stg_csv_tableentry_merge tc4 on t.TransactionCode4 = tc4.TableEntryId and t.TenantId = tc4.TenantId and tc4._sys_is_deleted = false
left join stg_csv_tableentry_merge tc5 on t.TransactionCode5 = tc5.TableEntryId and t.TenantId = tc5.TenantId and tc5._sys_is_deleted = false
) ij;

#{consolidate(param_definition_file="out_transactions_attr.json")}

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions_attr','out_transactions','tmp_finish',now(),nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr#out_transactions']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['out_transactions']}','yyyy-mm-dd hh24:mi:ss.us'));

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions_attr','tmp_user','tmp_finish',now(),nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr#tmp_user']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['tmp_user']}','yyyy-mm-dd hh24:mi:ss.us'));

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions_attr','tmp_tableentry','tmp_finish',now(),nvl(to_timestamp(nullif('${PREV_TMP_TS['out_transactions_attr#tmp_tableentry']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TMP_TS['tmp_tableentry']}','yyyy-mm-dd hh24:mi:ss.us'));
