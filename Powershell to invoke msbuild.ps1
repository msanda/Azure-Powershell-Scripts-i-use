#msdeply for AWS EBS
$msbuild = Join-Path -Path ${env:ProgramFiles(x86)} -ChildPath "Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe"

$baseDir = "{dir}"
$outputFolder = $baseDir + "EBSOUtput"
$options = "/t:Package /p:configuration=Release /p:Packagelocation=EBSOUTput"
$releaseFolder = $baseDir + "Kremlin\bin\Release"

# if the output folder exists, delete it
if ([System.IO.Directory]::Exists($outputFolder))
{
 [System.IO.Directory]::Delete($outputFolder, 1)
}

# make sure our working directory is correct
cd $baseDir

# create the build command and invoke it 
# note that if you want to debug, remove the "/noconsolelogger" 
# from the $options string
$clean = $msbuild + " ""{path to solution file}"" /t:Clean"
$build = $msbuild + " ""{path to solution file}"" " + $options + " /t:Build"
Invoke-Expression $clean
Invoke-Expression $build

# move all the files that were built to the output folder
[System.IO.Directory]::Move($releaseFolder, $outputFolder)
