function New-IsoFile
{
  param
  (
    # path to local folder to store in 
    # new ISO file (must exist)
    [Parameter(Mandatory)]
    [String]
    $SourceFilePath,
    # name of new ISO image (arbitrary, 
    # turns later into drive label)
    [String]
    $ImageName = 'MyCDROM',
    # path to ISO file to be created
    [Parameter(Mandatory)]
    [String]
    $NewIsoFilePath,
    # if specified, the source base folder is
    # included into the image file
    [switch]
    $IncludeRoot
  )
  # use this COM object to create the ISO file:
  $fsi = New-Object -ComObject IMAPI2FS.MsftFileSystemImage
  # use this helper object to write a COM stream to a file:
  # compile the helper code using these parameters:
  $cp = [CodeDom.Compiler.CompilerParameters]::new()
  $cp.CompilerOptions = '/unsafe'
  $cp.WarningLevel = 4
  $cp.TreatWarningsAsErrors = $true
  $code = @"
  using System;
  using System.IO;
  using System.Runtime.InteropServices.ComTypes;
  namespace CustomConverter
  {
   public static class Helper 
   {
    // writes a stream that came from COM to a filesystem file
    public static void WriteStreamToFile(object stream, string filePath) 
    {
     // open output stream to new file
     IStream inputStream = stream as IStream;
     FileStream outputFileStream = File.OpenWrite(filePath);
     int bytesRead = 0;
     byte[] data;
     // read stream in chunks of 2048 bytes and write to filesystem stream:
     do 
     {
      data = Read(inputStream, 2048, out bytesRead);  
      outputFileStream.Write(data, 0, bytesRead);
     } while (bytesRead == 2048);
     outputFileStream.Flush();
     outputFileStream.Close();
    }
    // read bytes from stream:
    unsafe static private byte[] Read(IStream stream, int byteCount, out int readCount) 
    {
     // create a new buffer to hold the read bytes:
     byte[] buffer = new byte[byteCount];
     // provide a pointer to the location where the actually read bytes are reported:
     int bytesRead = 0;
     int* ptr = &bytesRead;
     // do the read:
     stream.Read(buffer, byteCount, (IntPtr)ptr);   
     // return the read bytes by reference to the caller:
     readCount = bytesRead;
     // return the read bytes to the caller:
     return buffer;
    } 
  }
}
"@
Add-Type -CompilerParameters $cp -TypeDefinition $code;
# define the ISO file properties:
# create CDROM, Joliet and UDF file systems
$fsi.FileSystemsToCreate = 7 
$fsi.VolumeName = $ImageName
# allow larger-than-CRRom-Sizes
$fsi.FreeMediaBlocks = -1    
$msg = 'Creating ISO File - this can take a couple of minutes.'
Write-Host $msg -ForegroundColor Green
# define folder structure to be written to image:
$fsi.Root.AddTreeWithNamedStreams($SourceFilePath,$IncludeRoot. IsPresent)
# create image and provide a stream to read it:
$resultimage = $fsi.CreateResultImage()
$resultStream = $resultimage.ImageStream
# write stream to file
[CustomConverter.Helper]::WriteStreamToFile($resultStream, $NewIsoFilePath)
Write-Host 'DONE.' -ForegroundColor Green
}