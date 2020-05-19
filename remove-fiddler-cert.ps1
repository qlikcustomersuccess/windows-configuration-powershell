#Requires -RunAsAdministrator

# MIT LICENSE - COPYRIGHT (c) 2020 
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

# This PowerShell script removes Fiddler2 generated certificates from Windows 
# Certificate store. This includes both certificates in Current Users personal 
# certificates and Trusted Root CA.
# Prior to removal the certificates are exported to file. 
 
$ScriptTime = Get-Date -Format "ddMMyyyyHHmmss"

# Get all cert that are issues by Fiddler
$ClientCert = Get-ChildItem -Path "Cert:\CurrentUser\My" | `
              Where-Object { $_.Issuer -like '*CN=DO_NOT_TRUST*'} 
              
# Store backup to SST file              
$ClientCert | Export-Certificate -FilePath ".\FiddlerClientCerts$ScriptTime.sst" -Type SST

# Remove the identified certs
$ClientCert | Remove-Item

$RootCert = Get-ChildItem -Path "Cert:\CurrentUser\Root" | `
            Where-Object { $_.Subject -like '*fiddler*'} 

# Export to CER file for bacup        
$RootCert | ForEach-Object { Export-Certificate -Cert $_ -FilePath ".\FiddlerRootCerts_$($_.FriendlyName)_$($_.Thumbprint)_$ScriptTime.cer" -Type CERT }

# Remove the identified certs
$RootCert | Remove-Item

