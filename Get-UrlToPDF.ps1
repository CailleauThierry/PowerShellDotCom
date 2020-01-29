<#
	.NOTES
	===========================================================================
	 Posted by : 	Powershell.com <yourpowertip@powershell.com>
	 Created on:   	01_29_2020 4:25 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename: Get-UrlToPDF.ps1
	===========================================================================
	.DESCRIPTION
		How to import and open a .pdf file from URL locally
		Tested to work on Win 10 with PSVersion = 5.1.18362.145
#>

$url = "https://download.microsoft.com/download/4/3/1/43113f44-548b-4dea-b471-0c2c8578fbf8/powershell_langref_v4.pdf"

# get desktop path
$desktop = [Environment]::GetFolderPath('Desktop')
$destination = "$desktop\langref.pdf"

# enable TLS1.2 for HTTPS connections
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12

# download PDF file
Invoke-WebRequest -Uri $url -OutFile $destination -UseBasicParsing
# open downloaded file in associated program
Invoke-Item -Path $destination

