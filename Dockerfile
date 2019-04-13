FROM ubuntu:18.04

RUN apt update -y && apt install -y curl unzip

WORKDIR /root/bedrock

RUN curl -o bedrock-server.zip https://minecraft.azureedge.net/bin-linux/bedrock-server-1.10.0.7.zip && \
    unzip bedrock-server.zip && \
    rm -f bedrock-server.zip

COPY permissions.json .
COPY server.properties .
COPY whitelist.json .

WORKDIR /root/bedrock/worlds/LuckyBlocksRace
RUN curl -o LuckyBlocksRace.zip https://download1340.mediafire.com/n4ex5g1h510g/delhqss4y83pr50/LuckyBlocksRaceV6.1.mcworld && \
    unzip LuckyBlocksRace.zip && rm LuckyBlocksRace.zip && \
    echo 'LuckyBlocksRace' > levelname.txt

WORKDIR /root/bedrock
RUN sed -i 's/level-name=.*/level-name=LuckyBlocksRace/g' server.properties 
CMD LD_LIBRARY_PATH=. ./bedrock_server
