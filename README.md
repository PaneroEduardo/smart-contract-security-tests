# Título del Proyecto

Este repositorio forma parte del TFM titulado "Diseño y aplicación de un plan de respuesta a incidentes en redes Blockchain". El proyecto contiene una serie de scripts, contratos y herramientas relacionadas con la seguridad de contratos inteligentes en Ethereum.

## Estructura de carpetas

El proyecto se organiza en las siguientes carpetas:

- `scripts`: Contiene los scripts en Python relacionados con los contratos y la seguridad.
- `contracts`: Contiene los contratos inteligentes desarrollados para este proyecto.
- `deploy`: Contiene los archivos de despliegue de los contratos.
- `tools`: Contiene herramientas de análisis y monitorización.

## Contratos

- `shared_wallet`: Carpeta que contiene el contrato `SharedWallet` utilizado en el proyecto.
- `shared_wallet_exploit`: Carpeta que contiene el contrato `Exploit` utilizado para realizar ataques al contrato `SharedWallet`.

## Scripts en Python

- `attack_shared_wallet`: Carpeta que contiene el script en Python utilizado para atacar el contrato `SharedWallet`.
- `populate_shared_wallet`: Carpeta que contiene el script en Python utilizado para poblar el contrato `SharedWallet`.

## Herramientas de análisis

- `analysis`: Carpeta que contiene herramientas de análisis de vulnerabilidades en contratos inteligentes.
- `monitor`: Carpeta que contiene herramientas para monitorizar transacciones en la red Ethereum.

## Configuración de Docker

- `DOCKER_NETWORK`: Nombre de la red de Docker utilizada en el proyecto.
- `GANACHE_URL`: URL de Ganache, el entorno de desarrollo local de Ethereum utilizado para el despliegue y pruebas de los contratos.
- `GANACHE_NETWORK_ID`: ID de red de Ganache utilizado en el proyecto.

## Despliegue de contratos

El proyecto cuenta con las siguientes reglas para desplegar los contratos:

- `deploy`: Despliega los contratos `SharedWallet` y `Exploit` en Ganache.
- `deploy-shared-wallet`: Despliega el contrato `SharedWallet` en Ganache.
- `deploy-shared-wallet-exploit`: Despliega el contrato `Exploit` en Ganache, utilizando la dirección del contrato `SharedWallet`.
- `deploy-vulnerabilities-analysis-tool`: Despliega la herramienta de análisis de vulnerabilidades.

## Ejecución de scripts

El proyecto proporciona los siguientes comandos para ejecutar los scripts

### Desplegar el entorno Docker y las herramientas

```sh
make up
```

### Poblar el contrato SharedWallet con datos de ejemplo

```sh
make populate
```

### Atacar el contrato SharedWallet utilizando el script attack_shared_wallet:

```sh
make attack
```

### Análisis de vulnerabilidades

El proyecto incluye comandos para analizar vulnerabilidades en los contratos:

```sh
# Realizar una análisis de vulnerabilidades utilizando la herramienta Mythril con la dirección del contrato
make mythril-scan-vulnerabilities-by-address
# Realizar una análisis de vulnerabilidades utilizando la herramienta Mythril con el fichero
make mythril-scan-vulnerabilities-by-file

# Realizar una análisis de vulnerabilidades utilizando la herramienta Slither
make slither-scan-vulnerabilities
```

### Obtener los logs de la herramienta de monitorización

```sh
make get-monitor-logs
```

### Detener el entorno

Para detener y limpiar el entorno de Docker y las herramientas, se puede utilizar el siguiente comando:

```sh
make down
```