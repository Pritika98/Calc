FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY simplecalc/*.csproj ./simplecalc/

# copy everything else and build app
COPY simplecalc/. ./simplecalc/
WORKDIR /app/simplecalc
RUN dotnet publish -c Release -o out

# run tests
FROM build AS testrunner
WORKDIR /app/test
COPY UnitTestProject1/. .
CMD ["dotnet", "test", "--logger:trx"]
