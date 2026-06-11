# add_lookup_label generates a CASE WHEN in SQL

    Code
      add_lookup_label(lf, practice_settings, "setting", "setting_label")
    Output
      <SQL>
      SELECT
        `df`.*,
        CASE
      WHEN (`setting` = 0) THEN 'Other'
      WHEN (`setting` = 1) THEN 'WIC Practice'
      WHEN (`setting` = 2) THEN 'OOH Practice'
      WHEN (`setting` = 3) THEN 'WIC + OOH Practice'
      WHEN (`setting` = 4) THEN 'GP Practice'
      WHEN (`setting` = 8) THEN 'Public Health Service'
      WHEN (`setting` = 9) THEN 'Community Health Service'
      WHEN (`setting` = 10) THEN 'Hospital Service'
      WHEN (`setting` = 11) THEN 'Optometry Service'
      WHEN (`setting` = 12) THEN 'Urgent & Emergency Care'
      WHEN (`setting` = 13) THEN 'Hospice'
      WHEN (`setting` = 14) THEN 'Care Home / Nursing Home'
      WHEN (`setting` = 15) THEN 'Border Force'
      WHEN (`setting` = 16) THEN 'Young Offender Institution'
      WHEN (`setting` = 17) THEN 'Secure Training Centre'
      WHEN (`setting` = 18) THEN 'Secure Children''s Home'
      WHEN (`setting` = 19) THEN 'Immigration Removal Centre'
      WHEN (`setting` = 20) THEN 'Court'
      WHEN (`setting` = 21) THEN 'Police Custody'
      WHEN (`setting` = 22) THEN 'Sexual Assault Referral Centre (SARC)'
      WHEN (`setting` = 24) THEN 'Other - Justice Estate'
      WHEN (`setting` = 25) THEN 'Prison'
      WHEN (`setting` = 26) THEN 'Primary Care Network'
      WHEN (`setting` = 27) THEN 'Independent Pharmacy'
      END AS `setting_label`
      FROM `df`

