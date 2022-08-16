# GUÍA DE CONFIGURACIÓN RÁPIDA Nanoenvi BACnet

## ARQUITECTURA DEL ENTORNO

![Esquema del entorno](img\esquemaEntorno.png "Esquema del entorno")

El entorno de trabajo consta de:

- **IAQ**: Lee los valores de gases en el ambiente y envía las medidas a un broker
- **Raspberry Pi**: Usada como punto de acceso WiFi, contiene un cliente Node-RED y un broker MQTT Mosquitto para las conexiones y el tratamiendo de los mensajes. Se comunica con el IAQ mediante el protocolo MQTT y con los dispositivos BACnet mediante el protocolo BACnet
  - Broker Mosquitto: Recibe los mensaje generados por el IAQ en el topic *medida*
  - Cliente Node-RED: Se suscribe al topic con los mensajes del IAQ, los recibe cuando llega uno nuevo al broker y los procesa para hacer escrituras BACnet
- **Dispositivos BACnet**: Dispositivos BACnet con los que se quiere que interactue el sistema

### FLUJO DE TRABAJO EN Node-RED

El flujo de trabajo habitual en Node-RED es:

1. Añadir el nodo que se quiera usar desde el desplegable de la izquierda. Los más interesantes para este caso son `suscriptor/publicador MQTT`, `función` y `lectura/escritura BACnet`
2. Editar los nodos haciendo doble click sobre ellos. Al hacerlo, se abre un desplegable de configuración en el que podemos modificar la configuración específica de cada nodo. **No olvidarse de hacer click en *DONE* o *UPDATE* para guardar los cambios (esquina superior derecha de la configuración)**
3. Para conectar los nodos entre si, se hace click en uno de los puntos de conexión del nodo y se arrastra hasta hasta el punto de conexión de otro nodo. Si el punto está a la izquierda es de entrada y a la derecha de salida. Un nodo se puede conectar con varios nodos desde el mismo punto de conexión.
4. Cuando el flow esté configurado totalmente, hacemos click en *DEPLOY* (esquina superior derecha) y ya tendríamos el flow funcionando. Esto hay que hacerlo en cada cambio que hagamos, sino no será efectivo.

### FUNCIONAMIENTO DEL FLOW DE EJEMPLO

![Flow de ejemplo](img\flowRaspberry.png "Flow de ejemplo")

El flow de ejemplo incluido es un ejemplo del funcionamiento de las escrituras BACnet.

La funcionalidad de cada uno de los nodos es:

1. *fromIAQ*: Se suscribe al broker MQTT y recibe los mensajes que envía el IAQ
2. *transformIntoJS*: Convierte el mensaje en formato JSON del broker MQTT a un objeto JavaScript.
3. *separateMeasuresMQTT*: Prepara el topic con el que se van a reenviar las medidas separadas al broker MQTT añadiendole el UUID del IAQ. Además, deja en el cuerpo del mensaje solo el array con las medidas, eliminando toda la demás información
4. *splitMeasures*: Separa cada una de las medidas en el array y hace que los nodos siguientes trabajen sobre cada una de ellas de manera independiente
5. *editMessage*: Añade al topic en el que se va a publicar el nombre de la medida y deja en el cuerpo del mensaje el valor de la medida
6. *toBroker*: Envía la medida de nuevo al broker MQTT
7. *co2*: Función que añade al cuerpo del mensaje la configuración que necesita el nodo de escritura BACnet. En él se indica el tipo del valor a escribir (correspondiente al *app-tag* del nodo de escritura) y el valor que se quiere escribir (sacado del array de medidas separado anteriormente). Todas estas funciones son similares estructuralmente, cambiando solo el tipo o el valor.
8. *escrituraCo2*: Nodo de escritura BACnet. Recibe el mensaje que se quiere escribir y envía una petición de escritura BACnet al dispositivo que se le indique. Su configuración está explicada en detalle en el apartado siguiente

## PASOS PARA LA CONFIGURACIÓN

1. Conectar la *Raspberry Pi* a la corriente y a la red mediante Ethernet
2. Conectar a la corriente el IAQ. Ya viene configurado, solo necesita tener funcionando la *Raspberry Pi*
3. Conectar el PC al punto de acceso *WiFi* de la *Raspberry Pi*:
    - SSID: *REDBERRYPI*
    - Contraseña: *raspberry*
4. Acceder al cliente *NODE-RED* en 192.168.4.1:1880
5. Los nodos *MQTT* ya vienen configurados por lo que no hace falta cambiar nada. En caso de que no se quiera volver a enviar al broker las medidas separadas, se pueden eliminar los nodos `splitMeasures`, `editMessage` y `toBroker`
6. Los mensajes recibidos del *broker MQTT* están ya separados en cada uno de los gases y/o medidas y conectados a un nodo de escritura BACnet.
7. Configurar las instancias de los nodos de escritura:
    - *Instancias*:
        - Indicar el tipo BACnet del valor en el apartado *type*
        - Crear una instancia para la escritura. Para ello, seleccionar en el desplegable la opción *Add new BACnet-Instance* (o seleccionar una ya creada) y hacer click en el botón de editar a su derecha
        ![Propiedades](img\properties.png "Propiedades")
        - Indicar el nombre que se le quiere dar y el indice al que se corresponde en el dispositivo BACnet
        ![Instance](img\instance.png "Instance")
8. Configurar los dispositivos y las interfaces (clientes) de los nodos de escritura
    ![Device and interface](img\deviceAndInterface.png "Device and interface")
    - *Device*:
        - Crear un nuevo dispositivo. Para ello, seleccionar en el desplegable la opción *Add new BACnet-Device* (o seleccionar uno ya creado) y hacer click en el botón de editar a su derecha
        - Indicar el nombre que se le quiere dar al dispositivo
        - Indicar la dirección IP del dispositivo dentro de la red
        ![Device](img\device.png "Device")
    - *Client*:
        - Crear un nuevo cliente. Para ello, seleccionar en el desplegable la opción *Add new BACnet-Device* (o seleccionar uno ya creado) y hacer click en el botón de editar a su derecha
        - Indicar el nombre que sele quiere dar al cliente
        - Indicar la dirección IP de la red
        - Indicar la dirección de broadcast de la red
        - Indicar el puerto de escucha (por defecto 47808)
        - Indicar el timeout para la escritura (por defecto (6000)
        ![Client](img\client.png "Client")

9. Estas configuraciones se quedan guardadas y se pueden usar en todos los nodos BACnet del flow
10. En caso de que se quiera modificar alguna de las demás configuraciones del nodo de escritura, en el *anexo 1* se encuentra información más detallada de como hacerlo
11. **Hacer el *deploy* del proyecto**
12. En este punto, la configuración ya está terminada y las lecturas/escrituras de los dispositivos *BACnet* ya deberían estar funcionando con normalidad

## ANEXO 1: CONFIGURACIÓN DETALLADA DE NODOS DE ESCRITURA/LECTURA BACnet

1. *Properties*
    - *Name*: Nombre que se le quiere dar al nodo
    - *Type*: Tipo BACnet de la instancia de escritura
    - *Instance*: Instancia del objeto al que se quiere acceder. Se le indica nombre e index (dentro del dispositivo BACnet) y se queda guardada para su reutilización
2. *Value*
    - *App-tag*: Tipo del dato (Tiene que coincidir con el indicado en el `msg.payload.values` de la función correspondiente). Aunque se indique mediante la función previa, hay que indicarlo en el nodo de escritura obligatoriamente
    - *Value*: Valor que se quiere escribir (Dejar en blanco, se ha indicado en el `msg.payload.values` de la función correspondiente)
3. *Properties*
    - *Property*: Propiedad en la que se quiere escribir. Por defecto se ha dejado la propiedad *present-value (85)*
    - *Priority*: Prioridad de la escritura. Por defecto se ha dejado en 15. Para modificarla simplemente se tiene que indicar la que se quiere usar.
4. *Device and Interface*
    - *Device*:
        - *Name*: Nombre que se le quiere dar
        - *Address*: Dirección IP del dispositivo
    - *Client*:
        - *Name*: Nombre que se le quiere dar
        - *Interface*: Dirección IP de la red
        - *Broadcast*: Dirección de broadcast de la red a la que está conectado el dispositivo (por defecto X.X.X.255)
        - *Port*: Puerto al que está conectado el dispositivo BACnet (por defecto 47808)
        - *adpu Timeout*: Tiempo de espera para el fallo del mensaje (por defecto 6000)
