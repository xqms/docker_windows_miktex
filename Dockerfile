FROM mcr.microsoft.com/windows/nanoserver:20H2

RUN curl.exe -L -o miktex.zip https://miktex.org/download/win/miktexsetup-x64.zip
RUN tar.exe -xf miktexsetup-x64.zip
RUN miktexsetup_standalone.exe --package-set=basic --verbose download
RUN miktexsetup_standalone.exe --package-set=basic --verbose --shared=yes install
