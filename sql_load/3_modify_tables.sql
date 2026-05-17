select *
from company_dim
limit 100;
select job_posted_date
FROM job_postings_fact
limit 24;
select '2006-04-04'::date as date_of_birth,
    '20'::int as Age,
    'kiran' as name;
select job_title_short as title,
    job_location as location,
    job_posted_date::date as posted_date
from job_postings_fact
limit 10;
select job_title_short as title,
    job_location as location,
    job_posted_date at time zone 'UTC' at time zone 'IST' as posted_date
from job_postings_fact
limit 10;
select job_title_short as title,
    job_location as location,
    job_posted_date at time zone 'UTC' at time zone 'IST' as posted_date,
    extract(
        month
        from job_posted_date
    ) as posted_month
from job_postings_fact
limit 10;