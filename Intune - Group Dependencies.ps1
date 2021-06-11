Connect-MSGraph
Update-MSGraphEnvironment -SchemaVersion beta
Connect-AzureAD
 
# Enter the Group Name
$groupName = Read-Host -Prompt 'Input your Group Name'
$Group = Get-AADGroup -Filter "displayname eq '$GroupName'"

Write-host
Write-host "AAD Group Name: $($Group.displayName)" -ForegroundColor Green


# Apps
$AllAssignedApps = Get-IntuneMobileApp -Select id, displayName, assignments -Expand assignments | Where-Object {$_.assignments -match $Group.id}

Write-host
Write-host "Number of Apps found: $($AllAssignedApps.DisplayName.Count)" -ForegroundColor cyan

Foreach ($Config in $AllAssignedApps) {
    Write-host $Config.displayName -ForegroundColor Yellow
}
 

# Device Compliance
$AllDeviceCompliance = Get-IntuneDeviceCompliancePolicy -Select id, displayName, assignments -Expand assignments | Where-Object {$_.assignments -match $Group.id}

Write-host
Write-host "Number of Device Compliance policies found: $($AllDeviceCompliance.DisplayName.Count)" -ForegroundColor cyan

Foreach ($Config in $AllDeviceCompliance) {
    Write-host $Config.displayName -ForegroundColor Yellow
}
 

# Device Configuration
$AllDeviceConfig = Get-IntuneDeviceConfigurationPolicy -Select id, displayName, assignments -Expand assignments | Where-Object {$_.assignments -match $Group.id}

Write-host
Write-host "Number of Device Configuration policies found: $($AllDeviceConfig.DisplayName.Count)" -ForegroundColor cyan

Foreach ($Config in $AllDeviceConfig) {
    Write-host $Config.displayName -ForegroundColor Yellow
}


# Device Configurations Powershell Scripts 
$Resource = "deviceManagement/deviceManagementScripts"
$graphApiVersion = "Beta"
$uri = "https://graph.microsoft.com/$graphApiVersion/$($Resource)?`$expand=groupAssignments"
$PS = Invoke-MSGraphRequest -HttpMethod GET -Url $uri
$AllPowerShellScripts = $PS.value | Where-Object {$_.groupAssignments -match $Group.id}

Write-host
Write-host "Number of Device Configurations Powershell Scripts found: $($AllPowerShellScripts.DisplayName.Count)" -ForegroundColor cyan

Foreach ($Config in $AllPowerShellScripts) {
    Write-host $Config.displayName -ForegroundColor Yellow
}

 
# Administrative Templates
$Resource = "deviceManagement/groupPolicyConfigurations"
$graphApiVersion = "Beta"
$uri = "https://graph.microsoft.com/$graphApiVersion/$($Resource)?`$expand=Assignments"
$AT = Invoke-MSGraphRequest -HttpMethod GET -Url $uri
$AllAT = $AT.value | Where-Object {$_.assignments -match $Group.id}

Write-host
Write-host "Number of Device Administrative Templates found: $($AllAT.DisplayName.Count)" -ForegroundColor cyan

Foreach ($Config in $AllAT) {
    Write-host $Config.displayName -ForegroundColor Yellow
}


# App Configuration
$AllAppConfig = Get-IntuneMobileAppConfigurationPolicy -Select id, displayName, assignments -Expand assignments | Where-Object {$_.assignments -match $Group.id}

Write-host
Write-host "Number of App Configuration policies found: $($AllAppConfig.DisplayName.Count)" -ForegroundColor cyan

Foreach ($Config in $AllAppConfig) {
    Write-host $Config.displayName -ForegroundColor Yellow
}


# iOS App Protection
$AlliOSAppProtection = Get-IntuneAppProtectionPolicyIos -Select id, displayName, assignments -Expand assignments | Where-Object {$_.assignments -match $Group.id}

Write-host
Write-host "Number of iOS App Protection policies found: $($AlliOSAppProtection.DisplayName.Count)" -ForegroundColor cyan

Foreach ($Config in $AlliOSAppProtection) {
    Write-host $Config.displayName -ForegroundColor Yellow
}


# Android App Protection
$AllAndroidAppProtection = Get-IntuneAppProtectionPolicyAndroid -Select id, displayName, assignments -Expand assignments | Where-Object {$_.assignments -match $Group.id}

Write-host
Write-host "Number of Android App Protection policies found: $($AllAndroidAppProtection.DisplayName.Count)" -ForegroundColor cyan

Foreach ($Config in $AllAndroidAppProtection) {
    Write-host $Config.displayName -ForegroundColor Yellow
}


# Windows Information Protection
$Resource = "deviceAppManagement/mdmWindowsInformationProtectionPolicies"
$graphApiVersion = "Beta"
$uri = "https://graph.microsoft.com/$graphApiVersion/$($Resource)?`$expand=Assignments"
$WIP = Invoke-MSGraphRequest -HttpMethod GET -Url $uri
$AllWIP = $WIP.value | Where-Object {$_.assignments -match $Group.id}

Write-host
Write-host "Number of Windows Information Protection found: $($AllWIP.DisplayName.Count)" -ForegroundColor cyan

Foreach ($Config in $AllWIP) {
    Write-host $Config.displayName -ForegroundColor Yellow
}