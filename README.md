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
```cs
product = facturama.Cfdi.create(Facturama::Models::Cfdi.new(
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
            UnitPrice : 50.00m,
            Quantity : 2.00m,
            Subtotal : 100.00m,
            Taxes :[
              {
                  Total : 16.00m,
                  Name : "IVA",
                  Base : 100.00m,
                  Rate : 0.160000m,
                  IsRetention : false
               },

            Total : 116.0m
        }
    ]
 }
))
```

