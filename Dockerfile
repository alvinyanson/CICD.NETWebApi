FROM mcr.microsoft.com/dotnet/sdk:8.0 as build-env
WORKDIR /app

COPY CICD.NetWebAPI/*.csproj ./
RUN dotnet restore

COPY CICD.NetWebAPI/. ./CICD.NetWebAPI/
RUN dotnet publish ./CICD.NetWebAPI -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "K8S.DriverAPI.dll"]