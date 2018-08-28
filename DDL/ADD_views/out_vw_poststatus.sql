CREATE OR REPLACE VIEW out_vw_poststatus AS
SELECT
	PostStatus::VARCHAR(512) as "a__poststatus",
	PostStatusId::VARCHAR(512) as "cp__poststatusid",
	TenantId::VARCHAR(128) as x__client_id
FROM out_PostStatus
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_PostStatus')
;