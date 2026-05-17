with top_paying_jobs as (
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
    limit 10
)
select top.job_id,
    top.job_title,
    top.company_name,
    sd.skills,
    top.job_schedule_type,
    top.salary_year_avg,
    top.job_posted_date
from top_paying_jobs as top
    inner join skills_job_dim as sjd on sjd.job_id = top.job_id
    inner join skills_dim as sd on sd.skill_id = sjd.skill_id
order by salary_year_avg desc;