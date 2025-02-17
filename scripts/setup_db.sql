-- Enable strict mode and utf8mb4 encoding
SET sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SET NAMES utf8mb4;

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS jobs_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Create database
CREATE DATABASE IF NOT EXISTS test_db;
USE test_db;

-- Create table
CREATE TABLE IF NOT EXISTS personalities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    deleted BOOLEAN
);

CREATE TABLE IF NOT EXISTS practical_skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    deleted BOOLEAN
);

CREATE TABLE IF NOT EXISTS basic_abilities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    deleted BOOLEAN
);

CREATE TABLE IF NOT EXISTS affiliates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type INT,  -- e.g., 1 for Tools, 2 for Qualifications, 3 for Career Paths
    name VARCHAR(255),
    deleted BOOLEAN
);

CREATE TABLE IF NOT EXISTS job_categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    sort_order INT,
    created_by INT,
    created TIMESTAMP,
    modified TIMESTAMP,
    deleted BOOLEAN
);

CREATE TABLE IF NOT EXISTS job_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    job_category_id INT,
    sort_order INT,
    created_by INT,
    created TIMESTAMP,
    modified TIMESTAMP,
    deleted BOOLEAN,
    FOREIGN KEY (job_category_id) REFERENCES job_categories(id)
);

CREATE TABLE IF NOT EXISTS jobs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    media_id INT,
    job_category_id INT,
    job_type_id INT,
    description TEXT,
    detail TEXT,
    business_skill TEXT,
    knowledge TEXT,
    location VARCHAR(255),
    activity TEXT,
    academic_degree_doctor BOOLEAN,
    academic_degree_master BOOLEAN,
    academic_degree_professional BOOLEAN,
    academic_degree_bachelor BOOLEAN,
    salary_statistic_group VARCHAR(255),
    salary_range_first_year VARCHAR(255),
    salary_range_average VARCHAR(255),
    salary_range_remarks TEXT,
    restriction TEXT,
    estimated_total_workers INT,
    remarks TEXT,
    url VARCHAR(255),
    seo_description TEXT,
    seo_keywords TEXT,
    sort_order INT,
    publish_status INT,
    version INT,
    created_by INT,
    created TIMESTAMP,
    modified TIMESTAMP,
    deleted BOOLEAN,
    FOREIGN KEY (job_category_id) REFERENCES job_categories(id),
    FOREIGN KEY (job_type_id) REFERENCES job_types(id)
);

CREATE TABLE IF NOT EXISTS jobs_personalities (
    job_id INT,
    personality_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(id),
    FOREIGN KEY (personality_id) REFERENCES personalities(id),
    PRIMARY KEY (job_id, personality_id)
);

CREATE TABLE IF NOT EXISTS jobs_practical_skills (
    job_id INT,
    practical_skill_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(id),
    FOREIGN KEY (practical_skill_id) REFERENCES practical_skills(id),
    PRIMARY KEY (job_id, practical_skill_id)
);

CREATE TABLE IF NOT EXISTS jobs_basic_abilities (
    job_id INT,
    basic_ability_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(id),
    FOREIGN KEY (basic_ability_id) REFERENCES basic_abilities(id),
    PRIMARY KEY (job_id, basic_ability_id)
);

CREATE TABLE IF NOT EXISTS jobs_tools (
    job_id INT,
    affiliate_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(id),
    FOREIGN KEY (affiliate_id) REFERENCES affiliates(id),
    PRIMARY KEY (job_id, affiliate_id)
);

CREATE TABLE IF NOT EXISTS jobs_career_paths (
    job_id INT,
    affiliate_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(id),
    FOREIGN KEY (affiliate_id) REFERENCES affiliates(id),
    PRIMARY KEY (job_id, affiliate_id)
);

CREATE TABLE IF NOT EXISTS jobs_rec_qualifications (
    job_id INT,
    affiliate_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(id),
    FOREIGN KEY (affiliate_id) REFERENCES affiliates(id),
    PRIMARY KEY (job_id, affiliate_id)
);

CREATE TABLE IF NOT EXISTS jobs_req_qualifications (
    job_id INT,
    affiliate_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(id),
    FOREIGN KEY (affiliate_id) REFERENCES affiliates(id),
    PRIMARY KEY (job_id, affiliate_id)
);
