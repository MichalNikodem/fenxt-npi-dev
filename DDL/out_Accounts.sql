drop table if exists out_Accounts;
drop table if exists wrk_out_Accounts;
drop table if exists wrk_out_Accounts_diff;

CREATE TABLE out_Accounts
(
    TenantId varchar(512) encoding rle,
    AccountId varchar(512),
    AccountNumber varchar(512),
    AccountDescription varchar(512),
    AccountCategory varchar(512),
    AccountCategoryTranslation varchar(512),
    FundDescription varchar(512),
    Class varchar(512),
    StatusTranslation varchar(512),
    AccountCodeDescription varchar(512),
    DateAdded varchar(512),
    DateChanged varchar(512),
    AddedByUserId varchar(512),
    AddedByUserName varchar(512),
    AddedByUserNameLabel varchar(512),
    ChangedByUserId varchar(512),
    ChangedByUserName varchar(512),
    ChangedByUserNameLabel varchar(512),
    AccountDateId varchar(512),
    IsContra varchar(512),
    Dummy varchar(512),
    accountsegment1 varchar(512),
    accountsegment2 varchar(512),
    accountsegment3 varchar(512),
    accountsegment4 varchar(512),
    accountsegment5 varchar(512),
    accountsegment6 varchar(512),
    accountsegment7 varchar(512),
    accountsegment8 varchar(512),
    accountsegment9 varchar(512),
    accountsegment10 varchar(512),
    _sys_hash varchar(32),
    _sys_is_deleted boolean,
    _sys_updated_at timestamp
)  ORDER BY TenantId,
            AccountId,
            _sys_hash,
            _sys_is_deleted

SEGMENTED BY hash(out_Accounts.TenantId,out_Accounts.AccountId) ALL NODES KSAFE 1;

CREATE TABLE wrk_out_Accounts LIKE out_Accounts INCLUDING PROJECTIONS;
CREATE TABLE wrk_out_Accounts_diff LIKE out_Accounts INCLUDING PROJECTIONS;