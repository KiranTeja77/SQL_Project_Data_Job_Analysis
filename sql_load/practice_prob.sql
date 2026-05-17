create table january_jobs as
select *
from job_postings_fact
where extract(
        month
        from job_posted_date
    ) = 1;
drop table january_jobs;
create table january_jobs as
select *
from job_postings_fact
where extract(
        month
        from job_posted_date
    ) = 1
    and extract(
        year
        from job_posted_date
    ) = 2023;
create table february_jobs as
select *
from job_postings_fact
where extract(
        month
        from job_posted_date
    ) = 2
    and extract(
        year
        from job_posted_date
    ) = 2023;
create table march_jobs as
select *
from job_postings_fact
where extract(
        month
        from job_posted_date
    ) = 3
    and extract(
        year
        from job_posted_date
    ) = 2023;
select job_posted_date as date,
    job_id as id
from january_jobs;
select job_title_short as title,
    job_location as location,
    extract(
        month
        from job_posted_date
    ) as posted_month,
    case
        when extract(
            month
            from job_posted_date
        ) = 1 then 'Jan'
        when extract(
            month
            from job_posted_date
        ) = 2 then 'Feb'
        else 'Mar'
    end as month
from job_postings_fact
where extract(
        month
        from job_posted_date
    ) <= 3
limit 10;
select *
from (
        select *
        from job_postings_fact
        where extract(
                month
                from job_posted_date
            ) = 1
    ) as january_tab
limit 10;
select company_id,
    name as company_name
from company_dim
where company_id IN (
        select company_id
        from job_postings_fact
        where job_no_degree_mention is TRUE
    ) with no_company_posts as(
        select company_id,
            count(*) as no_posts
        from job_postings_fact
        group by company_id
    )
select ncp.company_id,
    cd.name as company_name,
    ncp.no_posts
from no_company_posts as ncp
    left join company_dim as cd on ncp.company_id = cd.company_id
order by ncp.no_posts desc;
with remote_job_skills as(
    select skill_id,
        count(*) as skill_count
    from skills_job_dim as sjd
        inner join job_postings_fact as jpf on jpf.job_id = sjd.job_id
    where jpf.job_work_from_home is true
        and jpf.job_title_short = 'Data Analyst'
    group by skill_id
)
select rjs.skill_id,
    sd.skills as skill_name,
    rjs.skill_count
from remote_job_skills as rjs
    inner join skills_dim as sd on sd.skill_id = rjs.skill_id
order by rjs.skill_count desc
limit 5;
select quater.job_title_short,
    quater.job_location,
    quater.job_via,
    quater.salary_year_avg,
    quater.job_posted_date::date
from(
        select *
        from january_jobs
        union all
        select *
        from february_jobs
        union all
        select *
        from march_jobs
    ) as quater
where quater.salary_year_avg > 70000
    and quater.job_title_short = 'Data Analyst'
order BY quater.salary_year_avg desc;