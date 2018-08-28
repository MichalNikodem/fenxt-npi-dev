
-- CREATE OR REPLACE VIEW out_vw_accountsegments AS
-- SELECT
-- 	TBD::VARCHAR(512) as "cp__accountsegmentid",
-- 	TBD::VARCHAR(512) as "l__accountsegmentid__accountsegment",
-- 	TenantId::VARCHAR(128) as x__client_id
-- FROM out_TBD
-- where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_TBD');
-- ;