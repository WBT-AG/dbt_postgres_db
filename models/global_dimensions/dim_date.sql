{{ config(
  materialized='table',
  unique_key='DateKey',
  schema='global_dimensions'
) }}

with date_range as (
  select 
    generate_series(
      '2000-01-01'::date,
      '2100-12-31'::date,
      interval '1 day'
    )::date as date
)

select
  row_number() over () as DateKey,
  date,
  extract(day from date) as Day,
  extract(month from date) as Month,
  extract(year from date) as Year,
  case extract(dow from date)
    when 0 then 'Sunday'
    when 1 then 'Monday'
    when 2 then 'Tuesday'
    when 3 then 'Wednesday'
    when 4 then 'Thursday'
    when 5 then 'Friday'
    when 6 then 'Saturday'
  end as DayName,
  case extract(month from date)
    when 1 then 'January'
    when 2 then 'February'
    when 3 then 'March'
    when 4 then 'April'
    when 5 then 'May'
    when 6 then 'June'
    when 7 then 'July'
    when 8 then 'August'
    when 9 then 'September'
    when 10 then 'October'
    when 11 then 'November'
    when 12 then 'December'
  end as MonthName,
  extract(quarter from date) as Quarter,
  extract(dow from date) in (0, 6) as IsWeekend,
  false as IsHoliday,
  extract(isoyear from date) as FiscalYear,
  extract(week from date) as WeekOfYear,
  extract(week from date) - extract(week from date_trunc('month', date)) + 1 as WeekOfMonth,
  extract(doy from date) as DayOfYear,
  case when extract(year from date) % 4 = 0 and (extract(year from date) % 100 != 0 or extract(year from date) % 400 = 0)
    then true
    else false
  end as IsLeapYear,
  to_char(date, 'IYYY-"W"IW-ID') as ISOWeekDate,
  extract(dow from date) not in (0, 6) as WorkDay,
  extract(week from date) as WorkWeek,
  null as HolidayName,
  date = date_trunc('month', date + interval '1 month - 1 day') as IsEndOfMonth,
  date_trunc('quarter', date) as QuarterStartDate,
  date_trunc('quarter', date) + interval '3 months - 1 day' as QuarterEndDate,
  case when extract(month from date) >= 9
    then extract(year from date) + 1
    else extract(year from date)
  end as AliFiscalYear,
  date_trunc('month', date) as StartOfMonth
from date_range
