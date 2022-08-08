# DOCUMENTACIÓN BACNET

## *GATEWAY*

### Configuración

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
    - **¡IMPORTANTE!** En los elementos definidos como de lectura, no se pueden hacer operaciones de escritura
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

## Despliegue del entorno en local

- Para el despliegue del entorno, se proporcionan dos ficheros con todo lo necesario para su ejecución
    - [**docker-compose.yml**](https://github.com/UO232627/gatewayProject/blob/main/docker/docker-compose.yml) - Configuración de los dos servicios que se quieren desplegar indicando puertos (por defecto los estandar) y las rutas de los ficheros necesarios para la configuración
    - [**dockerfile**](https://github.com/UO232627/gatewayProject/blob/main/docker/nodered/dockerfile.dockerfile) - Añade los flows al contenedor e instala el paquete necesario para poder hacer operaciones *BACnet*
- Además, son necesarios dos ficheros:
    1. Un [fichero *JSON* de configuración con los *flows* de *NODE-RED*](https://github.com/UO232627/gatewayProject/blob/main/docker/nodered/flows/flows.json) que se quieren cargar (el *flow* de ejemplo se explicará en la siguiente sección de la documentación)
    2. Un [fichero de configuración de *Mosquitto*](https://github.com/UO232627/gatewayProject/blob/main/docker/mosquitto/conf/mosquitto.conf) para abrir el acceso a direcciones externas
- Antes de hacer el despliegue de los contenedores, hay que hacer el build de la imagen de *NODE-RED*
    - `docker-compose up -d --build nodered`
- Una vez creada la imagen ya se puede desplegar los contenedores
    - `docker-compose up`

Mantener los nombres de los ficheros. En caso de modificarlos, cambiar la referencia correspondiente en el docker-compose y el dockerfile

## Visualización de la red en **YABE**/**WIRESHARK** en local [(Más detalles)](https://www.domat-int.com/en/bacnet-a-brief-introduction-to-the-basics-pt-2)

- Pasos para visualizar una red en YABE:
    1. Entrar en el menú de añadir red haciendo click en la cruz verde bajo la barra de herramientas ![Menú nueva red](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/a%C3%B1adirNuevaRed.PNG "Menú nueva red")
    2. Indicar el puerto en el que se quiere añadir y la dirección de la red a la que está conectado el gateway ![Menú nueva red 2](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/a%C3%B1adirRed2.PNG "Menú nueva red 2")
    3. YABE debería detectar automáticamente todos los dispositivos BACnet conectados a esa red ysus objetos ![Dispositivo visible](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/dispositivoVisible.PNG "Dispositivo visible")
    4. En la ventana *Properties* podemos ver el contenido y los valores de todas las propiedades del elemento seleccionado ![Propiedades dispositivo](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/propiedadesDispositivo.PNG "Propiedades dispositivo") ![Propiedades objeto](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/propiedadesObjeto.PNG "Propiedades objeto")
    5. Arrastrando los elementos a la ventana *Subscriptions, Periodic Polling, Events/Alarms* podemos visualizar sus valores en tiempo real (en casos como los enteros nos pedirá que le indiquemos el periodo de refresco de información) ![Valores en tiempo real](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/valoresTiempoReal.PNG "Valores en tiempo real")

- Si se hace algún cambio en la configuración del *gateway*, hay que eliminar la red en *YABE* y volver a añadirla para ver reflejados los cambios

Si queremos ver el contenido de los mensajes para saber como es la estructura de un mensaje *BACnet*, podemos usar la herramienta *Wireshark*
- Comenzamos a capturar la red que nos interesa monitorizar, en nuestro caso *Ethernet* (click derecho - Iniciar captura) ![wiresharkEthernet](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/wiresharkEthernet.PNG "wiresharkEthernet")
- Una vez iniciada la captura, podemos filtrar los paquetes que interceptamos, por ejemplo MQTT y BACnet en este caso ![wiresharkFiltro](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/wiresharkFiltro.PNG "wiresharkFiltro")
- Aquí se puede ver toda la información que contiene un mensaje. Si queremos ir al *"valor"* de la petición, debemos abrir el apartado APDU ![wiresharkMensaje](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/wiresharkMensaje.PNG "wiresharkMensaje") ![wiresharkAPDU](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/wiresharkAPDU.PNG "wiresharkAPDU")
    - En este caso, nuestro valor es *"Present Value (real): 0"*

## Conversión de mensajes MQTT del IAQ al *Gateway* en local (*NODE-RED*)

- Para la transformación de mensajes mediante *NODE-RED*, se puede usar un *flow* en *NODE-RED* como este [ejemplo](https://github.com/UO232627/gatewayProject/blob/main/nodered/splitMQTT.json)

![flow](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/flow.PNG "flow")

Los elementos del *flow* son:
- **fromIAQ**: Nodo que recibe mensajes *MQTT*
    - **Server**: Configuración de la conexión al broker *MQTT*. Se necesita al menos la dirección IP y el puerto, aunque según la configuración del broker puede ser necesarios datos de autenticación, de topics, etc.)
    - **Action**: Selecciona si se suscribe a un topic concreto o dinámicamente según un tipo de mensaje
    - **QoS**: QoS de los mensajes
    - **Output**: Tipo de la salida (por defecto la autodetecta)
    - **Name**: Nombre que se le da al nodo
- **transformIntoJS**: Convierte el mensaje recibido en un objeto *JsvaScript*
- **separateMeasures**: Modifica el topic del mensaje con la cabecera en la que se va a publicar (toBACnet/UUID del dispositivo) y deja en el payload solo las medidas, eliminando la parte de información del dispositivo
- **splitMeasures**: Separa todas las medidas para trabajar de forma independiente sobre ellas
- **editMessage**: Añade al topic el nombre de la medida y deja en el payload del mensaje el valor leido para esa medida
- **toBroker**: Envia los mensajes *MQTT* al broker (un mensaje por cada medida a su topic correspondiente)
    - **Server**: Configuración de la conexión al broker *MQTT*. Se necesita al menos la dirección IP y el puerto, aunque según la configuración del broker puede ser necesarios datos de autenticación, de topics, etc.)
    - **Topic**: Topic en el que quiere publicar (si se deja vacío se usa el topic que se pase en el mensaje)
    - **QoS**: QoS de los mensajes
    - **Retain**: Valor de la flag "retained"
    - **Name**: Nombre que se le da al nodo

La configuración de todos los parámetros de estos elementos se puede modificar en el fichero JSON de configuración que se carga en el contenedor nodered al crear el entorno de ejecución

## Lectura/Escritura contra un dispositivo BACnet en local (*Gateway*)(*NODE-RED*)

- **¡IMPORTANTE!** La lectura y escritura solo se puede hacer contra los objetos *BACnet* del *gateway* del tipo adecuado (en función de si son de lectura o escritura en la configuración del *gateway*)
- **¡IMPORTANTE!** Para hacer este tipo de operaciones en *NODE-RED*, se necesita la paleta/modulo **node-red-contrib-bacnet** (instalada por defecto en el entorno proporcionado)

Configuración escritura:
1. **Properties**
- **Name**: Nombre del nodo
- **Type**: Tipo del valor (hay que seleccionar el mismo que se ha indicado en el objeto del *gateway*. Esto puede verse desde *YABE*)
- **Instance**: Instancia del objeto al que se quiere acceder. Se le indica nombre e index para que se quede guardada (**¡IMPORTANTE!** El index no es el de su posición dentro del array de objetos del dispositivo, sino el index dentro de los objetos del mismo tipo) ![Index 1](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/index1.PNG "Index 1") ![Index 2](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/index2.PNG "Index 2")
2. **Value**
- **App-tag**: Tipo de dato (puede verse en *YABE* seleccionando la propiedad en la que queremos escribir en la ventana *Properties*) ![Tag](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/tag.PNG "Tag") 
- **Value**: Valor que se quiere escribir (tiene que ser válido según su tipo)
3. **Properties**
- **Property**: Propiedad en la que se quiere escribir (puede verse el nombre en *YABE* seleccionando la propiedad en la que queremos escribir en la ventana *Properties*) 
- **Priority**: [Prioridad de la escritura](https://www.domat-int.com/en/bacnet-a-brief-introduction-to-the-basics-part-4)
4. **Device and Interface**
- **Device**: Dispositivo al que se quiere acceder. Hay que indicarle nombre y dirección IP (la del *gateway* en este caso)
- **Client**:
  - *Name*: Nombre que se le quiere dar
  - *Interface*: Dirección IP (la del router al que está conectado el *gateway*)
  - *Broadcast*: Dirección de broadcast de la red a la que está conectado el *gateway* (X.X.X.255)
  - *Port*: Puerto al que está conectado el *gateway* (por defecto 47808)
  - *adpu Timeout*: Tiempo de espera para el fallo del mensaje (por defecto 6000)
     
**NOTA**: Cuando se escribe en un objeto int, cada unidad se representa con el valor 256. Es decir, si escribimos en *NODE-RED* el valor 4, en la propiedad *present-value* del gateway veríamos 1024. Sin embargo, a la hora de publicar al *broker MQTT*, el valor que se visualiza es el correcto, es decir, 4.

Configuración lectura:
  1. **Properties**
    - **Name**: Nombre del nodo
    - **Type**: Tipo del valor (hay que seleccionar el mismo que se ha indicado en el objeto del *gateway*. Esto puede verse desde *YABE*)
    - **Instance**: Instancia del objeto al que se quiere acceder. Se le indica nombre e index para que se quede guardada (**¡IMPORTANTE!** El index no es el de su posición dentro del array de objetos del dispositivo, sino el index dentro de los objetos del mismo tipo) ![Index 1](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/index1.PNG "Index 1") ![Index 2](https://github.com/UO232627/gatewayProject/blob/main/documentacion/images/index2.PNG "Index 2")
  2. **Properties**
    - **Property Id**: Propiedad en la que se quiere leer (puede verse el nombre en *YABE* seleccionando la propiedad en la que queremos escribir en la ventana *Properties*) 
  3. **Device and Interface**
    - **Device**: Dispositivo al que se quiere acceder. Hay que indicarle nombre y dirección IP (la del *gateway* en este caso)
    - **Client**:
      - *Name*: Nombre que se le quiere dar
      - *Interface*: Dirección IP (la del router al que está conectado el *gateway*)
      - *Broadcast*: Dirección de broadcast de la red a la que está conectado el *gateway* (X.X.X.255)
      - *Port*: Puerto al que está conectado el *gateway* (por defecto 47808)
      - *adpu Timeout*: Tiempo de espera para el fallo del mensaje (por defecto 6000)

- Si enlazamos el nodo de lectura a un nodo debug, podemos ver el mensaje en *NODE-RED* para poder trabajar con él
- [Ampliación sobre objetos, tipos y tags](http://www.bacnet.org/Bibliography/ES-7-96/ES-7-96.htm)
- Estas peticiones y respuestas, se pueden ver mediante *Wireshark*

## Notas sobre el gateway

- [Página oficial de *BACnet* y documentación](http://www.bacnet.org/)

- La [documentación del fabricante](https://www.adfweb.com/download/filefold/MN67938_ENG.pdf) del *gateway* está desactualizada
  - Se indica que el *LED L4* no se usa, pero mientras el *gateway* no esté conectado al broker, se mantendrá encendida (**esto hay que verificarlo ya que no estoy completamente seguro de si es por la conexión al broker o también se apagaría con la conexión a un dispositivo *BACnet***)
  - El *LED L2* es para *MQTT*, no para *BACnet* como se indica en la documentación del fabricante (el funcionamiento es igual a como se indica)
  - El *LED L3* es para *BACnet*, no para *MQTT* como se indica en la documentación del fabricante (el funcionamiento es igual a como se indica)

- Con el modelo de *gateway* usado para las pruebas no se pueden usar conexiones *BACnet/MTSP* mediante *RS485*, solo se puede usar *BACnet/IP*


## PRUEBA DE CONCEPTO - DESPLIEGUE DEL ENTORNO EN UNA RASPBERRY PI

Como se ha puede ver en el apartado [conversiones de datos](https://github.com/UO232627/BACnetProject/blob/main/documentacion/documentacion.md#conversi%C3%B3n-de-mensajes-mqtt-del-iaq-al-gateway-en-local-node-red) y [lecturas/escrituras](https://github.com/UO232627/BACnetProject/blob/main/documentacion/documentacion.md#lecturaescritura-contra-un-dispositivo-bacnet-en-local-gatewaynode-red), para poder integrar dispositivos *MQTT* como el *IAQ* con otros BACnet, es necesario tratar los datos y usar ciertos programas. Para facilitar esto, se ha creado un entorno de funcionamiento mediante una *Raspberry Pi* en el que todo lo necesario está preparado para su uso directo.

### Configuración de la *rapsberry pi*

#### Instalación de un *S.O.* en la *raspberry*

- El primer paso para la creación de nuestro entorno es tener una *raspberry* operativa. Para ello, nos descargamos el programa [Raspberry PI Imager](https://www.raspberrypi.com/software/).
- Una vez descargado e instalado, insertamos la *SD* o el dispositivo de almacenamiento que queramos usar para nuestro sistema operativo
- En el apartado *Operating System*, seleccionamos el *SO* que queramos instalar. En nuestro caso, como no necesitamos una interfaz de usuario, instalaremos la versión *Lite* de 64-bit

![Imager SO 1](https://github.com/UO232627/BACnetProject/blob/main/documentacion/images/imagerSO1.PNG "Imager SO 1")
![Imager SO 2](https://github.com/UO232627/BACnetProject/blob/main/documentacion/images/imagerSO2.PNG "Imager SO 2")
![Imager SO 3](https://github.com/UO232627/BACnetProject/blob/main/documentacion/images/imagerSO3.PNG "Imager SO 3")

- Una vez seleccionado, en la pestaña *Storage*, seleccionamos nuestro dispositivo de almacenamiento

![Imager storage](https://github.com/UO232627/BACnetProject/blob/main/documentacion/images/imagerStorage.PNG "Imager storage")

- A continuación, en la rueda de configuración de la parte inferior derecha, configuramos las conexiones del sistema. En este caso solo necesitamos habilitar las conexiones *SSH* y dar un nombre de usuario y contraseña para hacer login en la *raspberry*

![Imager configuración](https://github.com/UO232627/BACnetProject/blob/main/documentacion/images/imagerConfig.PNG "Imager configuración")

- Una vez terminada la configuración, hacemos click en el botón *Write* y se empezará a cargar el *SO*. Una vez finalizado, podemos extraer el dispositivo de almacenamiento e insertarlo en la *raspberry*

#### Conexión inicial a la *raspberry*

Para la configuración de nuestro entorno, necesitamos varios [scripts](https://github.com/UO232627/BACnetProject/tree/main/files/scripts) y [ficheros](https://github.com/UO232627/BACnetProject/tree/main/files/docker) necesarios para su ejecución.

Para añadirlos a la *raspberry*, nos conectamos mediante *SSH* con un programa como [*MobaXterm*](https://mobaxterm.mobatek.net/download.html), por ejemplo. Para ello, con el propio *MobaXterm* tenemos una herramienta de escaneo de la red.

![Escaner red](https://github.com/UO232627/BACnetProject/blob/main/documentacion/images/mobaHerramientaEscaner.PNG "Escaner red")
![Red escaneada](https://github.com/UO232627/BACnetProject/blob/main/documentacion/images/mobaEscaneada.PNG "Red escaneada")

El dispositivo que estamos buscando, tiene que ser uno de los que tiene habilitada la conexión por *SSH*. Localizamos la dirección de la *raspberry* (172.16.30.175 en este caso) y ya podemos conectarnos.

Para conectarnos, creamos una sesión *SSH* con la dirección que hemos localizado y se conectará automáticamente.

![Moba sesión](https://github.com/UO232627/BACnetProject/blob/main/documentacion/images/mobaSession.PNG "Moba sesión")
![Moba SSH](https://github.com/UO232627/BACnetProject/blob/main/documentacion/images/mobaSSH.PNG "Moba SSH")

Nos pedirá nos logueamos con nuestro usuario y contraseña. Una vez dentro, añadimos el directorio [*files*](https://github.com/UO232627/BACnetProject/tree/main/files) en el directorio raíz del usuario (en el que aparecemos por defecto al iniciar la conexión)

![Moba raíz](https://github.com/UO232627/BACnetProject/blob/main/documentacion/images/mobaRaiz.PNG "Moba raíz")

**NOTA: LA MEJORA DE LA CONFIGURACIÓN ESTÁ EN PROCESO Y ESTO ES SOLO UN PRIMER ACERCAMIENTO MEDIANTE UNA PRUEBA DE CONCEPTO. SE QUIERE GENERAR UN SCRIPT QUE HAGA TODO SIN FALTA DE MEDIACIÓN DEL USUARIO ENTRE LA EJECUCIÓN DE CADA SCRIPT**

#### Punto de acceso inalámbrico

Para poder conectar nuestros dispositivos, se configurará nuestra *raspberry* como un punto de acceso wifi. De esta manera podremos conectar nuestro *broker MQTT* a ella y así poder procesar los datos y enviarlos a los dispositivos BACnet.

Se han seguido los siguientes [pasos](https://www.raspberrypi.com/documentation/computers/configuration.html#setting-up-a-routed-wireless-access-point) para la configuración. Para facilitar la preparación, se puede hacer mediante los scripts preparados para este propósito.

**NOTA: Tras la ejecución de los dos scripts que se mencionan a continuación, el sistema se reiniciará, por lo que hay que volver a introducir el usuario y la contraseña para tener acceso de nuevo**

Contenido de los scripts y configuración:
- [update.sh](https://github.com/UO232627/BACnetProject/blob/main/files/scripts/update.sh): Script necesario para actualizar el sistema operativo de la *raspberry*. **¡IMPORTANTE! Es el primero que hay que ejecutar**.
    - Para la ejecución del script usar el comando `sudo sh ./files/scripts/update.sh`
- [access_point.sh](https://github.com/UO232627/BACnetProject/blob/main/files/scripts/acces_point.sh): Script que configura el punto de acceso wifi. Se debe ejecutar despues de haber actualizado el sistema. Este script tiene varias configuraciones que se pueden modificar:
    - *dhcpcd.conf*: Al final de este fichero, podemos indicar la dirección IP (estática) que queremos que tenga nuestro entorno de funcionamiento, modificando el valor del parámetro en las últimas líneas.
   
   ```
   interface wlan0
        static ip_address=192.168.4.1/24
        nohook wpa_supplicant
   ```
   Como se puede ver, en este caso la dirección de red es 192.168.4.1. En caso de que entre en conflicto con alguna otra red o subred, habría que seleccionar otra y cambiar la configuración en los demás apartados correspondientes.

    - *dnsmasq.conf*: Aquí se puede indicar el rango de direcciones que se quiere tener para los nuevos dispositivos que se conecten. Esto podemos configurarlo en la línea `dhcp-range=192.168.4.2,192.168.4.20,255.255.255.0,24h`. Aquí se puede indicar la dirección inicial (192.168.4.2), la final (192.168.4.20), la máscara de subred (255.255.255.0) y el tiempo que se da la dirección (24 horas). En este fichero también podemos indicar el alias que se le quiere dar a la red. En caso de haber modificado la dirección en el fichero *dhcpcd.conf*, también deberíamos cambiarla aquí `address=/gw.wlan/192.168.4.1`.
    - *hostapd.conf*: En este fichero se configura todo lo relacionado con la red wifi que se va a ver de cara a los dispositivos. Los parámetros más susceptibles a ser configurados son:
        - *country_code*: País de la señal wifi. Esto hace que cambien las frecuencias de la red.
        - *hw_mode*: Frecuencia de la red (más información en la documentación oficial). En caso de modificarlo hay que cambiar el *channel* a uno compatible
        - *ssid*: Nombre de la red
        - *wpa_passphrase*: Contraseña de la red
       
    - Para la ejecución del script usar el comando `sudo sh ./files/scripts/access_point.sh`

**NOTA: Si se quiere evitar que los clientes conectados al punto de acceso puedan acceder a la red ethernet del router, consultar la [documentación oficial](https://www.raspberrypi.com/documentation/computers/configuration.html#setting-up-a-routed-wireless-access-point) para ver las modificaciones necesarias en el script**

Una vez finalizada la ejecución de ambos scripts, la red debería estar visible para conectarse mediante cualquier dispositivo, introduciendo la contraseña que se haya configurado.

#### Configuración de Docker y sus contenedores (**primera vez**)

El segundo paso en la configuración de la *raspberry* es la dockerización del entorno y la creación de los contenedores necesarios para su correcto funcionamiento. De manera similar a la [prueba inicial hecha en local](https://github.com/UO232627/BACnetProject/blob/main/documentacion/documentacion.md#despliegue-del-entorno-en-local), se crearán dos contenedores, uno para añadir un cliente *NODE-RED* y otro para la creación de un *broker MQTT* mediante *mosquitto*.

El proceso para la creación es similar al hecho en local, solo que esta vez se hace con un [script](https://github.com/UO232627/BACnetProject/blob/main/files/scripts/environment.sh) que nos instala todos los paquetes y dependencias necesarias para su instalación.

Para la ejecución del script, usar el comando `sudo sh ./files/scripts/environment.sh`

Una vez el script termine de ejecutarse, el entorno de trabajo ya estará disponible para conectar nuestros *IAQ* y configurar lo necesario en *NODE-RED*.

**NOTA: La prueba de concepto está configurada para que el script cargue en *NODE-RED* un [flow de ejemplo](https://github.com/UO232627/BACnetProject/blob/main/files/docker/nodered/flows/flows.json), pero podría configurarse para que no cargue nada y empezar a hacer un flow desde cero**

#### Configuración de Docker y sus contenedores (**segunda vez y posteriores**)

Si el sistema se ha reiniciado o apagado por algún motivo, debemos volver a levantar los servicios docker cuando tengamos el sistema funcionando de nuevo. Para ello, usamos el mismo fichero docker-compose que en el caso de que se haga una instalación de cero.

En primer lugar, si se ha actualizado o cambiado algo de la imagen de nuestro contenedor de *NODE-RED* (como por ejemplo que se haya cambiado el flow que carga inicialmente), debemos generar la nueva imagen. Para ello, nos situamos en el directorio *docker*:

`cd ./files/docker`

Una vez dentro, hacemos el build de la imagen:

`sudo docker build ./nodered/dockerfile.dockerfile`

Cuando tengamos la nueva imagen generada, desde el mismo directorio ya podemos desplegar nuestros servicios:

`sudo docker-compose up`

Con esto ya tendríamos el *broker MQTT* el cliente *NODE-RED* corriendo y a la escucha.

### Conexión a la red y sistema de ejemplo

Dependiendo de si el nuevo entorno se quiere añadir a un sistema ya en funcionamiento o se quiere crear un nuevo entorno completamente aislado, podría interesarnos la conexión de los dispositivos vía *ethernet* o vía punto de acceso.

En el ejemplo hecho para la prueba de concepto, nos encontramos con un esquema similar al siguiente:

![Esquema entorno](https://github.com/UO232627/BACnetProject/blob/main/documentacion/images/esquemaEntorno.png "Esquema entorno")

En este caso y como se puede ver por las direcciones, los dispositivos están conectados de la siguiente manera:
- *IAQ*: Conectado vía Wifi al punto de acceso generado por la *raspberry*
- *PC*: Conectado vía ethernet a un router y vía Wifi al punto de acceso generado por la *raspberry*
- *Gateway*: Conectado vía ethernet a un router

Estas conexiones podrían variarse como se comentaba anteriormente. Podríamos por ejemplo conectar directamente nuestro dispositivo *BACnet* al punto de acceso Wifi de la *raspberry* para tener una red "aislada" y/o sin salida a la red del router.

Con esta configuración, nuestro *IAQ* enviaría mensajes *MQTT* al broker *mosquitto* que hay en ejecución en la *raspberry*. Estos mensajes se interceptan y procesan en el cliente *NODE-RED* de manera que separa cada medida y la envía a un nodo de escritura *BACnet*. El [flow de ejemplo](https://github.com/UO232627/BACnetProject/blob/main/files/docker/nodered/flows/flows.json) usado para esta prueba de concepto es el siguiente:

![Flow raspberry](https://github.com/UO232627/BACnetProject/blob/main/documentacion/images/flowRaspberry.PNG "Flow raspberry")

**NOTA: LA MEJORA DEL FLOW ESTÁ EN PROCESO Y SE TRATARÁ DE ESCRIBIR DE FORMA DINÁMICA PARA QUE NO SEA NECESARIO TENER UNA FUNCIÓN POR CADA UNA DE LAS ESCRITURAS QUE SE PRETENDE HACER**

**NOTA: El acceso a *NODE-RED* se hace desde 192.168.4.1:1880 con un dispositivo con conexión a la red generada por el punto de acceso de la *raspberry***

Conceptualmente es muy similar al que se usó en la [prueba en local](https://github.com/UO232627/BACnetProject/blob/main/documentacion/documentacion.md#conversi%C3%B3n-de-mensajes-mqtt-del-iaq-al-gateway-en-local-node-red). Los únicos cambios son las direcciones IP de los dispositivos conectados (tanto del *IAQ* como del dispositivo *BACnet*) y cómo se hace la separación de los elementos del mensaje original.

Esta separación, ahora se hace mediante una función para cada medida. Los parametros de configuración que se almacenan en `msg.payload.values` para la [escritura BACnet](https://github.com/UO232627/BACnetProject/blob/main/documentacion/documentacion.md#lecturaescritura-contra-un-dispositivo-bacnet-en-local-gatewaynode-red) son:

```
msg.payload.values = [
    { type: 4, value: msg.payload[0].v }
]
return msg;
```

- *type*: Correspondiente al *app-tag* del módulo de escritura BACnet
- *value*: Valor que se quiere escribir en el dispositivo

Una vez procesado el mensaje *MQTT*, se escribe en el dispositivo BACnet y se envían las medidas de manera individual de nuevo al broker *MQTT* con un tópic individual para cada medida, dentro de un topic por cada ID de un *IAQ*. En este punto, ya podemos [leer en YABE](https://github.com/UO232627/BACnetProject/blob/main/documentacion/documentacion.md#visualizaci%C3%B3n-de-la-red-en-yabewireshark-en-local-m%C3%A1s-detalles) las propiedades de cada objeto del dispositivo para comprobar los valores ya escritos.
