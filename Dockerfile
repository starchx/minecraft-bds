FROM ubuntu:18.04

RUN apt update -y && apt install -y curl unzip

WORKDIR /root/bedrock

RUN curl -o bedrock-server.zip https://minecraft.azureedge.net/bin-linux/bedrock-server-1.10.0.7.zip && \
    unzip bedrock-server.zip && \
    rm -f bedrock-server.zip

COPY permissions.json .
COPY server.properties .
COPY whitelist.json .

WORKDIR /root/bedrock/worlds/dropper
RUN curl -o dropper.zip http://download981.mediafire.com/j6ht3f5nxobg/7ggh5xqzsecog9u/The+Dropper+Remastered.mcworld && \
    unzip dropper.zip && rm dropper.zip && \
    echo 'dropper' > levelname.txt

WORKDIR /root/bedrock
RUN sed -i 's/level-name=.*/level-name=dropper/g' server.properties 
CMD LD_LIBRARY_PATH=. ./bedrock_server
