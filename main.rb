require_relative "../facturama_gem/lib/facturama"
require 'json'


# ---------------------------------------------------------------------------------------------------------------------
# CONFIGURACION DEL ENTORNO DE LA API
def create_api_instance
  facturama_user='pruebas'
  facturama_password='pruebas2011'
  is_development = true             # true = Modo de pruebas / sandbox,   false = Modo de Producción (Timbrado real)


  #Creacion de una instancia de FacturamaApi
  Facturama::FacturamaApi.new(facturama_user,facturama_password,is_development)
end




# ---------------------------------------------------------------------------------------------------------------------
# EJEMPLO DEL SERVICIO DE CLIENTES
# - Listado  de clientes
# - Agregar cliente
# - Obtener cliente específico y editarlo
def sample_clients(facturama)

  sample_clients_list(facturama)    # Listar todos los clientes

  new_client = sample_clients_create(facturama)  # Agregar cliente
  client_id = new_client['Id']                    # Id del cliente recientemente agregado

  sample_clients_retrieve_and_update(facturama, client_id)

  sample_clients_remove(facturama, client_id)

end



# Obtiene el listado de clientes y muestra la cantidad de los mismos
def sample_clients_list(facturama)
  puts "===== Obtener los clientes - Inicio ====="

  lst_clients = facturama.clients.list      # Se obtiene una lista con todos los clientes
  lst_clients_count = lst_clients.count         # Cantidad inicial de clientes



  puts "Cantidad inicial de clientes: " + lst_clients_count.to_s

  puts "===== Obtener los clientes - Fin ====="
end



# Agrega un cliente
def sample_clients_create(facturama)
  puts "===== Agregar cliente - Inicio ====="

  facturama.clients.create(Facturama::Models::Client.new(
      {   Email: "info@pedroperez.net",
          Rfc: "RODJ899315654",
          CfdiUse: "P01",
          Name: "Pedro Perez Development Environment",

          Address: {Country: "MEXICO",
                    ExteriorNumber: "1230",
                    InteriorNumber: "B",
                    Locality: "San Luis",
                    Municipality: "San Luis Potosí",
                    Neighborhood: "Lomas 4ta",
                    State: "San Luis Potosí",
                    Street: "Cañada de Gomez",
                    ZipCode: "78220"
          }
      }))

  puts "===== Agregar cliente - Fin ====="
end



# Obtiene un cliente específico, lo edita y lo guarda
def sample_clients_retrieve_and_update(facturama, client_id)

  puts "===== Obtener cliente y editarlo - Inicio ====="

  # Se obtiene el cliente con el Id especificado
  specific_client = facturama.clients.retrieve(client_id)


  # Se ha encontrado un cliente con ese Id
  if specific_client != nil then

    puts "Specific Client: "
    puts JSON[specific_client]

    # Edición del campo RFC
    specific_client['Rfc'] = "XAXX010101000"
    specific_client['Email'] = "wm@joseromero.net"
    facturama.clients.update(specific_client, client_id)


    # Se obtiene nuevamente el cliente para confirmar que ha cambiado
    specific_client = facturama.clients.retrieve(client_id)

    if specific_client['Rfc'] == "XAXX010101000" then
        puts "Cliente editado, ahora su RFC es XAXX010101000"
    else
        puts "Error al editar cliente"
    end
  end


  puts "===== Obtener cliente y editarlo - Fin ====="
end



# Elimina un cliente
def sample_clients_remove(facturama, client_id)

  puts "===== Eliminar cliente - Inicio ====="

  specific_client = facturama.clients.remove(client_id)

  puts "Cliente eliminado: "
  puts JSON[specific_client]

  puts "===== Eliminar cliente - Fin ====="

end





# ---------------------------------------------------------------------------------------------------------------------
# EJEMPLO DEL SERVICIO DE PRODUCTOS
def sample_products( facturama )
    #sample_products_list(facturama)                     # Listar todos los productos


    new_product = sample_products_create(facturama)     # Agregar producto
    #product_id = new_product['Id']                      # Id del producto recientemente agregado

    #sample_client_retrieve_and_update(facturama, product_id)

    #sample_client_remove(facturama, product_id)

end



# Obtiene el listado de productos y muestra la cantidad de los mismos
def sample_products_list(facturama)
    puts "===== Obtener los productos - Inicio ====="

    lst_products = facturama.products.list       # Se obtiene una lista con todos los productos
    lst_products_count = lst_products.count       # Cantidad inicial de productos

    puts "Cantidad inicial de productos: " + lst_products_count.to_s

    puts "===== Obtener los productos - Fin ====="
end



# Agrega un cliente
def sample_products_create(facturama)
    puts "===== Agregar producto - Inicio ====="

    unit = facturama.catalog.units("servicio").first                        # La primera unidad que tenga que ver con servicio
    prod = facturama.catalog.products_or_services("desarrollo").first       # Se toma el primer producto o servicio



    product_model = Facturama::Models::Product.new(
        {
            Unit: "Servicio",
            UnitCode: unit['Value'],
            IdentificationNumber: "WEB003",
            Name: "Sitio Web CMS",
            Description: "Desarrollo e implementación de sitio web empleando un CMS",
            Price: 6500.0,
            CodeProdServ: prod['Value'],
            CuentaPredial: "123",

            Taxes: [
                {
                    Name: "IVA",
                    Rate: 0.16,
                    IsRetention: false
                },

                {
                    Name: "ISR",
                    IsRetention: true,
                    Total: 0.1
                },

                {
                    Name: "IVA",
                    IsRetention: true,
                    Total: 0.106667
                }
            ]
        }
    )

    product = facturama.products.create(product_model)

    puts "Se creo exitosamente un producto con el id: " + product['Id']


    facturama.products.delete( product['Id'] )





    puts "===== Agregar producto - Fin ====="
end













puts "============================================================"
puts "                    FACTURAMA SDK   #{Facturama::VERSION}"
puts "============================================================"


# Creación de una instacia de la API Facturama, configurado con los datos del usuario de pruebas
facturama = create_api_instance



# Invocaciones a los ejemplos de uso de los servicios de Facturama API
begin
    #sample_clients(facturama)         # Servicio de cliente

    sample_products(facturama)        # Servicio de productos


rescue FacturamaException => ex
    puts "----------- EXCEPCIONES -----------"
    puts " * " + ex.message

    ex.details.each do |item|
        puts "#{item[0]}: " + item[1].join(",")
    end





rescue Exception => ex
    puts "----------- EXCEPCIONES -----------"
    puts " * " + ex.to_s
    end



#product = facturama.product_service





 
# PRUEBA DE CONETIVIDAD

 #puts Facturama::Configuration::use_ssl

#fact = Facturama::FacturamaApi.new()

#fact.hello()


=begin



branch = Facturama::Models::BranchOffice.new({Name:"La de la esquinita",
Description: "La tienda de la esquina", Address: {Street:"Tormentas 83"} })

if branch.all_objects_valid? then
    puts "La BranchOffice es valida. Le contiene"
    puts branch.to_json
else
    puts "La BranchOffice no es valida"
    puts "Le contiene los errores:"
    puts branch.errors.to_json
end


prod = Facturama::Models::Product.new({
    Unit: "Servicio", UnitCode: "E48", Name: "Formateo de PC", Price: 500,
    Taxes: { Name: "IVA" }
    } )


    client = Facturama::Models::Client.new({Email: "info@joseromero.net", Rfc: "ROAJ850914837",
        Address: {Street:"Tormentas 83"} 
    })
    client.Email = "wm@joseromero.net"

    #client.Address = Facturama::Models::Address.new(Street:"Tormentas 83");

    puts "Cliente:"
    puts client.to_json
    
    

    


    if prod.valid? then
        puts "La vaina es valida"
    else
        puts "La vaina no es valida"
        puts "Le contiene los errores:"
        puts prod.errors.to_json
    end



puts prod.to_json



=end

#gets()

