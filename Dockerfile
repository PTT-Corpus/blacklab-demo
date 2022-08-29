# ---- Dependencies ---- 
FROM alpine:latest as base 

WORKDIR /app

# download backend
RUN wget https://github.com/INL/BlackLab/releases/download/v3.0.0/blacklab-server-3.0.0.war 

# download frontend
RUN wget https://github.com/INL/corpus-frontend/releases/download/v2.1.0/corpus-frontend-2.1.0.war


# ------ Indexer ------
FROM openjdk:11 as indexer

WORKDIR /indexer

COPY --from=base /app/blacklab-server-3.0.0.war  ./

RUN unzip ./blacklab-server-3.0.0.war

COPY ./indexer ./


# ------ Server ------
FROM tomcat:9.0 as server

COPY --from=base /app/blacklab-server-3.0.0.war  /usr/local/tomcat/webapps/blacklab-server.war
COPY --from=base /app/corpus-frontend-2.1.0.war  /usr/local/tomcat/webapps/corpus-frontend.war

ADD ./server/backend/blacklab-server.yaml /etc/blacklab/

COPY ./server/frontend/corpus-frontend.properties /etc/blacklab/

COPY ./server/frontend/search.xml /etc/blacklab/projectconfigs/default/

EXPOSE 8080

CMD ["catalina.sh", "run"]