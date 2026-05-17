-- with remote_job_skills as(
--     select 
--         skill_id,
--         count(*) as skill_count
--     from 
--         skills_job_dim as sjd
--         inner join job_postings_fact as jpf 
--             on jpf.job_id = sjd.job_id
--     where 
--         jpf.job_work_from_home is true
--         and jpf.job_title_short = 'Data Analyst'
--     group by 
--         skill_id
-- )
-- select 
--     rjs.skill_id,
--     sd.skills as skill_name,
--     rjs.skill_count
-- from
--     remote_job_skills as rjs
--     inner join skills_dim as sd 
--         on sd.skill_id = rjs.skill_id
-- order by 
--     rjs.skill_count desc
-- limit 5;
--
--
--
select skills,
    count(jpf.job_id) as demand_count
from job_postings_fact as jpf
    inner join skills_job_dim as sjd on sjd.job_id = jpf.job_id
    inner join skills_dim as sd on sd.skill_id = sjd.skill_id
where jpf.job_title_short = 'Data Analyst'
group BY skills
order by demand_count desc
limit 5;