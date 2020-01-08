FROM mysql:5.7

# Create database
ENV MYSQL_DATABASE sistema_llaves

# Copy file for entry ponint 
COPY ./Desarrollo/DockerFullScriptSQL.sql /docker-entrypoint-initdb.d

EXPOSE 3306