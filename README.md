# azure-blob-data-metaData-sync

因为要跨azure不同云的同步，所以不能通过简单的pass比如azure data factory等实现。

但是也有两个选项： 

1） azcopy命令： azCopy.ps1文件的实现
2） 通过powershell命令： Start-AzStorageBlobCopy系列命令。

建议使用powershell命令，这些命令有自己的错误尝试机制。同时也可以通过相应的.net core API实现对元数据标签的操作。

https://docs.microsoft.com/en-us/dotnet/api/azure.storage.blobs.specialized.blobbaseclient.setmetadata?view=azure-dotnet#azure-storage-blobs-specialized-blobbaseclient-setmetadata(system-collections-generic-idictionary((system-string-system-string))-azure-storage-blobs-models-blobrequestconditions-system-threading-cancellationtoken)

sample：

old API：
$blobfiles.ICloudBlob.SetMetadata()

new API：
$dict =New-Object System.Collections.Generic.Dictionary"[String,String]"
$dict.Add('key1','value1')
$dict.Add('key2','value2')
$blob.BlobBaseClient.SetMetadata($dict)

