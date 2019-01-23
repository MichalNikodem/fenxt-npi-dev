CREATE OR REPLACE VIEW rename_data_maql

as

SELECT

pid as source_identifier,
maql

FROM out_ClientTranslation Translation
join _sys_clientid_pid_tmp b on Translation.tenantid = b.output_stage_cid
                            and Translation._sys_is_Deleted = false
                            and _sys_updated_at >= now()-3;