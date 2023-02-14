
#Get base SDK Image from Microsoft
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS build-env
WORKDIR /app

#Copy the csproj file and restore dependencies via nuget
COPY *.csproj ./
RUN dotnet restore

# Copy the project files and build our release
COPY . ./
RUN dotnet publish -c Release -o out

#Generate runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine
WORKDIR /app    	
EXPOSE 80
COPY --from=build-env /app/out .
ENTRYPOINT [ "dotnet", "blazor-server-docker.dll"]