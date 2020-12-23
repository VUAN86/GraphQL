INSERT INTO status_history (id, status_source, status_target, petition_id, change_status_date, type)
SELECT uuid_generate_v4()
     , 'D_DRAFT'
     , 'D_DRAFT'
     , p.id
     , '2020-01-31 15:30:14.000000'
     , 'PETITION_STATUS'
FROM petition p
