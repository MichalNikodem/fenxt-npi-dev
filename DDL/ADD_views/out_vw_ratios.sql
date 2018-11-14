CREATE OR REPLACE VIEW out_vw_ratios AS
SELECT
	EncumbranceStatus::VARCHAR(512) as "a__ratiosencumbrance",
	PostStatus::VARCHAR(512) as "a__ratiospoststatus",
	CashCoverageCurrentAssets::NUMERIC(15,2) as "f__ratioscashcoverage",
	CashCoverageExpense::NUMERIC(15,2) as "f__ratioscashcoverageexpense",
	CurrentAssets::NUMERIC(15,2) as "f__ratioscurrentasset",
	CurrentLiability::NUMERIC(15,2) as "f__ratioscurrentliability",
	QuickRatio::NUMERIC(15,2) as "f__ratiosquickr",
	EncumbranceStatusTranslation::VARCHAR(512) as "l__ratiosencumbrance__ratiosencumbrancestatustranslation",
	PostStatusTranslation::VARCHAR(512) as "l__ratiospoststatus__ratiospoststatustranslation",
	FiscalPeriodId::VARCHAR(512) as "r__fiscalperiods",
	TenantId::VARCHAR(128) as x__client_id
FROM out_Ratios
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Ratios')
;