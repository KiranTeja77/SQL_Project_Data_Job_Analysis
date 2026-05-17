select job_id,
    job_title,
    name as company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date::DATE
from job_postings_fact
    left join company_dim ON job_postings_fact.company_id = company_dim.company_id
where job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg is not NULL
order BY salary_year_avg desc
limit 10;