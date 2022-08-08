# Facturama SDK Ruby

[NOTA] Este documento esta disponble en [Español]

Library to consume the Web API and Multiissuer API of Facturama.

## Check the Facturama guide here.

[Guide](https://apisandbox.facturama.mx/guias)

## Dependencies

* [rest-client](https://rubygems.org/gems/rest-client)

## How do I install it?


```.rb
gem install facturama
```

Start the development!

### Configuration

If the value of the ```is_development``` variable is ```true```, the library is in sandbox mode.
```.rb
  Facturama::FacturamaApi.new("USUARIO","CONTRASEÑA",is_development)
```
If the value of the  ```is_development ``` variable is ```false```, the library is in sandbox mode.
 ```.rb
  Facturama::FacturamaApi.new("USUARIO","CONTRASEÑA",is_development)
```
## Web API operations

- Create, get, cancel CFDIs; download XMLs and PDFs and send them by email;
- Check profile and current subscription;
- Logo and digital certificates uploading;
- CRUDs for Product, Customer, Branch office and series.

*All operations will be reflected on Facturama's web app.*

Some examples: [here](https://github.com/Facturama/facturama-ruby-sdk/wiki/API-Web)

## Mult-issuer API operations

- Create, get, cancel CFDIs; download XMLs and PDFs;
- CRUD for digital sign certificates ("CSD", "Certificados de los Sellos Digitales").

*These operations will not be reflected on Facturama's web app.*

Some examples: [here](https://github.com/Facturama/facturama-ruby-sdk/wiki/API-Multiemisor)



## I want to contribute!
That is great! Just fork the project in GitHub, create a topic branch, write some code, and add some tests for your new code.

Thanks for helping!


[Español]: ./README.md
