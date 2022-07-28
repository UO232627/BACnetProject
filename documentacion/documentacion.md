# DOCUMENTACIÓN BACNET

## Configuración del *Gateway*

1. Entrar en la configuración de conexiones
![Menú configuración conexiones](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/conexiones.PNG "Configuración de conexiones")
2. En el apartado *BACnet Slave* (En la interfaz de usuario de *SW67938*), indicar la IP que se quiere que tenga el *gateway* (tiene que estar en el rango de direcciones del router al que va a estar conectado), máscara de subred y demás parámetros
![Configuración conexión BACnet](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/conexionesBACnet.PNG "Configuración conexión BACnet")
3. Configurar conexión *MQTT*
    - En la zona de comunicaciones, en el apartado *MQTT*, indicar la dirección IP, puerto, etc. del broker al que se quiere conectar el *gateway*
    - Indicar un client ID (el nombre del *gateway*) único de ser posible, ya que es como se identificará de cara a otros dispositivos
    - **¡IMPORTANTE!** Indicar un valor de *keep alive* distinto de 0. Si no se indica, el broker puede rechazar los intentos de conexión del gateway
    - *OPCIONAL* Se pueden indicar un mensaje *will* para las desconexiones no correctas y las nuevas conexiones y un mensaje de conexión que el *gateway* enviará al broker cuando se conecte a este (hay que indicar topic y contenido)
![Configuración conexión MQTT](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/conexionesMQTT.PNG "Configuración conexión MQTT")
4. Configurar conexión Ethernet indicando dirección IP, máscara de subred y gateway
![Configuración conexion Ethernet](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/conexionesEthernet.PNG "Configuración conexión Ethernet")
5. Configurar el protocolo *NTP*
    - Como ejemplo se ha usado *pool.ntp.org* y un tiempo de 1000 (en segundos)
![Configuración NTP](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/conexionesNTP.PNG "Configuración NTP")
6. Configurar los topics *MQTT* (las publicaciones y las suscripciones se configuran por separado)
![Menú configuración MQTT](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/MQTT.PNG "Menú configuración MQTT")
    - *MQTT* Publish (topics en los que se quiere publicar)
      - **Topic**: Topic al que se quiere suscribir
      - **Retained**: Valor retained del mensaje
      - **QoS**: *QoS* del mensaje
      - **Data type**: Tipo del valor (elegir entre uno de los prefijados)
      - **Dimension**: Tamaño del valor (**POR CONFIRMAR** Tiene que coincidir con el tamaño indicado en la parte *BACnet*)
      - **Position**: Posición dentro del array (**¡IMPORTANTE!** En la documentación se indica que es el index dentro del array, pero tiene que coincidir con la posición en memoria de la configuración *BACnet*)
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
![Configuración MQTT](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/MQTTConfiguracion.PNG "Configuración MQTT")
7. Configurar los accesos *BACnet* (igual para read y write)
![Menú configuración BACnet](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/BACnet.PNG "Menú configuración BACnet")
    - **Data type**: Tipo del dato (seleccionar entre los predefinidos)
      - Para trabajar con float, usar los *analog*
    - **Eng. unit**: Unidad del dato (selecciona entre las predefinidas)
    - **Position**: Posición en memoria del dato (**¡IMPORTANTE!** Tiene que coincidir con la posición indicada en la parte *MQTT*)
    - **Start bit**: Bit inicial para los valores en binario
    - **Length**: Tamaño del dato (**POR CONFIRMAR** Tiene que coincidir con el tamaño indicado en la parte *MQTT*)
    - **Mnemonic**: Descripción del topic
![Configuración BACnet](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/BACnetConfiguracion.PNG "Configuración BACnet")
8. (**Solo la primera vez, luego se puede hacer sin desconectar el dispositivo ni teniendo que cambiar la posición del switch**)
![Menú configuración carga](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/carga.PNG "Menú configuración carga")
Cargar la configuración en el *gateway*. Para ello:
    - Apagar el *gateway*
    - Pone el switch en la posición ON
    - Encender el *gateway*
    - Conectar el cable ethernet del PC al *gateway*
    - Indicar la dirección *192.168.2.205* (**¡IMPORTANTE!** La carga de configuraciones posteriores se hará indicando la dirección IP con la que se ha configurado)
    - Seleccionar las operaciones a realizar (actualización de firmware, cargar configuración o ambas) y ejecutar
    - Apagar el *gateway*
    - Poner el switch en la posición OFF
![Configuración carga](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/cargaConfiguracion.PNG "Configuración carga")
9. Conectar el *gateway* al router
10. Comprobar que si añadimos la red del router a **YABE**, detecta automáticamente el *gateway*

### Exportar/Importar configuraciones

- Para exportar o importar configuraciones del *gateway* solo hay que copiar el directorio con la configuración que queramos en el directorio *Projects* dentro de la instalación de la interfaz de configuración
    - Ruta de ejemplo: `C:\Program Files (x86)\ADFweb\Compositor_SW67938\Projects`
- Si se quiere hacer una copia de alguna configuración, copiar y pegar dentro del directorio y cambiar el nombre por el que se quiera

## Despliegue del entorno

- Para el despliegue del entorno, se proporcionan un fichero docker-compose y un fichero Dockerfile con todo lo necesario para su ejecución
- Además, son necesarios dos ficheros:
    1. Un fichero de configuración con los *flows* de *NODE-RED* que se quieren cargar (se puede ver un ejemplo de este *flow* en la siguiente sección de la documentación)
    2. Un fichero de configuración para cargar en el broker *Mosquitto* en el que se abre el acceso a direcciones externas
- Antes de hacer el despliegue de los contenedores, hay que hacer el build de la imagen de *NODE-RED*
    - `docker-compose -d --build nodered`
- Una vez creada la imagen ya se puede desplegar los contenedores
    - `docker-compose up`

## Conversión de mensajes MQTT del IAQ al *Gateway* (*NODE-RED*)

- Para la transformación de mensajes mediante *NODE-RED*, se puede usar un *flow* en *NODE-RED* como este [ejemplo](https://github.com/UO232627/gatewayProject/blob/main/splitMQTT.json)

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

- Pasos para visualizar una red en YABE:
    1. Entrar en el menú de añadir red haciendo click en la cruz verde ![Menú nueva red](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/a%C3%B1adirNuevaRed.PNG "Menú nueva red")
    2. Indicar el puerto en el que se quiere añadir y la dirección de la red a la que está conectado el gateway ![Menú nueva red 2](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/a%C3%B1adirRed2.PNG "Menú nueva red 2)
    3. YABE debería detectar automáticamente todos los dispositivos BACnet conectados a esa red y clickando encima, se verían todos sus objetos (ventana *Address space* ![Dispositivo visible](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/dispositivoVisible.PNG "Dispositivo visible")
    4. En la ventana *Properties* podemos ver el contenido y los valores de todas las propiedades del elemento seleccionado en la ventana *Address space* ![Propiedades dispositivo](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/propiedadesDispositivo.PNG "Propiedades dispositivo") ![Propiedades objeto](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/propiedadesObjeto.PNG "Propiedades objeto")
    5. Arrastrando los elementos a la ventana *Subscriptions, Periodic Polling, Events/Alarms* podemos visualizar sus valores en tiempo real (en casos como los enteros nos pedirá que le indiquemos el periodo de refresco de información) ![Valores en tiempo real](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/valoresTiempoReal.PNG "Valores en tiempo real")

- Si se hace algún cambio en la configuración del *gateway*, hay que eliminar la red en *YABE* y volver a añadirla para ver reflejados los cambios

- Si queremos ver el contenido de los mensajes para saber como es la estructura de un mensaje *BACnet*, podemos usar la herramienta *Wireshark* y filtrar los paquetes de la red por *BACnet*
  - Aquí es donde veríamos los paquetes generados en la escritura/lectura mediante *NODE-RED*

### Notas

- [Página oficial de *BACnet* y documentación](http://www.bacnet.org/)

- La [documentación del fabricante](https://www.adfweb.com/download/filefold/MN67938_ENG.pdf) del *gateway* está desactualizada
  - Se indica que el *LED L4* no se usa, pero mientras el *gateway* no esté conectado al broker, se antendrá encendida (**esto hay que verificarlo ya que no estoy completamente seguro de si es por la conexión al broker o también se apagaría con la conexión a un dispositivo *BACnet***)
  - El *LED L2* es para *MQTT*, no para *BACnet* como se indica en la documentación del fabricante (el funcionamiento es igual a como se indica)
  - El *LED L3* es para *BACnet*, no para *MQTT* como se indica en la documentación del fabricante (el funcionamiento es igual a como se indica)

- Con este modelo no se pueden usar conexiones *BACnet/MTSP* mediante *RS485*, solo se puede usar *BACnet/IP*
