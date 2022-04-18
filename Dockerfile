
#Get base SDK Image from Microsoft
FROM mcr.microsoft.com/dotnet/core/sdk:6.0 AS build-env
WORKDIR /app

#Copy the csproj file and restore dependencies via nuget
COPY *.csproj ./
RUN dotnet restore

# Copy the project files and build our release
COPY . ./
RUN dotnet publish -c Release -o out

#Generate runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:6.0
WORKDIR /app    	
EXPOSE 80
COPY --from=build-env /app/out .
ENTRYPOINT [ "dotnet", "Deploy Blazor Server with Docker.dll"]