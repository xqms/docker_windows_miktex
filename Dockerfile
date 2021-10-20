FROM mcr.microsoft.com/windows/servercore:ltsc2019

WORKDIR /workspace

COPY Retry-Command.ps1 /
COPY install_miktex.ps1 /

# Download & install MikTeX
RUN powershell -File C:\install_miktex.ps1

# Check if we can run pdflatex
RUN pdflatex -help
