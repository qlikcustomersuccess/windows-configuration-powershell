#Requires -RunAsAdministrator

# MIT LICENSE - COPYRIGHT (c) 2018 QLIK SUPPORT
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THIS SOFTWARE SCRIPT IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT 
# OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
# USE OR OTHER DEALINGS IN THE SOFTWARE.

# DESCRIPTION

# This powershell script increases the default timeout value for the service 
# control manager in Windows. The change is applied in the Windows registry, 
# and requires administrator privileges. 
# Caution is advised for any change sin Wndows registry. Make sure you have a 
# recovery plan, in case of incorrect or accidental configuration 

# REFERENCES
# - Qlik Support knowledge article; https://qliksupport.force.com/articles/000003722
# - Microsoft Support article; https://support.microsoft.com/en-us/help/839803

$Path_CurrentControlSetControl =  "HKLM:\SYSTEM\CurrentControlSet\control"
$Path_ServicesPipeTimeout = $Path_CurrentControlSetControl + "\ServicesPipeTimeout"

if(-Not (Test-Path $Path_ServicesPipeTimeout)) {

    Set-Location "$Path_CurrentControlSetControl" 

    New-ItemProperty -Path "$Path_CurrentControlSetControl" `
                     -Name "ServicesPipeTimeout" `
                     -Value "300000" `
                     -PropertyType "DWord" `
                     -Force
}

