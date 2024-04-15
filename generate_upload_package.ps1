# Check for silent mode
$silentMode = $false
if ($args -contains "-silent" -or $args -contains "-s") {
    $silentMode = $true
}

# Display initial instructions and prompt for confirmation only if not in silent mode
if (-not $silentMode) {
    Write-Host "This script will publish the project and create a zip file of the published files." -ForegroundColor Cyan
    Write-Host "Press y to proceed or n to exit." -ForegroundColor Cyan

    $confirmation = Read-Host "Do you want to proceed? (y/n)"
    if ($confirmation -ne 'y') {
        Write-Host "Exiting script." -ForegroundColor Red
        exit
    }
}

# Set Execution Policy
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# Find .csproj file in the current directory
$projectFile = Get-ChildItem -Path . -Filter *.csproj | Select-Object -First 1

# If no .csproj file is found, check for a .sln file
if (-not $projectFile) {
    $projectFile = Get-ChildItem -Path . -Filter *.sln | Select-Object -First 1
}

if (-not $projectFile) {
    Write-Host "No .csproj or .sln file found in the current directory." -ForegroundColor Red
    exit
}

# Extract project name from file path
$projectName = [System.IO.Path]::GetFileNameWithoutExtension($projectFile.Name)

# Publish the project
if (-not $silentMode) {
    Write-Host "Publishing the project..." -ForegroundColor Green
}
dotnet publish -c Release > $null

# Set the name of the zip file
$zipFileName = "$projectName.zip"
$suggestedZipName = "($zipFileName)"

# Inform the user about overwriting an existing zip file only if not in silent mode
if (-not $silentMode) {
    Write-Host "If there's already a .zip file with the same name, it will be overwritten." -ForegroundColor Yellow
}

# Prompt user for zip file name with a suggestion only if not in silent mode
if (-not $silentMode) {
    Write-Host "Enter a name for the zip file (press Enter to use the suggested name): $suggestedZipName" -ForegroundColor Yellow
    $userZipName = Read-Host

    # Check if the user input is empty, if so, use the suggested name
    if ([string]::IsNullOrWhiteSpace($userZipName)) {
        $userZipName = $zipFileName
    }
} else {
    $userZipName = $zipFileName
}

# Check if the user input has a .zip extension, if not, add it
if (-not $userZipName.EndsWith('.zip')) {
    $userZipName += '.zip'
}

# Remove existing zip file if present
Remove-Item -Path $userZipName -ErrorAction SilentlyContinue

# Compress files into a zip file
if (-not $silentMode) {
    Write-Host "Creating zip file..." -ForegroundColor Green
}
Compress-Archive -Path ".\bin\Release\net6.0\linux-x64\publish\*" -DestinationPath $userZipName

# Prompt user to confirm exit only if not in silent mode
if (-not $silentMode) {
    Write-Host "Zip file created: $userZipName" -ForegroundColor Green
    Write-Host "Press any key to exit..." -ForegroundColor Cyan
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}
