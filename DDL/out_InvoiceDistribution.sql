DROP TABLE IF EXISTS out_InvoiceDistribution;
DROP TABLE IF EXISTS wrk_out_InvoiceDistribution;
DROP TABLE IF EXISTS wrk_out_InvoiceDistribution_diff;

CREATE TABLE out_InvoiceDistribution
(
    TenantId varchar(512),
    InvoiceDistributionId varchar(512),
    InvoiceId varchar(512),
    AccountId varchar(512),
    ProjectId varchar(512),
    _sys_hash varchar(32),
    _sys_is_deleted boolean encoding rle,
    _sys_updated_at timestamp
)
 ORDER BY TenantId,
          InvoiceDistributionId,
          _sys_hash,
          _sys_is_deleted

SEGMENTED BY hash(out_InvoiceDistribution.TenantId,out_InvoiceDistribution.InvoiceDistributionId) ALL NODES KSAFE 1;

CREATE TABLE wrk_out_InvoiceDistribution LIKE out_InvoiceDistribution INCLUDING PROJECTIONS;
CREATE TABLE wrk_out_InvoiceDistribution_diff LIKE out_InvoiceDistribution INCLUDING PROJECTIONS;