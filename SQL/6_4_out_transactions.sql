insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions','stg_csv_transaction_merge','wrk_start',now(),nvl(to_timestamp(nullif('${PREV_TS['out_transactions#stg_csv_transaction_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS['stg_csv_transaction_merge']}','yyyy-mm-dd hh24:mi:ss.us'));

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions','stg_csv_transactiondistribution_merge','wrk_start',now(),nvl(to_timestamp(nullif('${PREV_TS['out_transactions#stg_csv_transactiondistribution_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS['stg_csv_transactiondistribution_merge']}','yyyy-mm-dd hh24:mi:ss.us'));

truncate table wrk_out_transactions;

insert /*+ direct */ into wrk_out_transactions

                                (
                                TenantId,
                                TransactionTypeTranslation,
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
                                TranDistributionId,
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
                                _sys_hash
                                )

select
ij.TenantId,
ij.TransactionTypeTranslation,
ij.EncumbranceStatusTranslation,
ij.AddedById,
ij.DateAdded,
ij.LastChangedById,
ij.DateChanged,
ij.BatchId,
ij.PostStatusTranslation,
ij.AccountId,
ij.PostDate,
ij.FiscalPeriodId,
ij.GrantId,
ij.TranDistributionId,
ij.TransactionId,
ij.Projectid,
ij.ClassId,
ij.TDAmount,
ij.TransactionCode1Id,
ij.TransactionCode2Id,
ij.TransactionCode3Id,
ij.TransactionCode4Id,
ij.TransactionCode5Id,
false as _sys_is_deleted,
md5 (
      --COALESCE((TenantId)::VARCHAR(1000),'') || '|' ||
      COALESCE((TransactionTypeTranslation)::VARCHAR(1000),'') || '|' ||
      COALESCE((EncumbranceStatusTranslation)::VARCHAR(1000),'') || '|' ||
      COALESCE((AddedById)::VARCHAR(1000),'') || '|' ||
      COALESCE((DateAdded)::VARCHAR(1000),'') || '|' ||
      COALESCE((LastChangedById)::VARCHAR(1000),'') || '|' ||
      COALESCE((DateChanged)::VARCHAR(1000),'') || '|' ||
      COALESCE((BatchId)::VARCHAR(1000),'') || '|' ||
      COALESCE((PostStatusTranslation)::VARCHAR(1000),'') || '|' ||
      COALESCE((AccountId)::VARCHAR(1000),'') || '|' ||
      COALESCE((PostDate)::VARCHAR(1000),'') || '|' ||
      COALESCE((FiscalPeriodId)::VARCHAR(1000),'') || '|' ||
      COALESCE((GrantId)::VARCHAR(1000),'') || '|' ||
      --COALESCE((TranDistributionId)::VARCHAR(1000),'') || '|' ||
      COALESCE((TransactionId)::VARCHAR(1000),'') || '|' ||
      COALESCE((Projectid)::VARCHAR(1000),'') || '|' ||
      COALESCE((ClassId)::VARCHAR(1000),'') || '|' ||
      COALESCE((TDAmount)::VARCHAR(1000),'') || '|' ||
      COALESCE((TransactionCode1Id)::VARCHAR(1000),'') || '|' ||
      COALESCE((TransactionCode2Id)::VARCHAR(1000),'') || '|' ||
      COALESCE((TransactionCode3Id)::VARCHAR(1000),'') || '|' ||
      COALESCE((TransactionCode4Id)::VARCHAR(1000),'') || '|' ||
      COALESCE((TransactionCode5Id)::VARCHAR(1000),'')
      ) as _sys_hash
from (
select
 t.TenantId
,t.TransactionTypeTranslation
,t.EncumbranceStatusTranslation
,t.AddedById
,t.DateAdded
,t.LastChangedById
,t.DateChanged
,t.BatchId
,t.PostStatusTranslation
,t.AccountId
,t.PostDate
,t.FiscalPeriodId
,td.GrantId
,td.TranDistributionId
,t.TransactionId
,td.Projectid
,td.ClassId
,td.Amount as "TDAmount"
,td.TransactionCode1Id
,td.TransactionCode2Id
,td.TransactionCode3Id
,td.TransactionCode4Id
,td.TransactionCode5Id
from stg_csv_transaction_merge t
join stg_csv_transactiondistribution_merge td on td.TransactionId = t.TransactionId
                                             and t.TenantId = td.TenantId
                                             and t._sys_is_deleted = false
                                             and td._sys_is_deleted = false
where   (t.TenantId  ,t.TransactionId) in
( select
  t.TenantId
 ,t.TransactionId
 from stg_csv_transaction_merge t
 where (t._sys_updated_at > nvl(to_timestamp(nullif('${PREV_TS['out_transactions#stg_csv_transaction_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01')
   and t._sys_updated_at <= to_timestamp('${LAST_TS['stg_csv_transaction_merge']}','yyyy-mm-dd hh24:mi:ss.us'))
union all
 select td.TenantId  ,td.TransactionId
 from stg_csv_transactiondistribution_merge td
 where (td._sys_updated_at > nvl(to_timestamp(nullif('${PREV_TS['out_transactions#stg_csv_transactiondistribution_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01')
   and td._sys_updated_at <= to_timestamp('${LAST_TS['stg_csv_transactiondistribution_merge']}','yyyy-mm-dd hh24:mi:ss.us'))
)
) ij;

#{consolidate(param_definition_file="out_transactions.json")}

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions','stg_csv_transaction_merge','wrk_finish',now(),nvl(to_timestamp(nullif('${PREV_TS['out_transactions#stg_csv_transaction_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS['stg_csv_transaction_merge']}','yyyy-mm-dd hh24:mi:ss.us'));

insert into _sys_load_info (tgt_entity,src_entity,event_type,event_ts,ts_from,ts_to)
values ('out_transactions','stg_csv_transactiondistribution_merge','wrk_finish',now(),nvl(to_timestamp(nullif('${PREV_TS['out_transactions#stg_csv_transactiondistribution_merge']}',''),'yyyy-mm-dd hh24:mi:ss.us'),'2000-01-01'),to_timestamp('${LAST_TS['stg_csv_transactiondistribution_merge']}','yyyy-mm-dd hh24:mi:ss.us'));
