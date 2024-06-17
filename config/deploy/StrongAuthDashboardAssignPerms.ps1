$permissionsToAdd = "User.Read.All", "UserAuthenticationMethod.Read.All", "Group.Read.All", "AuditLog.Read.All"
# static Graph AppId, do not change
$graphAppId = "00000003-0000-0000-c000-000000000000"

Connect-MgGraph
$msi = Get-MgServicePrincipal -Filter "DisplayName eq 'Import-StrongAuthDashboadData'"
$app = Get-MgServicePrincipal -Filter "AppId eq '$graphAppId'"
foreach ($permission in $permissionsToAdd) {
   $role = $app.AppRoles | Where-Object Value -Like $permission | Select-Object -First 1
   New-MgServicePrincipalAppRoleAssignment -AppRoleId $role.Id -ServicePrincipalId $msi.Id -PrincipalId $msi.Id -ResourceId $app.Id
}
