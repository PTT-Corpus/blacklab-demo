# ---- Dependencies ---- 
FROM alpine:latest as base 

WORKDIR /app

# download backend
RUN wget https://github.com/INL/BlackLab/releases/download/v3.0.1/blacklab-server-3.0.1.war

# download frontend
RUN wget https://github.com/INL/corpus-frontend/releases/download/v3.0.2/corpus-frontend.war

# ------ Indexer ------
FROM openjdk:11 as indexer

WORKDIR /indexer

COPY --from=base /app/blacklab-server-3.0.1.war  ./

RUN unzip ./blacklab-server-3.0.1.war

COPY ./indexer ./


# ------ Server ------
FROM tomcat:9.0 as server

COPY --from=base /app/blacklab-server-3.0.1.war  /usr/local/tomcat/webapps/blacklab-server.war
COPY --from=base /app/corpus-frontend.war  /usr/local/tomcat/webapps/corpus-frontend.war

ADD ./server/backend/blacklab-server.yaml /etc/blacklab/

COPY ./server/frontend/corpus-frontend.properties /etc/blacklab/

COPY ./server/frontend/search.xml /etc/blacklab/projectconfigs/default/

EXPOSE 8080

CMD ["catalina.sh", "run"]