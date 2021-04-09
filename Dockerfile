FROM mcr.microsoft.com/windows/server/core:ltsc2019

WORKDIR /workspace
RUN curl.exe -L -o miktex.zip https://miktex.org/download/win/miktexsetup-x64.zip
RUN tar.exe -xf miktex.zip
RUN miktexsetup_standalone.exe --package-set=basic --verbose download
RUN miktexsetup_standalone.exe --package-set=basic --verbose --shared=yes install
