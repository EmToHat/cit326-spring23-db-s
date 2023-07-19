USE [HR_db]
GO
CREATE ROLE [final_proj_testers]
GO
USE [HR_db]
GO
ALTER ROLE [final_proj_testers] ADD MEMBER [final_running_buddy]
GO
USE [HR_db]
GO
ALTER ROLE [final_proj_testers] ADD MEMBER [final_test_user]
GO
use [HR_db]
GO
GRANT SELECT ON [hr].[employees] TO [final_proj_testers]
GO
use [HR_db]
GO
GRANT SELECT ON [hr].[dependents] TO [final_proj_testers]
GO
use [HR_db]
GO
GRANT SELECT ON [dbo].[final_view] TO [final_proj_testers]
GO
use [HR_db]
GO
GRANT SELECT ON [office].[locations] TO [final_proj_testers]
GO
