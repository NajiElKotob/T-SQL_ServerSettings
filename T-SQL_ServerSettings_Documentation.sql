/*
SQL Server Settings/Configurations documentation
by Business Intelligence Group BIG SARL
Version 1.2.14 - 2012

Naji El Kotob, naji@dotnetheroes.com

How-to:
Run, Select All, Copy with Headers and Paste into Excel
*/


-- =================================================================================================
SELECT  Name = '-- SQL Server Version', '' AS Value, '' AS Minimum, '' AS Maximum, '' AS [Value in use], '' AS  [Description], '' AS [Is Dynamic],'' AS [Is Advanced]
UNION ALL

/*
 How to tell what SQL Server version you are running 
 https://www.mssqltips.com/sqlservertip/1140/how-to-tell-what-sql-server-version-you-are-running/
 http://sqlserverbuilds.blogspot.com/
*/

SELECT
Name = 'MajorVersion',
  CASE 
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '8%' THEN 'SQL2000'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '9%' THEN 'SQL2005'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '10.0%' THEN 'SQL2008'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '10.5%' THEN 'SQL2008 R2'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '11%' THEN 'SQL2012'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '12%' THEN 'SQL2014'
     WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '13%' THEN 'SQL2016'     
     ELSE 'Unknown'
  END AS Value ,'','','','','-','-'


UNION ALL
SELECT Name = 'Product Level', SERVERPROPERTY('ProductLevel') AS ProductLevel,'','','','','-','-'

UNION ALL
SELECT Name = 'Edition', SERVERPROPERTY('Edition') AS Edition,'','','','','-','-'
UNION ALL
SELECT Name = 'ProductVersion', SERVERPROPERTY('ProductVersion') ,'','','','','-','-'

-- =================================================================================================

UNION ALL
SELECT  Title = '-- SYS.CONFIGURATION','','','','','','',''

UNION ALL
-- sys.configurations
SELECT  Name, Value, Minimum, Maximum, value_in_use AS [Value in use], 
        [Description],
		 CASE is_dynamic WHEN 1 THEN 'Yes' ELSE 'No' END  AS [Is Dynamic], 
		 CASE is_advanced WHEN 1 THEN 'Yes' ELSE 'No' END  AS [Is Advanced]
FROM    sys.configurations -- ORDER BY Name

-- =================================================================================================
UNION ALL
SELECT  Title = '-- SYS.DM_OS_SYS_INFO','','','','','','',''

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
