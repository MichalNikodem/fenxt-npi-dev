drop table if exists out_ClientTranslation;
drop table if exists wrk_out_ClientTranslation;
drop table if exists wrk_out_ClientTranslation_diff;

CREATE TABLE out_ClientTranslation
(
    TenantId varchar(255),
    maql varchar(1000),
    _sys_hash varchar(32),
    _sys_is_deleted boolean encoding rle,
    _sys_updated_at timestamp
)
 ORDER BY TenantId,
          _sys_hash,
          _sys_is_deleted

SEGMENTED BY hash(out_ClientTranslation.TenantId) ALL NODES KSAFE 1;

CREATE TABLE wrk_out_ClientTranslation LIKE out_ClientTranslation INCLUDING PROJECTIONS;
CREATE TABLE wrk_out_ClientTranslation_diff LIKE out_ClientTranslation INCLUDING PROJECTIONS;