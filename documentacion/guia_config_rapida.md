# GUÍA DE CONFIGURACIÓN RÁPIDA

Puede acceder a la documentación completa del proyecto [aquí](https://github.com/UO232627/BACnetProject/blob/main/documentacion/documentacion.md)

## ESQUEMA DE EJEMPLO

![Esquema](https://github.com/UO232627/BACnetProject/blob/main/documentacion/images/esquemaEntorno.png "Esquema")

## PASOS PARA LA CONFIGURACIÓN

1. Conectar la *raspberry pi* a la corriente y a la red mediante ethernet
2. [Conectarse mediante *SSH*](https://github.com/UO232627/BACnetProject/blob/main/documentacion/documentacion.md#conexi%C3%B3n-inicial-a-la-raspberry) a la *raspberry pi*. Para ello:
    - Descargar [*MobaXterm*](https://mobaxterm.mobatek.net/download.html) u otro programa que permita crear conexiones *SSH*
    - Localizar la dirección de la *raspberry pi* en la red. En *MobaXterm* podemos usar la herramienta *Network scanner*
    - Iniciar una sesión *SSH* en esa dirección (USUARIO: *pi* CONTRASEÑA: *raspberry*)
4. [Montar los contenedores en *Docker*](https://github.com/UO232627/BACnetProject/blob/main/documentacion/documentacion.md#configuraci%C3%B3n-de-docker-y-sus-contenedores-segunda-vez-y-posteriores). Para ello, introducir los siguiente comandos en la consola:
```
cd ./files/docker
sudo docker-compose up
```
5. Conectar a la corriente el IAQ. Ya viene configurado, solo necesita tener funcionando la *raspberry pi*
6. Conectar el PC al punto de acceso *Wi-Fi* de la *raspberry pi* (SSID: *REDBERRYPI* PSSWD: *raspberry*)
7. Acceder al cliente *NODE-RED* en 192.168.4.1:1880
8. [Configurar el flow de ejemplo](https://github.com/UO232627/BACnetProject/blob/main/documentacion/documentacion.md#conexi%C3%B3n-a-la-red-y-sistema-de-ejemplo):
    - La configuración de los nodos *MQTT* se puede dejar por defecto, ya vienen configurados
    - Configurar el cliente y dispositivo *BACnet* 
    - Crear las lecturas/escrituras necesarias (información detallada [aquí](https://github.com/UO232627/BACnetProject/blob/main/documentacion/documentacion.md#lecturaescritura-contra-un-dispositivo-bacnet-en-local-gatewaynode-red))
    - **Hacer el *deploy* del proyecto**
9. En este punto, la configuración ya está terminada y las lecturas/escrituras de los dispositivos *BACnet* ya deberían estar funcionando con normalidad
