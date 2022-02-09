# Input bindings are passed in via param block.
param([byte[]] $InputBlob, $TriggerMetadata)

# Write out the blob name and size to the information log.
Write-Information "PowerShell Blob trigger function Processed blob! Name: $($TriggerMetadata.Name) Size: $($InputBlob.Length) bytes"

Write-Information " blob sync test!!!"

# Define variables
$SrcStgAccURI = "https://nfs1source2account.blob.core.chinacloudapi.cn/"
$SrcBlobContainer = "nanjing/"
$SrcSASToken = "?sp=XXXXXXXXXXXXXXX1"
$SrcFullPath = "$($SrcStgAccURI)$($SrcBlobContainer)$($TriggerMetadata.Name)$($SrcSASToken)"

Write-Information " src full path:  $SrcFullPath"

$BlobFileMetaData= $TriggerMetadata.Metadata


foreach($Key in $BlobFileMetaData.Keys)
{
    "key:"+ $Key
    "value:"+ $BlobFileMetaData[$Key];
}

$TriggerMetadata.Metadata.Add("testTime","$currentUTCtime")

$SrcContext = New-AzStorageContext -StorageAccountName "nfs1source2account" -StorageAccountKey "5+6hVxp7UWTjijqKoojPnkdOczbPJXWpWF+YN2vpt0LEqDj/ve7uB1AL/WIg4nlr1XrltGuPIZ9MWL/0cw+YKA==" -Environment "AzureChinaCloud"

$BlobFiles = Get-AzStorageBlob -Container "nanjing"  -Blob "ubuntuTest.rdp" -Context $SrcContext

$BlobFiles.ICloudBlob.Metadata.Add("testTime222","342sdasdasd")


$DstStgAccURI = "https://us1target2storage.blob.core.windows.net/"
$DstFileShare = "california/"
$DstSASToken = "?sp=XXXXXXXXXXXXXXX2"
$DstFullPath = "$($DstStgAccURI)$($DstFileShare)$($TriggerMetadata.Name)$($DstSASToken)"

Write-Information " dst full path:  $DstFullPath"

# Write an information log with the current time.
Write-Information "PowerShell timer trigger function ran! TIME: $currentUTCtime"

Write-Information "Backing up storage account..."

# $DstContext = New-AzStorageContext -StorageAccountName "us1target2storage" -StorageAccountKey "cNhRE9+FFn1drjjVX3rXj243K5wyOoeO0yHo7uTA8mqW6ZwOIV+Tiur4wXmM4KBOUC2wMYJM9iioWFqZsVAPvg==" -Environment "Azure"

# Start-AzStorageBlobCopy -AbsoluteUri $SrcFullPath  -DestContainer "california" -DestBlob $($TriggerMetadata.Name) -DestContext $DstContext
