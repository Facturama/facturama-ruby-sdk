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
Creacion de CFDI 3.3
```.rb
Cfdi = facturama.cfdi_service.create(Facturama::Models::Cfdi.new(
 {
    Serie : "R",
    Currency : "MXN",
    ExpeditionPlace : "78116",
    PaymentConditions : "CREDITO A SIETE DIAS",
    CfdiType : CfdiType.Ingreso,
    PaymentForm : "03",
    PaymentMethod : "PUE",
    Receiver :[
      {
         Rfc : "RSS2202108U5",
         Name : "RADIAL SOFTWARE SOLUTIONS",
         CfdiUse : "P01"
      }
    ]
    Items :[
         {
            ProductCode : "10101504",
            IdentificationNumber : "EDL",
            Description : "Estudios de viabilidad",
            Unit : "NO APLICA",
            UnitCode : "MTS",
            UnitPrice : 50.00,
            Quantity : 2.00,
            Subtotal : 100.00,
            Taxes :[
              {
                  Total : 16.00,
                  Name : "IVA",
                  Base : 100.00,
                  Rate : 0.160000,
                  IsRetention : false
               },

            Total : 116.0
        }
    ]
 }
))
```
Cancelación
```.rb
facturama.cfdi_service.delete(Cfdi.Id)
```
## Otras Operaciones
* Consultar Perfil y Suscripción actual,
* Carga de Logo y Certificados Digitales
* CRUD de Productos, Clientes, Sucursales y Series.
