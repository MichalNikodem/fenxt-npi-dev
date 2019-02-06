truncate table wrk_out_InvoiceDistribution;
insert /*+ direct */ into wrk_out_InvoiceDistribution 
									(TenantId,
									 InvoiceDistributionId,
									 InvoiceId,
									 AccountId,
									 ProjectId,
									 _sys_hash,
									 _sys_is_deleted
									)

SELECT 
TenantId,
InvoiceDistributionId,
InvoiceId,
AccountId,
ProjectId,
_sys_hash,
_sys_is_deleted
FROM 	(
		SELECT 
		InvoiceDistribution.TenantId,
		InvoiceDistribution.InvoiceDistributionId,
		InvoiceDistribution.InvoiceId,
		InvoiceDistribution.AccountId,
		InvoiceDistribution.ProjectId,
		MD5 (
		COALESCE(( InvoiceId )::VARCHAR(1000),'') || '|' ||
		COALESCE(( AccountId )::VARCHAR(1000),'') || '|' ||
		COALESCE(( ProjectId )::VARCHAR(1000),'') 
			) as _sys_hash,
		FALSE as _sys_is_deleted 
		FROM 	(
				SELECT
				D.TenantId::VARCHAR(512) as "TenantId",
				TD.TransactionDistributionId::VARCHAR(512) as "InvoiceDistributionId",
				D.ParentId::VARCHAR(512) as "InvoiceId",
				D.AccountsId::VARCHAR(512) as "AccountId",
				nvl(TD.ProjectId, -2)::VARCHAR(512) as "ProjectId"
				FROM stg_csv_BBDistribution_merge D
				JOIN stg_csv_BBTransactionDistribution_merge TD on D.DistributionId = TD.DistributionId 
																AND D.TenantId = TD.TenantId
				WHERE D.ParentObjectType = 268 
				  AND D.SystemMask = 4
				) as InvoiceDistribution
		) as SourceTable
;

#{consolidate(param_definition_file="out_invoicedistribution.json")}