FROM mcr.microsoft.com/dotnet/sdk:8.0@sha256:35792ea4ad1db051981f62b313f1be3b46b1f45cadbaa3c288cd0d3056eefb83 AS build-env
WORKDIR /App

# Copy entire source directory
COPY ./src ./src


# Set the working directory to the solution directory
WORKDIR /App/src

# Restore dependencies for the solution
RUN dotnet restore

# Build the solution in Release mode
RUN dotnet build -c Release --no-restore

# Run tests and output results in .trx format
# RUN mkdir -p /App/src/TestResults
# RUN dotnet test -c Release --no-build --logger "xml;LogFileName=/App/src/TestResults/TestResults.xml"

# Publish the main project to a separate directory
RUN dotnet publish AProgram -c Release -o /App/publish --no-restore

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0@sha256:6c4df091e4e531bb93bdbfe7e7f0998e7ced344f54426b7e874116a3dc3233ff AS runtime

WORKDIR /App

# Copy the published app from the build environment
COPY --from=build-env /App/publish/ .

# Copy the test results
COPY --from=build-env /App/src/TestResults/ ./TestResults

# ENTRYPOINT ["dotnet", "DotNet.Docker.dll"]
ENTRYPOINT [ "dotnet", "AProgram.dll" ]