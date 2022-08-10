# GUÍA DE CONFIGURACIÓN RÁPIDA Nanoenvi BACnet

## ESQUEMA DE EJEMPLO

![Esquema del entorno](img\esquemaEntorno.png "Esquema del entorno")

## PASOS PARA LA CONFIGURACIÓN

1. Conectar la *Raspberry Pi* a la corriente y a la red mediante Ethernet
2. Conectar a la corriente el IAQ. Ya viene configurado, solo necesita tener funcionando la *Raspberry Pi*
3. Conectar el PC al punto de acceso *WiFi* de la *Raspberry Pi*:
    - SSID: *REDBERRYPI*
    - Contraseña: *raspberry*
4. Acceder al cliente *NODE-RED* en 192.168.4.1:1880
5. Los nodos *MQTT* ya vienen configurados por lo que no hace falta cambiar nada. En caso de que no se quiera volver a enviar al broker las medidas separadas, se pueden eliminar los nodos `splitMeasures`, `editMessage` y `toBroker`
6. Configurar las lecturas/escrituras siguiendo la estructura del flow de ejemplo:

    ![Flow de ejemplo](img\flowRaspberry.png "Flow de ejemplo")

    - Separar las medidas y valores necesarios:

        ```js
        msg.payload.values = [
            { type: 4, value: msg.payload[0].v }
        ]
        return msg;
        ```

        - *type*: Correspondiente al *app-tag* del módulo de escritura BACnet
        - *value*: Valor que se quiere escribir en el dispositivo. Cada medida está en uno de los indices del array de medidas
    - Configurar las lecturas/escrituras:
        1. *Properties*
            - *Name*: Nombre del nodo
            - *Type*: Tipo del valor
            - *Instance*: Instancia del objeto al que se quiere acceder. Se le indica nombre e index y se queda guardada
        2. *Value*
            - *App-tag*: Tipo del dato (Tiene que coincidir con el indicado en el `msg.payload.values` indicado anteriormente)
            - *Value*: Valor que se quiere escribir (Dejar en blanco, se ha indicado en el `msg.payload.values`)
        3. *Properties*
            - *Property*: Propiedad en la que se quiere escribir
            - *Priority*: Prioridad de la escritura
        4. *Device and Interface*
            - *Device*:
                - *Name*: Nombre que se le quiere dar
                - *Address*: Dirección IP del dispositivo
            - *Client*:
                - *Name*: Nombre que se le quiere dar
                - *Interface*: Dirección IP de la red
                - *Broadcast*: Dirección de broadcast de la red a la que está conectado el dispositivo (X.X.X.255)
                - *Port*: Puerto al que está conectado el *gateway* (por defecto 47808)
                - *adpu Timeout*: Tiempo de espera para el fallo del mensaje (por defecto 6000)
7. **Hacer el *deploy* del proyecto**
8. En este punto, la configuración ya está terminada y las lecturas/escrituras de los dispositivos *BACnet* ya deberían estar funcionando con normalidad
