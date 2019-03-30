/*
SQL Server Settings - Documentation
Version 1.3.15
Naji El Kotob, naji {@} dotnetheroes.com
Business Intelligence Group BIG SARL
*/

USE master
GO


SELECT  Name = 'Date/Time', GETDATE() AS Value, '' AS Minimum, '' AS Maximum, '' AS [Value in use], '' AS  [Description], '' AS [Is Dynamic],'' AS [Is Advanced]

-- =================================================================================================
UNION ALL
SELECT  Name = '>>> SQL Server Version', '' AS Value, '' AS Minimum, '' AS Maximum, '' AS [Value in use], '' AS  [Description], '' AS [Is Dynamic],'' AS [Is Advanced]


/*
 How to tell what SQL Server version you are running 
 https://www.mssqltips.com/sqlservertip/1140/how-to-tell-what-sql-server-version-you-are-running/
 http://sqlserverbuilds.blogspot.com/
*/
UNION ALL
SELECT
Name = 'MajorVersion',
  CASE 
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '8%'	THEN 'SQL2000'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '9%'	THEN 'SQL2005'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '10.0%' THEN 'SQL2008'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '10.5%' THEN 'SQL2008 R2'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '11%'	THEN 'SQL2012'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '12%'	THEN 'SQL2014'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '13%'	THEN 'SQL2016' 
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '14%'	THEN 'SQL2017' 
	     
     ELSE SERVERPROPERTY ('productversion')
  END AS Value ,'','','','','-','-'

UNION ALL
SELECT Name = 'Product Level', SERVERPROPERTY('ProductLevel') AS ProductLevel,'','','','','-','-'

UNION ALL
SELECT Name = 'Edition', SERVERPROPERTY('Edition') AS Edition,'','','','','-','-'

UNION ALL
SELECT Name = 'ProductVersion', SERVERPROPERTY('ProductVersion') ,'','','','','-','-'

-- =================================================================================================
UNION ALL
SELECT  Title = '>>> SECURITY','','','','','','',''

UNION ALL
SELECT 
Name = 'Authentication Mode',
	CASE SERVERPROPERTY('IsIntegratedSecurityOnly')   
		WHEN 1 THEN 'Windows Authentication mode'   
		WHEN 0 THEN 'Windows and SQL Server Authentication mode'   
	END AS AuthenticationMode ,'','','','','-','-'

-- =================================================================================================

UNION ALL
SELECT  Title = '>>> SYS.CONFIGURATION','','','','','','',''

UNION ALL
-- sys.configurations
SELECT  Name, Value, Minimum, Maximum, value_in_use AS [Value in use], 
        [Description],
		 CASE is_dynamic WHEN 1 THEN 'Yes' ELSE 'No' END  AS [Is Dynamic], 
		 CASE is_advanced WHEN 1 THEN 'Yes' ELSE 'No' END  AS [Is Advanced]
FROM    sys.configurations -- ORDER BY Name

-- =================================================================================================
UNION ALL
SELECT  Title = '>>> SYS.DM_OS_SYS_INFO','','','','','','',''

UNION ALL
-- SELECT * FROM sys.dm_os_sys_info 
SELECT upvt.Name
    , upvt.Value,'','','','','-','-'
FROM (
    SELECT *
    FROM sys.dm_os_sys_info dosi
    ) src
UNPIVOT (
    [Value] FOR Name IN (
          committed_kb
        , committed_target_kb -- Add new values
    )
) upvt
-- =================================================================================================
