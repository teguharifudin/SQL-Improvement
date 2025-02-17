# SQL Improvement
SQL query improvement that produces a search result with MySQL using Vagrant.

## Performance Improvements Made

1. **Simplified Aliases:**
   
   Used shorter, more readable aliases (e.g., j for jobs, jc for job_categories). This makes the query much easier to read and understand. Avoid excessively long aliases.

2. **Moved publish_status and deleted checks:**
   
   The conditions j.publish_status = 1 and j.deleted IS NULL are now placed directly in the WHERE clause. This is generally more efficient than having them inside the larger OR condition, as the database can filter on these simple conditions first, reducing the number of rows that need to be checked against the more complex OR conditions and EXISTS subqueries.

3. **Replaced LEFT JOINs with EXISTS:**
   
   We only need to check for existence: The query is primarily filtering data based on whether related records exist in other tables.

4. **Indexes:**
   
   Indexes are the most important optimization for database queries and will likely have the biggest impact on performance.

5. **Full-Text Search:**
   
   It frequently searching on text fields like description, detail, name, etc., consider using MySQL's full-text search capabilities. This can be significantly faster than LIKE '%...%'.

## How to Run

1. Git clone in Terminal:
   ```bash
   git clone https://github.com/teguharifudin/SQL-Improvement.git
2. Local:
   ```bash
   cd SQL-Improvement
3. Run:
   ```bash
   vagrant up
4. SSH into VM:
   ```bash
   vagrant ssh
5. Test the queries:
   ```bash
   cd /vagrant/scripts && ./setup.sh
6. Connect to MySQL:
   ```bash
   mysql test_db
7. Inside MySQL:
   ```bash
   mysql> SHOW TABLES;
   mysql> DESCRIBE job_categories;
   mysql> DESCRIBE job_types;
   mysql> DESCRIBE jobs;
   mysql> SHOW INDEX FROM jobs;
   mysql> SELECT * FROM job_categories;
   mysql> SELECT * FROM job_types;
   mysql> SELECT * FROM jobs;
