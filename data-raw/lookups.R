# Lookup tables for coded columns in the practices table.
# Single source of truth for the labels added by get_practices().
# Setting codes: https://www.odsdatasearchandexport.nhs.uk/referenceDataCatalogue/565791179.html#GPPractices(PrescribingCostCentres)-MappingTable-LegacyPrescribingSettingtoNonPrimaryRoleID(Field26)

practice_settings <- tibble::tribble(
  ~setting , ~setting_label                          ,
   0L      , "Other"                                 ,
   1L      , "WIC Practice"                          ,
   2L      , "OOH Practice"                          ,
   3L      , "WIC + OOH Practice"                    ,
   4L      , "GP Practice"                           ,
   8L      , "Public Health Service"                 ,
   9L      , "Community Health Service"              ,
  10L      , "Hospital Service"                      ,
  11L      , "Optometry Service"                     ,
  12L      , "Urgent & Emergency Care"               ,
  13L      , "Hospice"                               ,
  14L      , "Care Home / Nursing Home"              ,
  15L      , "Border Force"                          ,
  16L      , "Young Offender Institution"            ,
  17L      , "Secure Training Centre"                ,
  18L      , "Secure Children's Home"                ,
  19L      , "Immigration Removal Centre"            ,
  20L      , "Court"                                 ,
  21L      , "Police Custody"                        ,
  22L      , "Sexual Assault Referral Centre (SARC)" ,
  24L      , "Other - Justice Estate"                ,
  25L      , "Prison"                                ,
  26L      , "Primary Care Network"                  ,
  27L      , "Independent Pharmacy"
)

practice_statuses <- tibble::tribble(
  ~status_code , ~status_code_label ,
  "A"          , "Active"           ,
  "B"          , "Retired"          ,
  "C"          , "Closed"           ,
  "D"          , "Dormant"          ,
  "P"          , "Proposed"         ,
  "U"          , "Unknown"
)

usethis::use_data(practice_settings, practice_statuses, overwrite = TRUE)
