USE test_db;

-- Add FULLTEXT indexes (do this once, not every time you run the query)
ALTER TABLE jobs ADD FULLTEXT INDEX ft_index (name, description, detail, business_skill, knowledge, location, activity, salary_statistic_group, salary_range_remarks, restriction, remarks);
ALTER TABLE job_categories ADD FULLTEXT INDEX ft_index (name);
ALTER TABLE job_types ADD FULLTEXT INDEX ft_index (name);
ALTER TABLE personalities ADD FULLTEXT INDEX ft_index (name);
ALTER TABLE practical_skills ADD FULLTEXT INDEX ft_index (name);
ALTER TABLE basic_abilities ADD FULLTEXT INDEX ft_index (name);
ALTER TABLE affiliates ADD FULLTEXT INDEX ft_index (name);

/* Main query */
EXPLAIN ANALYZE
SELECT
    j.id AS `Jobs id`,
    j.name AS `Jobs name`,
    j.media_id AS `Jobs media id`,
    j.job_category_id AS `Jobs job_category_id`,
    j.job_type_id AS `Jobs job_type_id`,
    j.description AS `Jobs description`,
    j.detail AS `Jobs detail`,
    j.business_skill AS `Jobs business_skill`,
    j.knowledge AS `Jobs knowledge`,
    j.location AS `Jobs location`,
    j.activity AS `Jobs activity`,
    j.academic_degree_doctor AS `Jobs academic_degree_doctor`,
    j.academic_degree_master AS `Jobs academic_degree_master`,
    j.academic_degree_professional AS `Jobs academic_degree_professional`,
    j.academic_degree_bachelor AS `Jobs academic_degree_bachelor`,
    j.salary_statistic_group AS `Jobs salary_statistic_group`,
    j.salary_range_first_year AS `Jobs salary_range_first_year`,
    j.salary_range_average AS `Jobs salary_range_average`,
    j.salary_range_remarks AS `Jobs salary_range_remarks`,
    j.restriction AS `Jobs restriction`,
    j.estimated_total_workers AS `Jobs estimated_total_workers`,
    j.remarks AS `Jobs remarks`,
    j.url AS `Jobs url`,
    j.seo_description AS `Jobs seo_description`,
    j.seo_keywords AS `Jobs seo_keywords`,
    j.sort_order AS `Jobs sort_order`,
    j.publish_status AS `Jobs publish_status`,
    j.version AS `Jobs version`,
    j.created_by AS `Jobs created_by`,
    j.created AS `Jobs created`,
    j.modified AS `Jobs modified`,
    j.deleted AS `Jobs deleted`,
    jc.id AS `JobCategories id`,
    jc.name AS `JobCategories name`,
    jc.sort_order AS `JobCategories sort_order`,
    jc.created_by AS `JobCategories created_by`,
    jc.created AS `JobCategories created`,
    jc.modified AS `JobCategories modified`,
    jc.deleted AS `JobCategories deleted`,
    jt.id AS `JobTypes id`,
    jt.name AS `JobTypes name`,
    jt.job_category_id AS `JobTypes job_category_id`,
    jt.sort_order AS `JobTypes sort_order`,
    jt.created_by AS `JobTypes created_by`,
    jt.created AS `JobTypes created`,
    jt.modified AS `JobTypes modified`,
    jt.deleted AS `JobTypes deleted`
FROM jobs j
INNER JOIN job_categories jc ON j.job_category_id = jc.id AND jc.deleted IS NULL
INNER JOIN job_types jt ON j.job_type_id = jt.id AND jt.deleted IS NULL
WHERE j.publish_status = 1
  AND j.deleted IS NULL
  AND (
    MATCH (jc.name) AGAINST ('キャビンアテンダント') OR
    MATCH (jt.name) AGAINST ('キャビンアテンダント') OR
    MATCH (j.name, j.description, j.detail, j.business_skill, j.knowledge, j.location, j.activity, j.salary_statistic_group, j.salary_range_remarks, j.restriction, j.remarks) AGAINST ('キャビンアテンダント') OR
    EXISTS (SELECT 1 FROM jobs_personalities jp WHERE jp.job_id = j.id AND EXISTS (SELECT 1 FROM personalities p WHERE p.id = jp.personality_id AND MATCH (p.name) AGAINST ('キャビンアテンダント') AND p.deleted IS NULL)) OR
    EXISTS (SELECT 1 FROM jobs_practical_skills jps WHERE jps.job_id = j.id AND EXISTS (SELECT 1 FROM practical_skills ps WHERE ps.id = jps.practical_skill_id AND MATCH (ps.name) AGAINST ('キャビンアテンダント') AND ps.deleted IS NULL)) OR
    EXISTS (SELECT 1 FROM jobs_basic_abilities jba WHERE jba.job_id = j.id AND EXISTS (SELECT 1 FROM basic_abilities ba WHERE ba.id = jba.basic_ability_id AND MATCH (ba.name) AGAINST ('キャビンアテンダント') AND ba.deleted IS NULL)) OR
    EXISTS (SELECT 1 FROM jobs_tools jt2 WHERE jt2.job_id = j.id AND EXISTS (SELECT 1 FROM affiliates t WHERE t.id = jt2.affiliate_id AND t.type = 1 AND MATCH (t.name) AGAINST ('キャビンアテンダント') AND t.deleted IS NULL)) OR
    EXISTS (SELECT 1 FROM jobs_career_paths jcp WHERE jcp.job_id = j.id AND EXISTS (SELECT 1 FROM affiliates cp WHERE cp.id = jcp.affiliate_id AND cp.type = 3 AND MATCH (cp.name) AGAINST ('キャビンアテンダント') AND cp.deleted IS NULL)) OR
    EXISTS (SELECT 1 FROM jobs_rec_qualifications jrq WHERE jrq.job_id = j.id AND EXISTS (SELECT 1 FROM affiliates rq WHERE rq.id = jrq.affiliate_id AND rq.type = 2 AND MATCH (rq.name) AGAINST ('キャビンアテンダント') AND rq.deleted IS NULL)) OR
    EXISTS (SELECT 1 FROM jobs_req_qualifications jrq2 WHERE jrq2.job_id = j.id AND EXISTS (SELECT 1 FROM affiliates rq2 WHERE rq2.id = jrq2.affiliate_id AND rq2.type = 2 AND MATCH (rq2.name) AGAINST ('キャビンアテンダント') AND rq2.deleted IS NULL))
  )
GROUP BY j.id
ORDER BY j.sort_order DESC, j.id DESC
LIMIT 50 OFFSET 0;
