$ErrorActionPreference = "Stop"

. C:\Retry-Command.ps1

# Download software
Retry-Command -TimeoutInSecs 2 -Verbose -ScriptBlock {
    wget https://miktex.org/download/win/miktexsetup-x64.zip -OutFile C:\miktex.zip
}

# Install Software
Expand-Archive -Path c:\miktex.zip -DestinationPath c:\
Start-Process c:\miktexsetup_standalone.exe -ArgumentList '--package-set=basic --local-package-repository C:\miktex_temp --shared=yes --verbose download' -Wait
Start-Process c:\miktexsetup_standalone.exe -ArgumentList '--package-set=basic --local-package-repository C:\miktex_temp --shared=yes --verbose install' -Wait

# Remove unneeded files
Remove-Item c:\miktex_temp -Force -Recurse
Remove-Item c:\miktex.zip -Force
Remove-Item c:\miktexsetup_standalone.exe -Force

# Reload PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Install additional packages
'xstring', 'preview', 'adjustbox', 'etexcmds', 'catchfile', 'ltxcmds', 'infwarerr', 'ifplatform', 'pgfopts', 'letltxmacro', 'filemod', 'collectbox', 'ifoddpage', 'varwidth' |
    Foreach-Object {
        $PackageName=$_
        Retry-Command -TimeoutInSecs 2 -Verbose -ScriptBlock {
            Write-Verbose "Executing mpm.exe --verbose --install=$PackageName `n"
            & mpm.exe --verbose --install=$PackageName
            if($lastexitcode -ne '0')
            {
                Throw "failed"
            }
        }
    }
