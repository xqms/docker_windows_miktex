FROM mcr.microsoft.com/windows/servercore:ltsc2019

WORKDIR /workspace

# Download & install MikTeX
RUN powershell -Command \
  # Download software ; \
  wget https://miktex.org/download/win/miktexsetup-x64.zip -OutFile C:\miktex.zip ; \
  # Install Software ; \
  Expand-Archive -Path c:\miktex.zip -DestinationPath c:\ ; \
  start-Process c:\miktexsetup_standalone.exe -ArgumentList '--package-set=basic --local-package-repository C:\miktex_temp --shared=yes --verbose download' -Wait ; \
  start-Process c:\miktexsetup_standalone.exe -ArgumentList '--package-set=basic --local-package-repository C:\miktex_temp --shared=yes --verbose install' -Wait ; \
  # Remove unneeded files ; \
  Remove-Item c:\miktex_temp -Force -Recurse; \
  Remove-Item c:\miktex.zip -Force; \
  Remove-Item c:\miktexsetup_standalone.exe -Force

# Install additional required packages
RUN mpm.exe --verbose --install xstring
RUN mpm.exe --verbose --install preview
RUN mpm.exe --verbose --install adjustbox
RUN mpm.exe --verbose --install etexcmds
RUN mpm.exe --verbose --install catchfile
RUN mpm.exe --verbose --install ltxcmds
RUN mpm.exe --verbose --install infwarerr
RUN mpm.exe --verbose --install ifplatform
RUN mpm.exe --verbose --install pgfopts
RUN mpm.exe --verbose --install letltxmacro
RUN mpm.exe --verbose --install filemod

# Check if we can run pdflatex
RUN pdflatex -help
