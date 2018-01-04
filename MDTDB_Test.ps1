# ***************************************************************************
# 
# File:      MDTDB_Test.psm1
# 
# Author:    Michael Niehaus 
# 
# Purpose:   This is a test script, designed to show some simple examples of
#            how to use the MDTDB.psm1 module to maintain the Microsoft
#            Deployment Toolkit database contents.
#
# ------------- DISCLAIMER -------------------------------------------------
# This script code is provided as is with no guarantee or waranty concerning
# the usability or impact on systems and may be used, distributed, and
# modified in any way provided the parties agree and acknowledge the 
# Microsoft or Microsoft Partners have neither accountabilty or 
# responsibility for results produced by use of this script.
#
# Microsoft will not provide any support through any means.
# ------------- DISCLAIMER -------------------------------------------------
#
# ***************************************************************************

import-module .\MDTDB.psm1 -force

# This line requires MDT 2010
Connect-MDTDatabase -drive DP001: -verbose

# This line could be used with any version of MDT
# Connect-MDTDatabase -sqlServer MYSERVER -instance SQLExpress -database BDDAdminDB

Get-MDTComputer -verbose
Get-MDTComputer -assettag XXX | remove-MDTComputer -verbose
New-MDTComputer -assettag XXX -settings @{SkipWizard="YES"; DoCapture="YES"} -verbose
Get-MDTComputer -assettag XXX | set-MDTComputer -settings @{ComputerName="BLAH"} -verbose
Get-MDTComputer -assettag XXX

Get-MDTComputer -assettag XXX | Clear-MDTComputerApplication
Get-MDTComputer -assettag XXX | Set-MDTComputerApplication -applications @('A','B','C')
Get-MDTComputer -assettag XXX | Get-MDTComputerApplication

Get-MDTComputer -assettag XXX | Clear-MDTComputerPackage
Get-MDTComputer -assettag XXX | Set-MDTComputerPackage -packages @('P','Q','R')
Get-MDTComputer -assettag XXX | Get-MDTComputerPackage

Get-MDTComputer -assettag XXX | Clear-MDTComputerRole
Get-MDTComputer -assettag XXX | Set-MDTComputerRole -roles @('R','S','T')
Get-MDTComputer -assettag XXX | Get-MDTComputerRole

Get-MDTComputer -assettag XXX | Clear-MDTComputerAdministrator
Get-MDTComputer -assettag XXX | Set-MDTComputerAdministrator -administrators @('A','B')
Get-MDTComputer -assettag XXX | Get-MDTComputerAdministrator


Get-MDTRole -verbose
Get-MDTRole -name XXX | remove-MDTRole -verbose
New-MDTRole -name XXX -settings @{SkipWizard="YES"; DoCapture="YES"} -verbose
Get-MDTRole -name XXX | set-MDTRole -settings @{ComputerName="BLAH"} -verbose
Get-MDTRole -name XXX

Get-MDTRole -name XXX | Clear-MDTRoleApplication
Get-MDTRole -name XXX | Set-MDTRoleApplication -applications @('A','B','C')
Get-MDTRole -name XXX | Get-MDTRoleApplication

Get-MDTRole -name XXX | Clear-MDTRolePackage
Get-MDTRole -name XXX | Set-MDTRolePackage -packages @('P','Q','R')
Get-MDTRole -name XXX | Get-MDTRolePackage

Get-MDTRole -name XXX | Clear-MDTRoleRole
Get-MDTRole -name XXX | Set-MDTRoleRole -roles @('R','S','T')
Get-MDTRole -name XXX | Get-MDTRoleRole

Get-MDTRole -name XXX | Clear-MDTRoleAdministrator
Get-MDTRole -name XXX | Set-MDTRoleAdministrator -administrators @('A','B')
Get-MDTRole -name XXX | Get-MDTRoleAdministrator


Get-MDTLocation -verbose
Get-MDTLocation -name XXX | remove-MDTLocation -verbose
New-MDTLocation -name XXX -gateways @('1.2.3.4','2.3.4.5') -settings @{SkipWizard="YES"; DoCapture="YES"} -verbose
Get-MDTLocation -name XXX | set-MDTLocation -settings @{ComputerName="BLAH"} -verbose
Get-MDTLocation -name XXX | set-MDTLocation -gateways @('1.2.3.4','2.3.4.5','3.4.5.6') -verbose
Get-MDTLocation -name XXX

Get-MDTLocation -name XXX | Clear-MDTLocationApplication
Get-MDTLocation -name XXX | Set-MDTLocationApplication -applications @('A','B','C')
Get-MDTLocation -name XXX | Get-MDTLocationApplication

Get-MDTLocation -name XXX | Clear-MDTLocationPackage
Get-MDTLocation -name XXX | Set-MDTLocationPackage -packages @('P','Q','R')
Get-MDTLocation -name XXX | Get-MDTLocationPackage

Get-MDTLocation -name XXX | Clear-MDTLocationRole
Get-MDTLocation -name XXX | Set-MDTLocationRole -roles @('R','S','T')
Get-MDTLocation -name XXX | Get-MDTLocationRole

Get-MDTLocation -name XXX | Clear-MDTLocationAdministrator
Get-MDTLocation -name XXX | Set-MDTLocationAdministrator -administrators @('A','B')
Get-MDTLocation -name XXX | Get-MDTLocationAdministrator
GET-MDTLocation -name XXX -detail

Get-MDTMakeModel -verbose
Get-MDTMakeModel -make Microsoft -model 'Virtual Machine' | remove-MDTMakeModel -verbose
New-MDTMakeModel -make Microsoft -model 'Virtual Machine' -settings @{SkipWizard="YES"; DoCapture="YES"} -verbose
Get-MDTMakeModel -make Microsoft -model 'Virtual Machine' | set-MDTMakeModel -settings @{ComputerName="BLAH"} -verbose
Get-MDTMakeModel -make Microsoft -model 'Virtual Machine'

Get-MDTMakeModel -make Microsoft -model 'Virtual Machine' | Clear-MDTMakeModelApplication
Get-MDTMakeModel -make Microsoft -model 'Virtual Machine' | Set-MDTMakeModelApplication -applications @('A','B','C')
Get-MDTMakeModel -make Microsoft -model 'Virtual Machine' | Get-MDTMakeModelApplication

Get-MDTMakeModel -make Microsoft -model 'Virtual Machine' | Clear-MDTMakeModelPackage
Get-MDTMakeModel -make Microsoft -model 'Virtual Machine' | Set-MDTMakeModelPackage -packages @('P','Q','R')
Get-MDTMakeModel -make Microsoft -model 'Virtual Machine' | Get-MDTMakeModelPackage

Get-MDTMakeModel -make Microsoft -model 'Virtual Machine' | Clear-MDTMakeModelRole
Get-MDTMakeModel -make Microsoft -model 'Virtual Machine' | Set-MDTMakeModelRole -roles @('R','S','T')
Get-MDTMakeModel -make Microsoft -model 'Virtual Machine' | Get-MDTMakeModelRole

Get-MDTMakeModel -make Microsoft -model 'Virtual Machine' | Clear-MDTMakeModelAdministrator
Get-MDTMakeModel -make Microsoft -model 'Virtual Machine' | Set-MDTMakeModelAdministrator -administrators @('A','B')
Get-MDTMakeModel -make Microsoft -model 'Virtual Machine' | Get-MDTMakeModelAdministrator


Get-MDTPackageMapping
Get-MDTPackageMapping -arpName XXX
New-MDTPackageMapping -arpName XXX -package 'XXX00001:Test'
Get-MDTPackageMapping -arpName XXX | Set-MDTPackageMapping -package 'XXX00002:Test'
Get-MDTPackageMapping -arpName XXX
Get-MDTPackageMapping -arpName XXX | Remove-MDTPackageMapping
