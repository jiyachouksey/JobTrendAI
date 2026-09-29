CREATE TABLE jobs (
    job_title VARCHAR(255),
    job_category VARCHAR(100),
    company_name VARCHAR(255),
    company_size VARCHAR(100),
    industry VARCHAR(150),
    company_type VARCHAR(100),
    location_city VARCHAR(100),
    location_state VARCHAR(100),
    location_country VARCHAR(100),
    work_mode VARCHAR(50),
    salary_minimum INT,
    salary_maximum INT,
    salary_currency VARCHAR(20),
    stipend_amount INT,
    experience_level VARCHAR(100),
    experience_required VARCHAR(50),
    education_required VARCHAR(255),
    employment_type VARCHAR(100),
    contract_type VARCHAR(100),
    skills_extracted TEXT,
    skill_count INT,
    job_description TEXT,
    posted_date DATE,
    application_deadline DATE,
    source_platform VARCHAR(100),
    applicant_count INT,
    job_benefits TEXT,
    technical_domain VARCHAR(100),
    interview_difficulty VARCHAR(50),
    probation_period VARCHAR(50),
    shift_type VARCHAR(50),
    is_active BOOLEAN,
    career_growth_index DECIMAL(5,2)
);
LOAD DATA LOCAL INFILE 'C:/Users/jiyac/OneDrive/Desktop/JobTrendAI/cleaned csv data/JobTrend_cleaned.csv'
INTO TABLE jobs
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM jobs;
SELECT job_title, job_category, company_name, company_size
FROM jobs
LIMIT 5;
SELECT COUNT(*) FROM jobs;
SELECT job_category, COUNT(*) AS job_count
FROM jobs
GROUP BY job_category
ORDER BY job_count DESC;
SELECT job_category, 
       ROUND(AVG(salary_minimum), 0) AS avg_min_salary,
       ROUND(AVG(salary_maximum), 0) AS avg_max_salary
FROM jobs
GROUP BY job_category
ORDER BY avg_max_salary DESC;
SELECT job_category, experience_level, COUNT(*) AS job_count
FROM jobs
GROUP BY job_category, experience_level
ORDER BY job_category, experience_level;
SELECT
    TRIM(SUBSTRING_INDEX(skills_extracted, ',', 1)) AS skill,
    COUNT(*) AS job_count
FROM jobs
GROUP BY skill
ORDER BY job_count DESC;
SELECT 
    TRIM(skill) AS skill,
    COUNT(*) AS job_count
FROM jobs,
JSON_TABLE(
    CONCAT('["', REPLACE(skills_extracted, ', ', '","'), '"]'),
    '$[*]' COLUMNS(skill VARCHAR(100) PATH '$')
) AS skills
GROUP BY skill
ORDER BY job_count DESC;
SELECT location_city, COUNT(*) AS job_count
FROM jobs
GROUP BY location_city
ORDER BY job_count DESC;
SELECT work_mode, COUNT(*) AS job_count
FROM jobs
GROUP BY work_mode
ORDER BY job_count DESC;
SELECT 
    DATE_FORMAT(posted_date, '%Y-%m') AS month,
    COUNT(*) AS job_count
FROM jobs
GROUP BY month
ORDER BY month;
SELECT
    TRIM(skill) AS skill,
    COUNT(*) AS job_count
FROM jobs,
JSON_TABLE(
    CONCAT('["', REPLACE(skills_extracted, ', ', '","'), '"]'),
    '$[*]' COLUMNS(skill VARCHAR(100) PATH '$')
) AS s
WHERE job_category = 'Data Science'
GROUP BY skill
ORDER BY job_count DESC;
SELECT
    job_category,
    COUNT(*) AS fresher_jobs,
    ROUND(AVG(salary_minimum), 0) AS avg_min_salary,
    ROUND(AVG(salary_maximum), 0) AS avg_max_salary
FROM jobs
WHERE experience_level = 'Freshers / Entry Level'
GROUP BY job_category
ORDER BY fresher_jobs DESC;