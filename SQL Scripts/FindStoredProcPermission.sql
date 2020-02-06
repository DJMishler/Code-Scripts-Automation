SELECT
    OBJECT_NAME(major_id) [Name], USER_NAME(grantee_principal_id) [User], [permission_name]
FROM
    sys.database_permissions p
WHERE
    OBJECT_NAME(major_id) = 'Rsp_RPT_CSP_Monthly_Usage_report'