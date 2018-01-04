# MDTDB
Manipulate the MDT database with Powershell

Original script by Michael Niehaus.

[Link to original script location](https://blogs.technet.microsoft.com/mniehaus/2009/05/14/manipulating-the-microsoft-deployment-toolkit-database-using-powershell/)

Here's the quick list of Cmdlets included in the MDTDB.psm1 script and a very brief description of each:

1. Connect-MDTDatabase.  Establish a connection to an MDT database.
1. New-MDTComputer.  Create a new computer entry.
1. Get-MDTComputer.  Get an existing computer entry, or a list of all computer entries.
1. Set-MDTComputer.  Modify the settings of an existing computer entry.
1. Remove-MDTComputer.  Remove an existing computer entry.
1. Get-MDTComputerApplication.  Get the applications for an existing computer entry.
1. Clear-MDTComputerApplication.  Remove all applications from an existing computer entry.
1. Set-MDTComputerApplication.  Modify the list of applications for an existing computer entry.
1. Get-MDTComputerPackage.  Get the ConfigMgr packages for an existing computer entry.
1. Clear-MDTComputerPackage.  Remove all packages from an existing computer entry.
1. Set-MDTComputerPackage.  Modify the list of packages for an existing computer entry.
1. Get-MDTComputerRole.  Get the list of roles for an existing computer entry.
1. Clear-MDTComputerRole.  Remove all roles from an existing computer entry.
1. Set-MDTComputerRole.  Modify the list of roles for an existing computer entry.
1. Get-MDTComputerAdministrator.  Get the list of administrators for an existing computer entry.
1. Clear-MDTComputerAdministrator.  Remove all administrators from an existing computer entry.
1. Set-MDTComputerAdministrator.  Modify the list of administrators for an existing computer entry.
1. New-MDTRole.  Create a new role.
1. Get-MDTRole.  Get an existing role, or a list of all roles.
1. Set-MDTRole.  Modify the settings of an existing role.
1. Remove-MDTRole.  Remove an existing role.
1. Get-MDTRoleApplication.  Get the applications for an existing role.
1. Clear-MDTRoleApplication.  Remove all applications from an existing role.
1. Set-MDTRoleApplication.  Modify the list of application for an existing role.
1. Get-MDTRolePackage.  Get the ConfigMgr packages for an existing role.
1. Clear-MDTRolePackage.  Remove all packages from an existing role.
1. Set-MDTRolePackage.  Modify the list of packages for an existing role.
1. Get-MDTRoleRole.  Get the list of roles for an existing role.
1. Clear-MDTRoleRole.  Remove all roles from an existing role.
1. Set-MDTRoleRole.  Modify the list of roles for an existing role.
1. Get-MDTRoleAdministrator.  Get the list of administrators for an existing role.
1. Clear-MDTRoleAdministrator.  Remove all administrators from an existing role.
1. Set-MDTRoleAdministrator.  Modify the list of administrators for an existing role.
1. New-MDTLocation.  Create a new location.
1. Get-MDTLocation.  Get an existing location, or a list of locations.
1. Set-MDTLocation.  Modify the settings of an existing location.
1. Remove-MDTLocation.  Remove an existing location.
1. Get-MDTLocationApplication.  Get the applications for an existing location.
1. Clear-MDTLocationApplication.  Remove all applications from an existing location.
1. Set-MDTLocationApplication.  Modify the list of applications for an existing location.
1. Get-MDTLocationPackage.  Get the ConfigMgr packages for an existing location.
1. Clear-MDTLocationPackage.  Remove all packages from an existing location.
1. Set-MDTLocationPackage.  Modify the list of packages for an existing location.
1. Get-MDTLocationRole.  Get the roles for an existing location.
1. Clear-MDTLocationRole.  Remove all roles from an existing location.
1. Set-MDTLocationRole.  Modify the list of roles for an existing location.
1. Get-MDTLocationAdministrator.  Get the administrators for an existing location.
1. Clear-MDTLocationAdministrator.  Remove all administrators from an existing location.
1. Set-MDTLocationAdministrator. 
1. New-MDTMakeModel
1. Get-MDTMakeModel
1. Set-MDTMakeModel
1. Remove-MDTMakeModel
1. Get-MDTMakeModelApplication
1. Clear-MDTMakeModelApplication
1. Set-MDTMakeModelApplication
1. Get-MDTMakeModelPackage
1. Clear-MDTMakeModelPackage
1. Set-MDTMakeModelPackage
1. Get-MDTMakeModelRole
1. Clear-MDTMakeModelRole
1. Set-MDTMakeModelRole
1. Get-MDTMakeModelAdministrator
1. Clear-MDTMakeModelAdministrator
1. Set-MDTMakeModelAdministrator
1. New-MDTPackageMapping
1. Get-MDTPackageMapping
1. Set-MDTPackageMapping
1. Remove-MDTPackageMapping


## A Few Notes

* Connect-MDTDatabase can connect in two ways.  One way works with MDT 2010 Beta 1 or earlier, where you have to specify the connection details (server, instance, database name).  The other works with MDT 2010 Beta 2 or later, where you can just point to the deployment share that contains all the needed details.
* Only the "Get" cmdlets are used to select items by some identifier (e.g. MAC address).  The other commands use the ID.  So the standard process will be to use "Get" with the other cmdlets in the same pipeline.
* The settings are specified using a hash table.  See http://www.microsoft.com/technet/scriptcenter/resources/pstips/sept07/pstip0914.mspx for details.  An example for MDT might be @{SkipWizard=’YES’;DoCapture=’TRUE’}.
* Lists are specified using an array.  See http://blogs.msdn.com/powershell/archive/2007/01/23/array-literals-in-powershell.aspx for samples.  An MDT-specific example might be @(‘10.1.1.1’,’10.1.2.1’, ‘10.1.3.1’).
* You may not have any need to call the "Clear" cmdlets, but they are used behind the scenes by the "Set" cmdlets.
* Get-MDTLocation behaves a little differently than the other "Get" cmdlets.  This is because it would otherwise return one location item per default gateway, and that would mess up the other cmdlets.  So by default, Get-MDTLocation will only return the location name and ID (single record).  If you want to see the settings and list of gateways, add "-detail" to the PowerShell command.
* In most cases, parameters can be retrieved from the pipeline.  This lets you do some interesting batch processes.
* So how do you use all of these?  See the included "MDTDB_Test.ps1" script for some simple examples (used to test the logic).  Here are a few more examples, just to give you some ideas.

## Examples
 
### Create a new computer and set its details

To add a new computer, just specify some identifying details (at least a MAC address, serial number, asset tag, or UUID, or any combination of those), along with whatever settings you want to configure.  This example adds a machine, specifies its settings, and configures it with a list of applications:

	import-module .\MDTDB.psm1 
	connect-mdtdatabase -sqlserver MNiehaus-T61P-7 -instance SQLEXPRESS -database MDTDatabase 
	new-mdtcomputer -macAddress '00:00:00:11:22:33' -settings @{OSInstall='YES'; OSDComputerName='MYPC'} 
	get-mdtcomputer -macaddress '00:00:00:11:22:33' | Set-MDTComputerApplication -applications @('{dc83b044-f018-40ec-828f-5e2b77058bb4}','{e7d31704-af9d-4105-ad4b-dbb95e23b692}')

You could actually shorten this too, since New-MDTComputer returns the new item which can be piped into Set-MDTComputerApplication:

	import-module .\MDTDB.psm1 
	connect-mdtdatabase -sqlserver MNiehaus-T61P-7 -instance SQLEXPRESS -database MDTDatabase 
	new-mdtcomputer -macAddress '00:00:00:11:22:33' -settings @{OSInstall='YES'; OSDComputerName='MYPC'} | Set-MDTComputerApplication -applications @('{dc83b044-f018-40ec-828f-5e2b77058bb4}','{e7d31704-af9d-4105-ad4b-dbb95e23b692}')

### Import a list of makes and models

Assume you have a "Models.csv" file that looks like this (maybe exported from ConfigMgr):

	Make,Model 
	Dell,Latitude e6400 
	Lenovo,T61p 
	HP,dx5150 
	Toshiba,M400

With that, you can then issue a simple PowerShell command to quickly create multiple MDT database entries:

	import-module .\MDTDB.psm1 
	connect-mdtdatabase -sqlserver MNiehaus-T61P-7 -instance SQLEXPRESS -database MDTDatabase 
	import-csv .\Models.csv | New-MDTMakeModel -settings @{OSInstall='YES'}

### Create a new role and set its details

Creating a new role just requires specifying its name, along with any settings you want.  In this case, I’ll also add a list of ConfigMgr packages that should be installed with this role:

	import-module .\MDTDB.psm1 
	connect-mdtdatabase -sqlserver MNiehaus-T61P-7 -instance SQLEXPRESS -database MDTDatabase 
	New-MDTRole -name 'My Role' -settings @{Home_Page = 'http://www.live.com'} | Set-MDTRolePackage -packages @('XXX00001:Install','XXX00002:Install')

### List all contents

The "get" cmdlets can be used to retrieve a list of existing items by not specifying any criteria:

	import-module .\MDTDB.psm1 
	connect-mdtdatabase -sqlserver MNiehaus-T61P-7 -instance SQLEXPRESS -database MDTDatabase 
	Get-MDTComputer 
	Get-MDTLocation 
	Get-MDTMakeModel 
	Get-MDTRole

Note that you might want to specify -detail on the Get-MDTLocation cmdlet to get the details; this will cause it to return one row per gateway value.

### Add a package mapping entry

MDT provides a sample table and stored procedure for reinstalling software on a computer based on ConfigMgr inventory.  To support this, you need to populate the package mapping table with entries to indicate which package should be installed for machine with a particular Add/Remove Programs entry.  Adding an entry can be done fairly easily:

	import-module .\MDTDB.psm1 
	connect-mdtdatabase -sqlserver MNiehaus-T61P-7 -instance SQLEXPRESS -database MDTDatabase 
	New-MDTPackageMapping -ARPName 'Zune' -package 'XXX00003:Install'