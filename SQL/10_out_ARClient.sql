truncate table wrk_out_ARClients;
insert /*+ direct */ into wrk_out_ARClients (TenantId,
                                          ARClientId,
                                          ARClientType,
                                          ARClientDisplayName,
                                          ARClientCFDANumber,
                                          AddedByUserId,
                                          dateadded,
                                          datechanged,
                                          Amount,
                                          Name,
                                          _sys_hash,
                                          _sys_is_deleted)


SELECT

TenantId,
ARClientId,
ARClientType ,
ARClientDisplayName,
ARClientCFDANumber,
AddedByUserId,
dateadded,
datechanged,
Amount,
Name,
MD5 ( COALESCE(( ARClientType )::VARCHAR(1000),'') || '|' ||
      COALESCE(( ARClientDisplayName )::VARCHAR(1000),'') || '|' ||
      COALESCE(( ARClientCFDANumber )::VARCHAR(1000),'') || '|' ||
      COALESCE(( AddedByUserId )::VARCHAR(1000),'') || '|' ||
      COALESCE(( dateadded )::VARCHAR(1000),'') || '|' ||
      COALESCE(( datechanged )::VARCHAR(1000),'') || '|' ||
      COALESCE(( Amount )::VARCHAR(1000),'') || '|' ||
      COALESCE(( Name )::VARCHAR(1000),'')
      ) as _sys_hash,
_sys_is_deleted

FROM (
      select

      C.TenantId,
      ARClientId ,
      ARClientType ,
      ARClientDisplayName,
      ARClientCFDANumber,
      AddedByUserId,
      GoodData_Date(dateadded) as dateadded,
      GoodData_Date(datechanged) as datechanged,
      A.Amount,
      au.Name::VARCHAR(512),
      FALSE as _sys_is_deleted

      from stg_csv_ARClient_merge C
      left join stg_csv_ARClientAmount_merge A on C.TenantId = A.TenantId
                                              and C.ARClientId = A.ClientId
      join stg_csv_user_merge au on C.AddedByUserId = au.UserId
                                    and C.TenantId = au.TenantId
      ) as ARClients
;
#{consolidate(param_definition_file="out_ARClients.json")}