# get_normalised_prescribing validates dates

    Code
      get_normalised_prescribing(con, start_date = "not-a-date")
    Condition
      Error in `get_normalised_prescribing()`:
      ! `start_date` must be a single date or "YYYY-MM-DD" string, not "not-a-date".

---

    Code
      get_normalised_prescribing(con, start_date = "2023-04-01", end_date = "2023-01-01")
    Condition
      Error in `get_normalised_prescribing()`:
      ! `start_date` (2023-04-01) must not be after `end_date` (2023-01-01).

