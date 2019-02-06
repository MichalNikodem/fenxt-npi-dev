DROP TABLE IF EXISTS out_transactions_attr CASCADE;
DROP TABLE IF EXISTS wrk_out_transactions_attr CASCADE;
DROP TABLE IF EXISTS wrk_out_transactions_attr_diff CASCADE;

CREATE TABLE out_transactions_attr
(
    TenantId varchar(255) NOT NULL encoding rle,
    PostStatusTranslation varchar(128),
    PostDate date,
    TransactionTypeTranslation varchar(128),
    EncumbranceStatusTranslation varchar(128),
    TransactionCode1 varchar(255),
    TransactionCode1IsActive varchar(8),
    TransactionCode2 varchar(255),
    TransactionCode2IsActive varchar(8),
    TransactionCode3 varchar(255),
    TransactionCode3IsActive varchar(8),
    TransactionCode4 varchar(255),
    TransactionCode4IsActive varchar(8),
    TransactionCode5 varchar(255),
    TransactionCode5IsActive varchar(8),
    DateAdded date,
    DateChanged date,
    TransactionAttrDistributionId varchar(255) NOT NULL,
    TransactionId varchar(128),
    AddedByUserNameId varchar(128),
    AddedByUserName varchar(128),
    LastChangedByUserName varchar(128),
    Class varchar(128),
    TransactionAttributeId varchar(128),
    IsBeginningBalance varchar(128),
    _sys_is_deleted boolean,
    _sys_hash varchar(32),
    _sys_updated_at timestamp
) ORDER BY TenantId,
           TransactionAttrDistributionId,
           _sys_hash,
           _sys_is_deleted;
SEGMENTED BY hash(TenantId, TransactionAttrDistributionId) ALL NODES;

ALTER TABLE out_transactions_attr ADD CONSTRAINT out_transactions_attr_PK PRIMARY KEY (TenantId, TransactionAttrDistributionId);

CREATE TABLE wrk_out_transactions_attr like out_transactions_attr INCLUDING PROJECTIONS;
CREATE TABLE wrk_out_transactions_attr_diff like out_transactions_attr INCLUDING PROJECTIONS;