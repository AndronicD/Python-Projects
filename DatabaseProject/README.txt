Nume: Andronic Dragos Sebastian
Grupa: 342C3

Deploy local:
docker login container-registry.oracle.com
docker pull container-registry.oracle.com/database/express:latest
docker run -d --name my-oracle-db2 -p 1521:1521 -p 6000:5500 -e ORACLE_PWD=parolaAiaPuternic4 container-registry.oracle.com/database/express:latest
docker exec -it my-oracle-db sqlplus system/parolaAiaPuternic4@XE