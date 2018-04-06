# Facturama SDK
Librería para consumir la API Web de Facturama.
## DEpendencias
* [rest-client](https://rubygems.org/gems/rest-client)
* [json](https://rubygems.org/search?utf8=%E2%9C%93&query=json)

#### Configuración  #####
Si el valor de la variable  ```isDevMode``` es ```true``` la librería esta en modo sandbox
 ```.rb
def create_api_instance
  facturama_user='pruebas'
  facturama_password='pruebas2011'
  is_development = true
  Facturama::FacturamaApi.new(facturama_user,facturama_password,is_development)
end
```
Y si el valor de la variable  ```isDevMode``` es ```false``` la librería esta en modo producción
 ```.rb
def create_api_instance
  facturama_user='pruebas'
  facturama_password='pruebas2011'
  is_development = false
  Facturama::FacturamaApi.new(facturama_user,facturama_password,is_development)
end
```


