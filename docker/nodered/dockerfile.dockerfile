FROM nodered/node-red
ADD ./nodered/flows/flows.json /usr/src/node-red/flows.json
RUN npm install node-red-contrib-bacnet