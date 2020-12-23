UPDATE building
SET option= COALESCE(option, '') || '|FUND_PROCESS|'
WHERE id in (
    SELECT DISTINCT pb.building_id
    FROM petition_building pb
             JOIN petition p on pb.petition_id = p.id
    WHERE p.status = 'A_SUCCESS'
      AND p.petition_type = 'FUND_APPLY'
      AND p.deleted = false
);

UPDATE building
SET option= COALESCE(option, '') || '|BANKRUPT_PROCESS|'
WHERE (option not like '%|FUND_PROCESS|%' OR option is null)
  AND id in (
    SELECT DISTINCT pb.building_id
    FROM petition_building pb
             JOIN petition p on pb.petition_id = p.id
    WHERE p.status = 'A_SUCCESS'
      AND p.petition_type = 'BANKRUPT'
      AND p.deleted = false
);