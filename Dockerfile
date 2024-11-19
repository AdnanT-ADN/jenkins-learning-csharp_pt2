FROM mcr.microsoft.com/dotnet/sdk:8.0@sha256:35792ea4ad1db051981f62b313f1be3b46b1f45cadbaa3c288cd0d3056eefb83 AS build-env
WORKDIR /App

# Build Solution

## Copy entire source directory
COPY ./src ./src

## Set the working directory to the solution directory
WORKDIR /App/src

## Restore dependencies for the solution
RUN dotnet restore

## Build the solution in Release mode
RUN dotnet build -c Release --no-restore

# Test Solution
RUN mkdir output && chmod 777 output

## Run tests and generate a test results report in JUnit XML format
RUN dotnet test --logger "trx;LogFileName=App/src/output/test-results.trx" 

RUN pwd
RUN ls -a
RUN ls output -a

# \
#     && dotnet tool install -g trx2junit \
#     && export PATH="$PATH:/root/.dotnet/tools" \
    # && trx2junit /output/test-results.trx

# Prod Build

# FROM mcr.microsoft.com/dotnet/sdk:8.0@sha256:35792ea4ad1db051981f62b313f1be3b46b1f45cadbaa3c288cd0d3056eefb83 AS runtime
# WORKDIR /App

# COPY --from=build-env /App .
# ENTRYPOINT [ "dotnet", "AProgram.dll" ]