-- Database Migration Script for Help Sections Role Support
-- This script adds role_id column to help_sections table

-- Add role_id column to help_sections table
ALTER TABLE help_sections ADD COLUMN role_id INT NOT NULL DEFAULT 1;

-- Add foreign key constraint
ALTER TABLE help_sections ADD CONSTRAINT fk_help_sections_role_id 
FOREIGN KEY (role_id) REFERENCES user_roles(role_id);

-- Update existing help sections to have role_id = 1 (ADMIN) as default
-- This ensures existing help content is visible to admin users
UPDATE help_sections SET role_id = 1 WHERE role_id = 0 OR role_id IS NULL;

-- Remove the default constraint after setting values
ALTER TABLE help_sections ALTER COLUMN role_id DROP DEFAULT;

-- Verify the migration
SELECT 'Migration completed successfully. Total help sections: ' || COUNT(*) as result FROM help_sections;
SELECT 'Role distribution:' as info;
SELECT r.role_name, COUNT(h.help_id) as help_count 
FROM user_roles r 
LEFT JOIN help_sections h ON r.role_id = h.role_id 
GROUP BY r.role_id, r.role_name;
