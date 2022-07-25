# DOCUMENTACIÓN CONEXIÓN GATEWAY

## Configuración del *Gateway*

1. En el apartado *BACnet Slave* (En la interfaz de usuario de *SW67938*), indicar la IP que se quiere que tenga el *gateway* (tiene que estar en el rango de direcciones del router al que va a estar conectado), máscara de subred y demás parámetros
2. Configurar conexión *MQTT*
    - En la zona de comunicaciones, en el apartado *MQTT*, indicar la dirección IP, puerto, etc. del broker al que se quiere conectar el *gateway*
    - Indicar un client ID (el nombre del *gateway*) único de ser posible, ya que es como se identificará de cara a otros dispositivos
    - **¡IMPORTANTE!** Indicar un valor de *keep alive* distinto de 0. Si no se indica, el broker puede rechazar los intentos de conexión del gateway
    - *OPCIONAL* Se pueden indicar un mensaje *will* para las desconexiones no correctas y las nuevas conexiones y un mensaje de conexión que el *gateway* enviará al broker cuando se conecte a este (hay que indicar topic y contenido)
3. Configurar conexión Ethernet indicando dirección IP, máscara de subred y gateway
4. Configurar el protocolo *NTP*
    - Como ejemplo se ha usado *pool.ntp.org* y un tiempo de 1000
5. Configurar los topics *MQTT*
    - *MQTT* Publish (topics en los que se quiere publicar)
      - **Topic**: Topic al que se quiere suscribir
      - **Retained**: Valor retained del mensaje
      - **QoS**: *QoS* del mensaje
      - **Data type**: Tipo del valor (elegir entre uno de los prefijados)
      - **Dimension**: Tamaño del valor (**POR CONFIRMAR** Tiene que coincidir con el tamaño indicado en la parte *BACnet*)
      - **Position**: Posición dentro del array (**IMPORTANTE** En la documentación se indica que es el index dentro del array, pero tiene que coincidir con la posición en memoria de la configuración *BACnet*)
      - **Template**: Plantilla del mensaje que se quiere recibir (es muy recomendable indicar una plantilla para no recibir mensaje con un formato no válido)
        - Las plantillas se definen con texto plano, además de tres palabras clave:
          - $ VALUE $: Valor de un dato
          - $ TIME $: Fecha y hora del mensaje
          - $ DESC $: Descripción del mensaje
      - **OnChange**: Si se selecciona, se publica el topic cuando el valor cambia
      - **OnCMD**: Si se selecciona, se publica el topic cuando se le indica
      - **OnTimer**: Si se selecciona, se publica el topic en el tiempo indicado
      - **Time(ms)**: Tiempo entre dos publicaciones
      - **Mnemonic**: Descripción del topic
    - *MQTT* Subscribe (topics a los que se va a suscribir el *gateway*)
      - **Topic**: Topic al que se quiere suscribir
      - **QoS**: QoS del mensaje
      - **Data type**: Tipo del valor (elegir uno de los prefijados)
      - **Dimension**: Tamaño del valor (**POR CONFIRMAR** Tiene que coincidir con el tamaño indicado en la parte *BACnet*)
      - **Position**: Posición dentro del array (**¡IMPORTANTE!** En la documentación se indica que es el index dentro del array, pero tiene que coincidir con la posición en memoria de la configuración *BACnet*)
      - **Template**: Plantilla del mensaje que se quiere recibir (es muy recomendable indicar una plantilla para no recibir mensaje con un formato no válido)
        - Las plantillas se definen con texto plano, además de tres palabras clave:
          - $ VALUE $: Valor de un dato
          - $ TIME $: Fecha y hora del mensaje
          - $ DESC $: Descripción del mensaje
      - **Mnemonic**: Descripción del topic
6. Configurar los accesos *BACnet* (igual para read y write)
    - **Data type**: Tipo del dato (seleccionar entre los predefinidos)
      - Para trabajar con float, usar los *analog*
    - **Eng. unit**: Unidad del dato (selecciona entre las predefinidas)
    - **Position**: Posición en memoria del dato (**¡IMPORTANTE!** Tiene que coincidir con la posición indicada en la parte *MQTT*)
    - **Start bit**: Bit inicial para los valores en binario
    - **Length**: Tamaño del dato (**POR CONFIRMAR** Tiene que coincidir con el tamaño indicado en la parte *MQTT*)
    - **Mnemonic**: Descripción del topic
7. Cargar la configuración en el *gateway*. Para ello:
    - Apagar el *gateway*
    - Pone el switch en la posición ON
    - Encender el *gateway*
    - Conectar el cable ethernet del PC al *gateway*
    - Indicar la dirección *192.168.2.205*
    - Seleccionar las operaciones a realizar (actualización de firmware, cargar configuración o ambas) y ejecutar
    - Apagar el *gateway*
    - Poner el switch en la posición OFF
8. Conectar el *gateway* al router
9. Comprobar que si añadimos la red del router a **YABE**, detecta automáticamente el *gateway*

## Conversión de mensajes MQTT del IAQ al *Gateway* (*NODE-RED*)

- Para la transformación de mensajes mediante *NODE-RED*, se puede usar un *flow* de ejemplo como [este](https://github.com/UO232627/gatewayProject/blob/main/splitMQTT.json)

- Los elementos del *flow* son:
  - **fromIAQ**: Nodo que recibe mensajes *MQTT*
  - **transformIntoJS**: Convierte el mensaje recibido en un objeto *JsvaScript*
  - **separateMeasures**: Modifica el topic del mensaje con la cabecera en la que se va a publicar (con el UUID del dispositivo) y deja en el payload solo las medidas, eliminando la parte de información del dispositivo
  - **splitMeasures**: Separa todas las medidas
  - **editMessage**: Añade al topic el tipo de medida que es y pone el valor de la medida en el payload del mensaje
  - **toBroker**: Envia los mensajes *MQTT* al broker

## Creación de peticiones de lectura/escritura de prueba contra el *Gateway* (*NODE-RED*)

- **¡IMPORTANTE!** La lectura y escritura solo se puede hacer contra los objetos *BACnet* del *gateway* del tipo adecuado (en función de si son de lectura o escritura en la configuración del *gateway*)
- **¡IMPORTANTE!** Para hacer este tipo de operaciones en *NODE-RED*, se necesita la paleta **node-red-contrib-bacnet**

- Configuración escritura:
  - **Properties**
    - **Name**: Nombre del nodo
    - **Type**: Tipo del valor (hay que seleccionar el mismo que se ha indicado en el objeto del *gateway*)
    - **Instance**: Instancia del objeto al que se quiere acceder. Se le puede indicar nombre e index dentro del array de objetos del *gateway*
  - **Value**
    - **App-tag**: Tipo de dato
    - **Value**: Valor que se quiere escribir
  - **Properties**
    - **Property**: Propiedad en la que se quiere escribir
    - **Priority**: [Prioridad de la escritura](https://www.domat-int.com/en/bacnet-a-brief-introduction-to-the-basics-part-4)
  - **Device and Interface**
    - **Device**: Dispositivo al que se quiere acceder. Hay que indicarle nombre y dirección IP (la del *gateway*)
    - **Client**: Nodo al que se quiere acceder
      - *Name*: Nombre del nodo
      - *Interface*: Dirección IP (la del router al que está conectado el *gateway*)
      - *Broadcast*: Dirección de broadcast de la red a la que está conectado el *gateway*
      - *Port*: Puerto al que está conectado el *gateway*
      - *adpu Timeout*: Tiempo de espera para el fallo del mensaje

- Configuración lectura:
  - **Properties**
    - **Name**: Nombre del nodo
    - **Type**: Tipo del valor (hay que seleccionar el mismo que se ha indicado en el objeto del *gateway*)
    - **Instance**: Instancia del objeto al que se quiere acceder. Se le puede indicar nombre e index dentro del array de objetos del *gateway*
  - **Properties**
    - **Property Id**: Propiedad en la que se quiere escribir
  - **Device and Interface**
    - **Device**: Dispositivo al que se quiere acceder. Hay que indicarle nombre y dirección IP (la del *gateway*)
    - **Client**: Nodo al que se quiere acceder
      - *Name*: Nombre del nodo
      - *Interface*: Dirección IP (la del router al que está conectado el *gateway*)
      - *Broadcast*: Dirección de broadcast de la red a la que está conectado el *gateway*
      - *Port*: Puerto al que está conectado el *gateway*
      - *adpu Timeout*: Tiempo de espera para el fallo del mensaje

- [Ampliación sobre objetos, tipos y tags](http://www.bacnet.org/Bibliography/ES-7-96/ES-7-96.htm)
- Estas peticiones y respuestas, se pueden ver mediante *Wireshark*

## Visualización de la red en **YABE**/**WIRESHARK** [(Más detalles)](https://www.domat-int.com/en/bacnet-a-brief-introduction-to-the-basics-pt-2)

- Para añadir una red y nuevos dispositivos a YABE, hacer click en la cruz verde y en el apartado *BACnet/IP over Udp*, indicar el puerto y la dirección del router al que está conectado el gateway
- *YABE* debería detectar automáticamente todos los dispositivos BACnet conectados a la red y sus objetos (Ventana *Address space*)
  - Arrastrando los objetos a la ventana *Subscriptions, Periodic Polling, Events/Alarms*, podemos visualizar sus valores en tiempo real (en casos como los enteros nos pedirá que indiquemos cada cuanto queremos refrescar la información)
  - Si se hace algún cambio en la configuración del *gateway*, hay que eliminar la red en *YABE* y volver a añadirla para ver los cambios reflejados

- Si queremos ver el contenido de los mensajes para saber como es la estructura de un mensaje *BACnet*, podemos usar la herramienta *Wireshark* y filtrar los paquetes de la red por *BACnet*
  - Aquí es donde veríamos los paquetes generados en la escritura/lectura mediante *NODE-RED*

### Notas

- [Página oficial de *BACnet* y documentación](http://www.bacnet.org/)

- La [documentación del fabricante](https://www.adfweb.com/download/filefold/MN67938_ENG.pdf) del *gateway* está desactualizada
  - Se indica que el *LED L4* no se usa, pero mientras el *gateway* no esté conectado al broker, se antendrá encendida (**esto hay que verificarlo ya que no estoy completamente seguro de si es por la conexión al broker o también se apagaría con la conexión a un dispositivo *BACnet***)
  - El *LED L2* es para *MQTT*, no para *BACnet* como se indica en la documentación del fabricante (el funcionamiento es igual a como se indica)
  - El *LED L3* es para *BACnet*, no para *MQTT* como se indica en la documentación del fabricante (el funcionamiento es igual a como se indica)

- Con este modelo no se pueden usar conexiones *BACnet/MTSP* mediante *RS485*, solo se puede usar *BACnet/IP*
