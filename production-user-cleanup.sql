-- Production User Cleanup Script
-- WARNING: This script permanently deletes user data from production database
-- Always backup data before running these commands
-- Execute these commands one by one, not all at once

-- Step 1: View users before deletion (ALWAYS run this first)
-- Replace 'user@example.com' with the actual email you want to check
SELECT 
    id, 
    email, 
    full_name,
    first_paper_generated, 
    paper_generation_count, 
    subscription_type, 
    has_active_subscription,
    created_at
FROM users 
WHERE email = 'user@example.com';

-- Step 2: Check what data will be deleted (foreign key relationships)
-- Replace 'USER_ID_HERE' with the actual user ID from Step 1
WITH user_to_delete AS (
    SELECT id FROM users WHERE email = 'user@example.com'
)
SELECT 
    'question_papers' as table_name, 
    COUNT(*) as record_count 
FROM question_papers 
WHERE user_id IN (SELECT id FROM user_to_delete)
UNION ALL
SELECT 
    'performance_scores' as table_name, 
    COUNT(*) as record_count 
FROM performance_scores 
WHERE user_id IN (SELECT id FROM user_to_delete)
UNION ALL
SELECT 
    'user_selections' as table_name, 
    COUNT(*) as record_count 
FROM user_selections 
WHERE user_id IN (SELECT id FROM user_to_delete)
UNION ALL
SELECT 
    'generated_questions' as table_name, 
    COUNT(*) as record_count 
FROM generated_questions 
WHERE user_id IN (SELECT id FROM user_to_delete)
UNION ALL
SELECT 
    'download_tracking' as table_name, 
    COUNT(*) as record_count 
FROM download_tracking 
WHERE user_id IN (SELECT id FROM user_to_delete);

-- Step 3: DELETE USER DATA (Execute these in order)
-- WARNING: This permanently deletes all user data
-- Replace 'user@example.com' with the actual email

-- 3a. Delete download tracking records
DELETE FROM download_tracking 
WHERE user_id IN (
    SELECT id FROM users WHERE email = 'user@example.com'
);

-- 3b. Delete performance scores
DELETE FROM performance_scores 
WHERE user_id IN (
    SELECT id FROM users WHERE email = 'user@example.com'
);

-- 3c. Delete generated questions
DELETE FROM generated_questions 
WHERE user_id IN (
    SELECT id FROM users WHERE email = 'user@example.com'
);

-- 3d. Delete user selections
DELETE FROM user_selections 
WHERE user_id IN (
    SELECT id FROM users WHERE email = 'user@example.com'
);

-- 3e. Delete question papers
DELETE FROM question_papers 
WHERE user_id IN (
    SELECT id FROM users WHERE email = 'user@example.com'
);

-- 3f. Finally, delete the user
DELETE FROM users 
WHERE email = 'user@example.com';

-- Step 4: Verify deletion (should return no results)
SELECT * FROM users WHERE email = 'user@example.com';

-- BULK USER CLEANUP (if needed)
-- Use this section if you need to clean up multiple test users at once
-- WARNING: This deletes ALL users matching the pattern

-- View all test users first
SELECT 
    id, 
    email, 
    full_name,
    first_paper_generated, 
    paper_generation_count, 
    created_at
FROM users 
WHERE email LIKE '%test%' OR email LIKE '%example%' OR email LIKE '%demo%'
ORDER BY created_at DESC;

-- To delete all test users (EXTREMELY DANGEROUS - use with caution):
-- Uncomment and modify the email pattern as needed
/*
-- Delete in order (foreign key constraints)
DELETE FROM download_tracking WHERE user_id IN (
    SELECT id FROM users WHERE email LIKE '%test%' OR email LIKE '%example%'
);

DELETE FROM performance_scores WHERE user_id IN (
    SELECT id FROM users WHERE email LIKE '%test%' OR email LIKE '%example%'
);

DELETE FROM generated_questions WHERE user_id IN (
    SELECT id FROM users WHERE email LIKE '%test%' OR email LIKE '%example%'
);

DELETE FROM user_selections WHERE user_id IN (
    SELECT id FROM users WHERE email LIKE '%test%' OR email LIKE '%example%'
);

DELETE FROM question_papers WHERE user_id IN (
    SELECT id FROM users WHERE email LIKE '%test%' OR email LIKE '%example%'
);

DELETE FROM users 
WHERE email LIKE '%test%' OR email LIKE '%example%';
*/

-- RESET FREE USER TRIAL (Alternative to deletion)
-- Use this if you want to reset a user's free trial instead of deleting them
-- This allows them to generate one more free paper
/*
UPDATE users 
SET 
    first_paper_generated = false,
    paper_generation_count = 0,
    updated_at = NOW()
WHERE email = 'user@example.com';
*/