 
truncate table wrk_out_ClientTranslation; 
 
drop table if exists tmp_TransactionCodes; 
CREATE LOCAL TEMPORARY TABLE tmp_TransactionCodes 
                        ( 
                        TenantId                varchar(255), 
                        TransactionCode1Name    varchar(255), 
                        TransactionCode2Name    varchar(255), 
                        TransactionCode3Name    varchar(255), 
                        TransactionCode4Name    varchar(255), 
                        TransactionCode5Name    varchar(255), 
                        ProjectName             varchar(255), 
                        FundName                varchar(255), 
                        GrantName               varchar(255) 
                        ) 
ON COMMIT PRESERVE ROWS 
 
ORDER BY TenantId; 
 
INSERT /*+direct*/  INTO tmp_TransactionCodes 
                       ( 
                        TenantId 
                       ,TransactionCode1Name 
                       ,TransactionCode2Name 
                       ,TransactionCode3Name 
                       ,TransactionCode4Name 
                       ,TransactionCode5Name 
                       ,ProjectName 
                       ,FundName 
                       ,GrantName 
                       ) 
 
select 
 
TenantId, 
case when "TransactionCode1Name"='Transaction Code 1' or "TransactionCode1Name"='TransactionCode1' then 'Code 1' else "TransactionCode1Name" end as TransactionCode1Name, 
case when "TransactionCode2Name"='Transaction Code 2' or "TransactionCode2Name"='TransactionCode2' then 'Code 2' else "TransactionCode2Name" end as TransactionCode2Name, 
case when "TransactionCode3Name"='Transaction Code 3' or "TransactionCode3Name"='TransactionCode3' then 'Code 3' else "TransactionCode3Name" end as TransactionCode3Name, 
case when "TransactionCode4Name"='Transaction Code 4' or "TransactionCode4Name"='TransactionCode4' then 'Code 4' else "TransactionCode4Name" end as TransactionCode4Name, 
case when "TransactionCode5Name"='Transaction Code 5' or "TransactionCode5Name"='TransactionCode5' then 'Code 5' else "TransactionCode5Name" end as TransactionCode5Name, 
 
"ProjectName", 
"FundName", 
"GrantName" 
 
from 
     (SELECT 
      TenantId as "TenantId" 
      ,case when length(TransactionCode1Name) = 0 then 'TransactionCode1' else nvl(TransactionCode1Name,'TransactionCode1') end TransactionCode1Name 
      ,case when length(TransactionCode2Name) = 0 then 'TransactionCode2' else nvl(TransactionCode2Name,'TransactionCode2') end TransactionCode2Name 
      ,case when length(TransactionCode3Name) = 0 then 'TransactionCode3' else nvl(TransactionCode3Name,'TransactionCode3') end TransactionCode3Name 
      ,case when length(TransactionCode4Name) = 0 then 'TransactionCode4' else nvl(TransactionCode4Name,'TransactionCode4') end TransactionCode4Name 
      ,case when length(TransactionCode5Name) = 0 then 'TransactionCode5' else nvl(TransactionCode5Name,'TransactionCode5') end TransactionCode5Name 
 
      ,case when length(ProjectName) = 0 then 'Project' else nvl(ProjectName,'Project') end ProjectName 
      ,case when length(FundName) = 0 then 'Fund' else nvl(FundName,'Fund') end FundName 
      ,case when length(GrantName) = 0 then 'Grant' else nvl(GrantName,'Grant') end GrantName 
 
      from stg_csv_Tenant_merge 
      ) as TransactionCodes; 
 
INSERT /*+direct*/  INTO wrk_out_ClientTranslation 
                            ( 
                            TenantId, 
                            maql, 
                            _sys_is_deleted, 
                            _sys_hash 
                            ) 
 
SELECT 
 
TenantId, 
maql::VARCHAR(1000) as maql, 
FALSE as _sys_id_deleted, 
md5( 
    COALESCE((maql)::VARCHAR(1000),'') || '|' || 
    COALESCE((TenantId)::VARCHAR(1000),'') 
   ) as _sys_hash 
 
FROM ( 
 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactioncode1} VISUAL(TITLE "Transaction '||TransactionCode1Name||'", DESCRIPTION "Further categorization of a transaction, such as Educational Activity");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactioncode1} ALTER LABELS {label.transactions_attr.transactioncode1} VISUAL(TITLE "'||TransactionCode1Name||'", DESCRIPTION "");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactions1isactive} VISUAL(TITLE "Transaction '||TransactionCode1Name||' status", DESCRIPTION "State of the transaction code, such as Active or Inactive");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactions1isactive} ALTER LABELS {label.transactions_attr.transactions1isactive} VISUAL(TITLE "'||TransactionCode1Name||' status", DESCRIPTION "");' as Maql from tmp_TransactionCodes union all 
 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactioncode2} VISUAL(TITLE "Transaction '||TransactionCode2Name||'", DESCRIPTION "Further categorization of a transaction, such as Educational Activity");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactioncode2} ALTER LABELS {label.transactions_attr.transactioncode2} VISUAL(TITLE "'||TransactionCode2Name||'", DESCRIPTION "");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactions2isactive} VISUAL(TITLE "Transaction '||TransactionCode2Name||' status", DESCRIPTION "State of the transaction code, such as Active or Inactive");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactions2isactive} ALTER LABELS {label.transactions_attr.transactions2isactive} VISUAL(TITLE "'||TransactionCode2Name||' status", DESCRIPTION "");' as Maql from tmp_TransactionCodes union all 
 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactioncode3} VISUAL(TITLE "Transaction '||TransactionCode3Name||'", DESCRIPTION "Further categorization of a transaction, such as Educational Activity");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactioncode3} ALTER LABELS {label.transactions_attr.transactioncode3} VISUAL(TITLE "'||TransactionCode3Name||'", DESCRIPTION "");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactions3isactive} VISUAL(TITLE "Transaction '||TransactionCode3Name||' status", DESCRIPTION "State of the transaction code, such as Active or Inactive");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactions3isactive} ALTER LABELS {label.transactions_attr.transactions3isactive} VISUAL(TITLE "'||TransactionCode3Name||' status", DESCRIPTION "");' as Maql from tmp_TransactionCodes union all 
 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactioncode4} VISUAL(TITLE "Transaction '||TransactionCode4Name||'", DESCRIPTION "Further categorization of a transaction, such as Educational Activity");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactioncode4} ALTER LABELS {label.transactions_attr.transactioncode4} VISUAL(TITLE "'||TransactionCode4Name||'", DESCRIPTION "");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactions4isactive} VISUAL(TITLE "Transaction '||TransactionCode4Name||' status", DESCRIPTION "State of the transaction code, such as Active or Inactive");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactions4isactive} ALTER LABELS {label.transactions_attr.transactions4isactive} VISUAL(TITLE "'||TransactionCode4Name||' status", DESCRIPTION "");' as Maql from tmp_TransactionCodes union all 
 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactioncode5} VISUAL(TITLE "Transaction '||TransactionCode5Name||'", DESCRIPTION "Further categorization of a transaction, such as Educational Activity");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactioncode5} ALTER LABELS {label.transactions_attr.transactioncode5} VISUAL(TITLE "'||TransactionCode5Name||'", DESCRIPTION "");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactions5isactive} VISUAL(TITLE "Transaction '||TransactionCode5Name||' status", DESCRIPTION "State of the transaction code, such as Active or Inactive");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactions5isactive} ALTER LABELS {label.transactions_attr.transactions5isactive} VISUAL(TITLE "'||TransactionCode5Name||' status", DESCRIPTION "");' as Maql from tmp_TransactionCodes union all 
 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.encumbrancestatustranslation} VISUAL(TITLE "Transaction encumberance status", DESCRIPTION "Whether a transaction is encumbered or not");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.poststatustranslation} VISUAL(TITLE "Transaction post status", DESCRIPTION "State of the transaction, such as Not yet posted");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.transactions_attr.transactiontypetranslation} VISUAL(TITLE "Transaction type", DESCRIPTION "Further description of the transaction, based on its category");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.invoices_attr.invoicepaymentmethod} VISUAL(TITLE "Invoice payment method", DESCRIPTION "The payment method associated with the invoice");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.accounts.accountdescription} VISUAL(TITLE "Account description", DESCRIPTION "The full description used to identify the account");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.accounts.accountcategorytranslation} VISUAL(TITLE "Account category", DESCRIPTION "The type of account for grouping or analytics, such as Revenue");' as Maql from tmp_TransactionCodes union all 
 
      select TenantId, 'ALTER ATTRIBUTE {attr.projects.description} VISUAL(TITLE "'||ProjectName||' description", DESCRIPTION "The full description used to identify the '||ProjectName||'");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.projects.description} ALTER LABELS {label.projects.description} VISUAL(TITLE "'||ProjectName||'", DESCRIPTION "");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.projects.projecttype} VISUAL(TITLE "'||ProjectName||' type", DESCRIPTION "Further description of the '||ProjectName||', based on its category");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.projects.projecttype} ALTER LABELS {label.projects.projecttype} VISUAL(TITLE "'||ProjectName||' Type", DESCRIPTION "");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.projects.addedbyusername} VISUAL(TITLE "'||ProjectName||' added by username", DESCRIPTION "Who added the '||ProjectName||'");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.projects.department} VISUAL(TITLE "'||ProjectName||' department", DESCRIPTION "Further description of the '||ProjectName||', such as Athletics");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.projects.division} VISUAL(TITLE "'||ProjectName||' division", DESCRIPTION "Further description of the '||ProjectName||', such as Financial Aid");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.projects.projectid} VISUAL(TITLE "'||ProjectName||' : DB ID", DESCRIPTION "");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.projects.location} VISUAL(TITLE "'||ProjectName||' location", DESCRIPTION "Further description of the '||ProjectName||', such as Administration Building");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.projects.projectuserid} VISUAL(TITLE "'||ProjectName||' ID", DESCRIPTION "The ID used to identify the '||ProjectName||'");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.projects.projectstatus} VISUAL(TITLE "'||ProjectName||' status", DESCRIPTION "Whether the '||ProjectName||' is Active or Inactive");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.project_date.projectdateid} VISUAL(TITLE "'||ProjectName||' Date : ID", DESCRIPTION "");' as Maql from tmp_TransactionCodes union all 
 
      select TenantId, 'ALTER ATTRIBUTE {attr.accounts.funddescription} VISUAL(TITLE "'||FundName||'", DESCRIPTION "");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.accounts.funddescription} ALTER LABELS {label.accounts.funddescription} VISUAL(TITLE "'||FundName||'", DESCRIPTION "");' as Maql from tmp_TransactionCodes union all 
 
      select TenantId, 'ALTER ATTRIBUTE {attr.grants.grantid} VISUAL(TITLE "'||GrantName||' : ID", DESCRIPTION "");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.grants.grantsgrantid} VISUAL(TITLE "'||GrantName||' ID", DESCRIPTION "ID for the grants record in the database");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.grants.grantdescription} VISUAL(TITLE "'||GrantName||' description", DESCRIPTION "The full description used to identify the grant");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.grants.granttype} VISUAL(TITLE "'||GrantName||' type", DESCRIPTION "Further description of the grant based on its category");' as Maql from tmp_TransactionCodes union all 
      select TenantId, 'ALTER ATTRIBUTE {attr.grants.grantstatus} VISUAL(TITLE "'||GrantName||' status", DESCRIPTION "Further description of the grant, such as applied, open, or closed");' as Maql from tmp_TransactionCodes union all 
 
      select TenantId, 'ALTER FACT {fact.grants.grantamount} VISUAL(TITLE "'||GrantName||' amount", DESCRIPTION "The grants total amount");' from tmp_TransactionCodes 
      ) as Maql_DDL_1; 
 
 
INSERT /*+direct*/  INTO wrk_out_ClientTranslation 
                            ( 
                            TenantId, 
                            maql, 
                            _sys_is_deleted, 
                            _sys_hash 
                            ) 
 
SELECT 
 
TenantId, 
maql::VARCHAR(1000) as maql, 
FALSE as _sys_id_deleted, 
md5( 
    COALESCE((maql)::VARCHAR(1000),'') || '|' || 
    COALESCE((TenantId)::VARCHAR(1000),'') 
   ) as _sys_hash 
 
FROM 
      ( 
      SELECT 
 
      tenantid, 
      'ALTER ATTRIBUTE {attr.accounts.accountsegment'||SegmentId::VARCHAR||'} VISUAL(TITLE "'||SegmentName||'", DESCRIPTION "A segment of an account number");'  as maql 
 
      FROM 
           (SELECT 
 
             tenantid 
            ,SegmentId 
            ,case when SegmentName like 'Account%' then SegmentName else  concat('Account ', lower(SegmentName)) end SegmentName 
 
            FROM (select 
                  tenantid, 
                  segmentid, 
                  replace(min(segmentname),'"','') as segmentname 
                  from stg_csv_AccountSegmentValue_merge 
                  where _sys_is_Deleted = false 
                  group by tenantid, 
                           segmentid 
                  ) as SegmentValue 
            ) as MAQL_Accounts 
      ) as Maql_DDL_1 ; 
 
#{consolidate(param_definition_file="out_ClientTranslation.json")}