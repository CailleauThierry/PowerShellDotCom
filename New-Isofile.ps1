<# PowerShell can turn regular folders into ISO files. ISO files are binary files that can be mounted and then behave like a read-only CD-ROM drive.

In the past, ISO files were commonly used to mount installation media. Today, you can easily create your own ISO files created from your own folders and files. This way, you could create a simple backup system, or share projects easily among colleagues. Since ISO files are just a single file, they can be easily shared, and since Windows mounts them via double-click and shows them inside Windows Explorer as a CDROM drive, you can immediately work with the data without the need to extract or unzip anything.

In contrast to VHD image files, mounting ISO files does not require administrator privileges. Anyone can mount and use ISO files.

Since there is no built-in cmdlet to convert a folder structure into an ISO file, you need to call the internal APIs yourself. The code below defines the new function New-IsoFile:
 #>
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


<# Once you run this code, you now have a new cmdlet named "New-IsoFile". Creating a ISO file from an existing folder structure now is a piece of cake - just make sure the source file path exists:

 
PS> New-IsoFile -NewIsoFilePath $env:temp\MyTest.iso -ImageName Holiday -SourceFilePath 'C:\HolidayPics'  
 
You are rewarded by a new ISO file located in your temp folder (or whichever file path you specified). If you followed the example, simply open the temp folder:

 
PS> explorer /select,$env:temp\MyTest.iso 
 
When you double-click the ISO file in Windows Explorer, the image is mounted as a new CD ROM drive, and you can immediately see the copy of the data stored in your image file.

Right-clicking the new CD-ROM drive in Windows Explorer and choosing "Eject" from context menu will dismount the drive again. #>