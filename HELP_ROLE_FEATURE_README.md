# Role-Based Help Content Feature

## Overview

This feature adds role-based access control to the help content system. Users will now only see help content that is specifically created for their role.

## Changes Made

### 1. Database Changes

- Added `role_id` column to `help_sections` table
- Added foreign key constraint linking to `user_roles` table
- Created migration script: `database_migration.sql`

### 2. Backend Changes (HelpServlet.java)

- Updated `HelpSection` model class to include `roleId` field
- Modified all CRUD operations to handle `role_id`
- Added `getHelpSectionsByRole(int roleId)` method
- Added `getRoleIdByName(String roleName)` method
- Updated form handlers to validate and process role selection

### 3. Frontend Changes

- **help_create.jsp**: Added role selector dropdown with role-based filtering
- **help_edit.jsp**: Added role selector dropdown with pre-selected current role
- **help.jsp**: Updated to show help sections based on user's role
- Added role badges to help section cards
- Updated form validation to include role field

## Role Permissions

### Admin (role_id = 1)

- Can create help content for any role
- Can see all help content
- Can edit/delete any help content

### Manager (role_id = 2)

- Can create help content for CASHIER and CUSTOMER roles only
- Can see help content created for MANAGER role
- Can edit/delete help content they created

### Cashier (role_id = 3)

- Can only view help content created for CASHIER role
- Cannot create/edit/delete help content

### Customer (role_id = 4)

- Can only view help content created for CUSTOMER role
- Cannot create/edit/delete help content

## Database Migration

To apply the database changes, run the migration script:

```sql
-- Run the database_migration.sql script
-- This will:
-- 1. Add role_id column to help_sections table
-- 2. Set default role_id = 1 (ADMIN) for existing records
-- 3. Add foreign key constraint
-- 4. Verify the migration
```

## Usage

### Creating Help Content

1. Navigate to Help page
2. Click "Add Help Content" (Admin/Manager only)
3. Fill in title and content
4. Select the target role from dropdown
5. Submit the form

### Viewing Help Content

- Users will automatically see only help content created for their role
- Admin users see all help content
- Role badges are displayed on each help section card

## Technical Details

### Key Methods Added

- `getHelpSectionsByRole(int roleId)`: Get help sections for specific role
- `getRoleIdByName(String roleName)`: Get role ID from role name
- Role-based filtering in form dropdowns
- Role-based content display logic

### Security Features

- Role-based access control for help content creation
- Form validation for role selection
- Server-side role validation
- Client-side form validation

## Testing

1. **Admin User Test**:

   - Login as admin
   - Create help content for different roles
   - Verify all help content is visible

2. **Manager User Test**:

   - Login as manager
   - Verify only CASHIER and CUSTOMER roles are available in dropdown
   - Verify only MANAGER help content is visible

3. **Cashier/Customer Test**:
   - Login as cashier/customer
   - Verify only role-specific help content is visible
   - Verify no create/edit options are available

## Files Modified

- `src/java/com/booking/HelpServlet.java`
- `src/java/com/booking/DatabaseUtil.java`
- `web/help_create.jsp`
- `web/help_edit.jsp`
- `web/help.jsp`
- `database_migration.sql` (new)
- `HELP_ROLE_FEATURE_README.md` (new)
