# Facturama SDK
Librería para consumir la API Web de Facturama.
## Dependencias
* [rest-client](https://rubygems.org/gems/rest-client)
* [json](https://rubygems.org/search?utf8=%E2%9C%93&query=json)

#### Configuración  #####
Si el valor de la variable  ```is_development ``` es ```true``` la librería esta en modo sandbox
 ```.rb
  Facturama::FacturamaApi.new("USUARIO","CONTRASEÑA",is_development)
```
Y si el valor de la variable  ```is_development ``` es ```false``` la librería esta en modo producción
 ```.rb
  Facturama::FacturamaApi.new("USUARIO","CONTRASEÑA",is_development)
```
## CFDI 3.3



