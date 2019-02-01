drop table if exists out_ARClients;
drop table if exists wrk_out_ARClients;
drop table if exists wrk_out_ARClients_diff;

CREATE TABLE out_ARClients
(
	 TenantId varchar(255) encoding rle,
	 ARClientId varchar(255),
	 ARClientType varchar(255),
	 ARClientDisplayName varchar(255),
	 ARClientCFDANumber varchar(255),
	 AddedByUserId int,
	 dateadded varchar(255),
	 datechanged varchar(255),
	 Amount numeric,
	 Name VARCHAR(255),
	 _sys_hash varchar(32),
	 _sys_is_deleted boolean,
	 _sys_updated_at timestamp
) order by TenantId,
		   ARClientId,
		   _sys_hash,
		   _sys_is_deleted

SEGMENTED BY hash(TenantId,ARClientId) ALL NODES;

CREATE TABLE wrk_out_ARClients LIKE out_ARClients INCLUDING PROJECTIONS;
CREATE TABLE wrk_out_ARClients_diff LIKE out_ARClients INCLUDING PROJECTIONS;