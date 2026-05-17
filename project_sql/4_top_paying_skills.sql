select skills,
    round(avg(salary_year_avg), 0) as avg_salary
from job_postings_fact as jpf
    inner join skills_job_dim as sjd on sjd.job_id = jpf.job_id
    inner join skills_dim as sd on sd.skill_id = sjd.skill_id
where jpf.job_title_short = 'Data Analyst'
    and salary_year_avg is not null
    and job_work_from_home = True
group BY skills
order by avg_salary desc
limit 25;