# Facturama SDK
[NOTE] This document is also available in [English]
Librería para consumir la API Web de Facturama.

## Dependencias
* [rest-client](https://rubygems.org/gems/rest-client)

## Inicio Rapido

#### Instalación #####

Es recomendable utilizar la [Gema de Facturama](https://rubygems.org/gems/facturama) para instalar la librería. ó puedes hacer fork y modificar a tu conveniencia.
```.rb
gem install facturama
```

#### Configuración  #####
Si el valor de la variable  ```is_development ``` es ```true``` la librería esta en modo sandbox
 ```.rb
  Facturama::FacturamaApi.new("USUARIO","CONTRASEÑA",is_development)
```
Y si el valor de la variable  ```is_development ``` es ```false``` la librería esta en modo producción
 ```.rb
  Facturama::FacturamaApi.new("USUARIO","CONTRASEÑA",is_development)
```

## Operaciones Web API

- Crear, Consultar Cancelar CFDI así como descargar XML, PDF y envio de estos por email.
- Consultar Perfil y Suscripción actual
- Carga de Logo y Certificados Digitales
- CRUD de Productos, Clientes, Sucursales y Series.

Algunos ejemplos: [aquí](https://github.com/Facturama/facturama-ruby-sdk/wiki/API-Web)

*Todas las operaciones son reflejadas en la plataforma web.*

## Operaciones API Multiemisor

- Crear, Consultar, Cancelar descarga de XML
- CRUD de CSD (Certificados de los Sellos Digitales).

Algunos ejemplos: [aquí](https://github.com/Facturama/facturama-ruby-sdk/wiki/API-Multiemisor)

*Las operaciones no se reflejan en la plataforma web.*

[English]: ./README-en.md
