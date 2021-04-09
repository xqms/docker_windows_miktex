FROM mcr.microsoft.com/windows/servercore:ltsc2019

WORKDIR /workspace

RUN powershell -Command \

  # Download software ; \

  wget https://miktex.org/download/win/miktexsetup-x64.zip -OutFile C:\miktex.zip ; \

  # Install Software ; \

  Expand-Archive -Path c:\miktex.zip -DestinationPath c:\ ; \
  start-Process c:\miktexsetup_standalone.exe -ArgumentList '--package-set=basic --local-package-repository /c/miktex_temp --shared=yes --verbose download' -Wait ; \
  start-Process c:\miktexsetup_standalone.exe -ArgumentList '--package-set=basic --local-package-repository /c/miktex_temp --shared=yes --verbose install' -Wait ; \

  # Remove unneeded files ; \

  Remove-Item c:\miktex_temp -Force -Recurse; \
  Remove-Item c:\miktex.zip -Force; \
  Remove-Item c:\miktexsetup_standalone.exe -Force

RUN pdflatex -help
