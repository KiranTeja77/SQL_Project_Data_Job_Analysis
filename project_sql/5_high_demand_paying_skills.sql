-- with skill_demand as(
--     select sd.skill_id,
--         sd.skills,
--         count(jpf.job_id) as demand_count
--     from job_postings_fact as jpf
--         inner join skills_job_dim as sjd on sjd.job_id = jpf.job_id
--         inner join skills_dim as sd on sd.skill_id = sjd.skill_id
--     where jpf.job_title_short = 'Data Analyst'
--         and jpf.salary_year_avg is not null
--     group BY sd.skill_id
-- ),
-- skill_salary as(
--     select sjd.skill_id,
--         round(avg(salary_year_avg), 0) as avg_salary
--     from job_postings_fact as jpf
--         inner join skills_job_dim as sjd on sjd.job_id = jpf.job_id
--         inner join skills_dim as sd on sd.skill_id = sjd.skill_id
--     where jpf.job_title_short = 'Data Analyst'
--         and salary_year_avg is not null
--         and job_work_from_home = True
--     group BY sjd.skill_id
-- )
-- select sd.skill_id,
--     sd.skills,
--     demand_count,
--     avg_salary
-- from skill_demand as sd
--     inner join skill_salary as ss on sd.skill_id = ss.skill_id
-- where demand_count >= 10
-- order by demand_count desc,
--     avg_salary DESC
-- limit 25;
--
--
--
select sd.skill_id,
    sd.skills,
    count(sjd.job_id) as demand_count,
    round(avg(jpf.salary_year_avg), 0) as avg_salary
from job_postings_fact as jpf
    inner join skills_job_dim as sjd on sjd.job_id = jpf.job_id
    inner join skills_dim as sd on sd.skill_id = sjd.skill_id
where jpf.job_title_short = 'Data Analyst'
    and jpf.job_work_from_home is True
    and jpf.salary_year_avg is not null
group by sd.skill_id
order by demand_count desc,
    avg_salary desc
limit 25;