
require_relative "../facturama"
require_relative "sample_api.rb"
require 'json'


module Facturama


    module Samples

        class SampleApiMulti < SampleApi


            def run
                puts "====================================================================="
                puts "              FACTURAMA MULTIEMISOR SDK   #{Facturama::VERSION}"
                puts "====================================================================="


                # Creación de una instacia de la API Multiemisor de Facturama, configurado con los datos del usuario de pruebas
                facturama = create_api_instance


                # Invocaciones a los ejemplos de uso de los servicios de Facturama API
                begin

                    #sample_csds(facturama)              # Servicio de CSD (certificados)

                    sample_cfdis(facturama)              # Servicio de CFDI


                rescue FacturamaException => ex
                    puts "----------- EXCEPCIONES -----------"
                    puts " * " + ex.message

                    if ex.details != nil
                        ex.details.each do |item|
                            puts "#{item[0]}: " + item[1].join(",")
                        end

                    end

                rescue Exception => ex
                    puts "----------- EXCEPCIONES -----------"
                    puts " * " + ex.to_s
                end
            end  # run





            # ---------------------------------------------------------------------------------------------------------------------
            # CONFIGURACION DEL ENTORNO DE LA API
            def create_api_instance
                facturama_user='pruebas'
                facturama_password='pruebas2011'
                is_development = true             # true = Modo de pruebas / sandbox,   false = Modo de Producción (Timbrado real)


                #Creacion de una instancia de FacturamaApiMultiemisor
                Facturama::FacturamaApiMulti.new(facturama_user,facturama_password,is_development)
            end



            # ---------------------------------------------------------------------------------------------------------------------
            # EJEMPLO DEL SERVICIO DE CSDS
            def sample_csds(facturama)
                puts "===== Ejemplo de CSD - Inicio ====="

                sample_csds_list(facturama)         # Listar todos los csd de la cuenta

                sample_csds_load(facturama)         # Cargar un nuevo CSD

                sample_csds_update(facturama)       # Obtiene un CSD mediante el RFC y lo actualiza

                #sample_csds_remove(facturama)       # Elmina el CSD asociado con el RFC

                puts "===== Ejemplo de CSD - Fin ====="
            end

            # Ejemplo de obtener el listado de todos los certifiados cargados
            def sample_csds_list(facturama)
                puts "===== Obtener los CSD cargados - Inicio ====="

                lst_csds = facturama.csds.list       # Se obtiene una lista con todos los csds
                lst_csds_count = lst_csds.count       # Cantidad de csds

                puts "Cantidad de CSDs: " + lst_csds_count.to_s

                puts "===== Obtener los CSD cargados - Fin ====="
            end


            # Carga de un nuevo certificado, para un RFC
            # * La API espera que el certificado y la llave sean enviados en base64. Por lo que las cadenas aqui expuestas,
            #   representan el contenido de los archivos corresponidientes, en dicho formato
            def sample_csds_load(facturama)
                puts "===== Cargar nuevo CSD - Inicio ====="

                csd_model = Facturama::Models::Csd.new({
                    Rfc: "AAA010101AAA",
                    Certificate: "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",
                    PrivateKey: "MIIFDjBABgkqhkiG9w0BBQ0wMzAbBgkqhkiG9w0BBQwwDgQIAgEAAoIBAQACAggAMBQGCCqGSIb3DQMHBAgwggS9AgEAMASCBMh4EHl7aNSCaMDA1VlRoXCZ5UUmqErAbucRBAKNQXH8tz2zJ7hdZaOZx7PEfMiWh5Nh6e8G8kxY+GW4YCSbLxslkhBtfTR6v5JYv3vhgH7XzMCwJPOfX6gxeeCYZ4HTdDNAyBVCjTbJpqbo778ri33o+I4yx7zgMqA3mzVE61re6MPrGXh1YT/K9zZeEdmwvXQfPs9VnioKUhiswoMcJ3kc3FxGLrEAsjQqv/ZVOHPY3NrbcfpQUyprsCKv3rRdxkIRdMPY4eiA720mffzvDqyzeQ8xfwHTE8Xjunja4KXvW/mV7ItTH0vRXHc3HJQ0dNnyawXmbC1FiYbCVdswoYuVQmslvq3QEXUGwP3KYfxQzKatnU7nprkmsipPqPBqDrzqc6NSN/8rxIc5zTAL4bFul+CEKz9VybwdavgewEy7u3fPnKPN+y4HilNgmlbtS7seWpbIgVPA+woG2Ph5hsgREXZCjGKSRuI77/FLcI5CMrZR+FvbnaqG+gXDBTz2lWhK9pmWlVawT2pvfiHOLzYRf2YyuVbJ79D2EgbUKyp3kCQ6fddMzspPhD/pvLQizExeyIxImb/kQXs2mmtDnyFIsj4Hcn5wCcs+SDIj+FJnwRiKB6YfdzjIig/ZMfpgMpl0u69LX649uL318o+Hy3d5t3wxgSkTaJ5McKhWyh9x9vlHZhYyM6HArBNfP9cGF86M3GwAMHAiJQl9UevyKe6rlvAIDlop6l3M02m5hHUXUpPjz4j7inFXZzvSv0tFoSbEqGgno0Pa+0gWHqRwBEGLGEwHVfyEy+Of8g4+0jzo0jNPIcurA5xRh9HSRSAd3kdEhx75eeVL7lBdLjRUkbtRtg7nelSjqAX7tQZK6Awp5C/17W96+f/vtjB+Y+ZgrSUjnQDADnZCnapIrzHgE3ZanhGAtnMMl+o4aLd1+74inG4jht/GJB60raSQfYrDrM3kBs0oyfpbEk5TI8ISzRlRmejv+mqpTogJaAqhnLP7rAli3d4pRhUjbACn/xQSFKxl2OURdmnMlvlbb6pleXviJHRxzPPQ25NVdWvmCYWrDfAZYn8X1sABOdyrth38BfmAVsyyPATYFB+5cXuNIZkPz1swz3859iZWTn5JRfPEAGICu5G6w6nrgOLYM9UqOPmxofzEdiEPafLQ5orMxdSWF6+3mD2Yw/VP+B43B/oYehgfrYjBUJt2D04VU/v8XK1ZUVgX/Co0odcdcszAP+ljQ7UVhW+uxVMd2sEprwepPPjYT3HvdI6RBB94yYBWfkoCSo/jsrrRpw2DVEyvoDp/hOXKyt8Y/8UGLCxJUhhv5fEiezYnlUAmwAGjgZfzfAErx0gkQFBgNKglEA7jz0Dqc2Z92pGVGTyPtXqRsqX3IYX5WsZVUoJim0wI7+LNmKpu147ePC0G4Sf4AGoZyPWVXq2SZSPpN261pIKSoLEDeA8WIKj2U5JG2DMMYokV0bZ1TsabrwHvwsp3muLnaP8L+n2fBplbhAEE2buBXvsATixMGu57ZI5WKFLnHn4KIBrZzALCtGehfFbCsdf1nBR6aAt+BpWhhZki54fZTurgMr6zuC5hAaP4rExW+LCc3upHMW7R9DcHWaZuZIfwnVDImnAQ9UOsz+A=",
                    PrivateKeyPassword:"12345678a"
                   })

                facturama.csds.create(csd_model)
                puts "Se ha cargado un nuevo CSD para el Rfc: #{csd_model.Rfc}"

                puts "===== Cargar nuevo CSD - Fin ====="

            end



            # Ejemplo de eliminacion del un CSD asociado como RFC
            def sample_csds_remove(facturama)
                puts "===== Eliminar CSD asociado con un RFC- Inicio ====="

                facturama.csds.remove("AAA010101AAA")
                puts "Se ha eliminado el CSD asociado al Rfc"

                puts "===== Eliminar CSD asociado con un RFC- Inicio ====="
            end


            # Ejemplo de actualización de CSD asociado con un RFC
            def sample_csds_update(facturama)
                puts "===== Actualiza el CSD asociado con un RFC- Inicio ====="

                csd = facturama.csds.retrieve("AAA010101AAA")

                csd['Certificate'] = "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"
                csd['PrivateKey'] = "MIIFDjBABgkqhkiG9w0BBQ0wMzAbBgkqhkiG9w0BBQwwDgQIAgEAAoIBAQACAggAMBQGCCqGSIb3DQMHBAgwggS9AgEAMASCBMh4EHl7aNSCaMDA1VlRoXCZ5UUmqErAbucRBAKNQXH8tz2zJ7hdZaOZx7PEfMiWh5Nh6e8G8kxY+GW4YCSbLxslkhBtfTR6v5JYv3vhgH7XzMCwJPOfX6gxeeCYZ4HTdDNAyBVCjTbJpqbo778ri33o+I4yx7zgMqA3mzVE61re6MPrGXh1YT/K9zZeEdmwvXQfPs9VnioKUhiswoMcJ3kc3FxGLrEAsjQqv/ZVOHPY3NrbcfpQUyprsCKv3rRdxkIRdMPY4eiA720mffzvDqyzeQ8xfwHTE8Xjunja4KXvW/mV7ItTH0vRXHc3HJQ0dNnyawXmbC1FiYbCVdswoYuVQmslvq3QEXUGwP3KYfxQzKatnU7nprkmsipPqPBqDrzqc6NSN/8rxIc5zTAL4bFul+CEKz9VybwdavgewEy7u3fPnKPN+y4HilNgmlbtS7seWpbIgVPA+woG2Ph5hsgREXZCjGKSRuI77/FLcI5CMrZR+FvbnaqG+gXDBTz2lWhK9pmWlVawT2pvfiHOLzYRf2YyuVbJ79D2EgbUKyp3kCQ6fddMzspPhD/pvLQizExeyIxImb/kQXs2mmtDnyFIsj4Hcn5wCcs+SDIj+FJnwRiKB6YfdzjIig/ZMfpgMpl0u69LX649uL318o+Hy3d5t3wxgSkTaJ5McKhWyh9x9vlHZhYyM6HArBNfP9cGF86M3GwAMHAiJQl9UevyKe6rlvAIDlop6l3M02m5hHUXUpPjz4j7inFXZzvSv0tFoSbEqGgno0Pa+0gWHqRwBEGLGEwHVfyEy+Of8g4+0jzo0jNPIcurA5xRh9HSRSAd3kdEhx75eeVL7lBdLjRUkbtRtg7nelSjqAX7tQZK6Awp5C/17W96+f/vtjB+Y+ZgrSUjnQDADnZCnapIrzHgE3ZanhGAtnMMl+o4aLd1+74inG4jht/GJB60raSQfYrDrM3kBs0oyfpbEk5TI8ISzRlRmejv+mqpTogJaAqhnLP7rAli3d4pRhUjbACn/xQSFKxl2OURdmnMlvlbb6pleXviJHRxzPPQ25NVdWvmCYWrDfAZYn8X1sABOdyrth38BfmAVsyyPATYFB+5cXuNIZkPz1swz3859iZWTn5JRfPEAGICu5G6w6nrgOLYM9UqOPmxofzEdiEPafLQ5orMxdSWF6+3mD2Yw/VP+B43B/oYehgfrYjBUJt2D04VU/v8XK1ZUVgX/Co0odcdcszAP+ljQ7UVhW+uxVMd2sEprwepPPjYT3HvdI6RBB94yYBWfkoCSo/jsrrRpw2DVEyvoDp/hOXKyt8Y/8UGLCxJUhhv5fEiezYnlUAmwAGjgZfzfAErx0gkQFBgNKglEA7jz0Dqc2Z92pGVGTyPtXqRsqX3IYX5WsZVUoJim0wI7+LNmKpu147ePC0G4Sf4AGoZyPWVXq2SZSPpN261pIKSoLEDeA8WIKj2U5JG2DMMYokV0bZ1TsabrwHvwsp3muLnaP8L+n2fBplbhAEE2buBXvsATixMGu57ZI5WKFLnHn4KIBrZzALCtGehfFbCsdf1nBR6aAt+BpWhhZki54fZTurgMr6zuC5hAaP4rExW+LCc3upHMW7R9DcHWaZuZIfwnVDImnAQ9UOsz+A="
                csd['PrivateKeyPassword'] = "12345678a"

                facturama.csds.update(csd, "AAA010101AAA")

                puts "===== Actualiza CSD asociado con un RFC - Inicio ====="
            end



            # ---------------------------------------------------------------------------------------------------------------------
            # EJEMPLO DEL SERVICIO DE CFDI
            def sample_cfdis( facturama )
                puts "===== Ejemplo de CFDI - Inicio ====="

                # Creacion del cfdi en su forma general (sin items / productos) asociados
                cfdi = sample_cfdis_create(facturama)

                cfdi_uuid = cfdi['Complement']['TaxStamp']['Uuid']
                puts "Se creó exitosamente el cfdi con el folio fiscal:  " + cfdi_uuid

                # Descarga de los arvhivos PDF y XML del cfdi recien creado
                file_path = "factura" + cfdi_uuid
                facturama.cfdis.save_pdf( file_path + ".pdf",  cfdi['Id'])
                facturama.cfdis.save_xml( file_path + ".xml",  cfdi['Id'])

                # Envio del cfdi por correo
                if facturama.cfdis.send_by_mail(cfdi['Id'], "chucho@facturama.mx", "Factura del servicio" )
                    puts "Se envió por correo exitosamente el cfdi con el folio fiscal: " + cfdi_uuid
                end

                # Se elmina el cfdi recien creado
                facturama.cfdis.remove(cfdi['Id'])
                puts "Se elminó exitosamente el cfdi con el folio fiscal: " + cfdi_uuid


                # Consulta de cfdi por palabra clave o Rfc
                lst_by_rfc = facturama.cfdis.list_by_rfc("ESO1202108R2")
                lst_by_keyword = facturama.cfdis.list_by_keyword("Software")

                puts "Se obtiene la lista de facturas por RFC: #{lst_by_rfc.length}"
                puts "Se obtiene la lista de facturas por KEYWORD: #{lst_by_keyword.length}"


                puts "===== Ejemplo de CFDI - Fin ====="
            end



            # Ejemplo de creación de un CFDI
            # En la API MULTIMEMISOR Se puede cambiar el campo de "Issuer" y emitir una factura,
            # siempre y cuando previamente cargáramos los Certificados CSD
            # * Nota:
            #   La creación de una factura muy similar a la forma de crearla en API WEB.
            #   Y se diferencía en que aquí se tiene la sección de:
            #   "Issuer": {
            #            "FiscalRegime": "601",
            #            "Rfc": "AAA010101AAA",
            #            "Name": "EXPRESION EN SOFTWARE"
            #   },
            def sample_cfdis_create(facturama)

                 cfdi = {
                    "Serie": "R",
                    "Currency": "MXN",
                    "ExpeditionPlace": "78116",
                    "PaymentConditions": "CREDITO A SIETE DIAS",
                    "Folio": "100",
                    "CfdiType": "I",
                    "PaymentForm": "03",
                    "PaymentMethod": "PUE",


                    "Issuer": {
                        "FiscalRegime": "601",
                        "Rfc": "AAA010101AAA",
                        "Name": "EXPRESION EN SOFTWARE"
                    },


                    "Receiver": {
                        "Rfc": "XAXX010101000",
                        "Name": "RADIAL SOFTWARE SOLUTIONS",
                        "CfdiUse": "P01"
                    },
                    "Items": [
                        {
                            "ProductCode": "10101504",
                            "IdentificationNumber": "EDL",
                            "Description": "Estudios de viabilidad",
                            "Unit": "NO APLICA",
                            "UnitCode": "MTS",
                            "UnitPrice": 50.0,
                            "Quantity": 2.0,
                            "Subtotal": 100.0,
                            "Taxes": [{
                                          "Total": 16.0,
                                          "Name": "IVA",
                                          "Base": 100.0,
                                          "Rate": 0.16,
                                          "IsRetention": false
                                      }],
                            "Total": 116.0
                        },
                        {
                            "ProductCode": "10101504",
                            "IdentificationNumber": "001",
                            "Description": "SERVICIO DE COLOCACION",
                            "Unit": "NO APLICA",
                            "UnitCode": "E49",
                            "UnitPrice": 100.0,
                            "Quantity": 15.0,
                            "Subtotal": 1500.0,
                            "Discount": 0.0,
                            "Taxes": [{
                                          "Total": 240.0,
                                          "Name": "IVA",
                                          "Base": 1500.0,
                                          "Rate": 0.16,
                                          "IsRetention": false
                                      }],
                            "Total": 1740.0
                        }
                    ]
                }


                 # Creación del CFDI mediante la API, para su creación
                 facturama.cfdis.create(cfdi)
            end


            def add_items_to_cfdi(facturama, currency, cfdi)

                        lst_products = facturama.products.list
                        lst_products_size = lst_products.length

                        n_items = (rand( lst_products.length ) % 10) + 1

                        decimals = currency['Decimals'].to_i

                        # Lista de conceptos para el CFDI
                        lst_items = Array.new


                        n_begin = lst_products_size - 1 - n_items

                        for index in n_begin..lst_products_size

                            product = lst_products[index]        # Un producto cualquiera

                            if( product.nil? )
                                break

                            end

                            quantity = rand(5) + 1          # una cantidad aleatoria de elementos de este producto

                            discount = product['Price'] % ( product['Price']) == 0 ? 1 : rand( (product['Price'].to_i ) )
                            subtotal = ( product['Price'] * quantity).round(decimals)    # Redondeo de acuerdo a la moneda



                            item = Facturama::Models::Item.new({
                                                                   ProductCode: product['CodeProdServ'],
                                                                   UnitCode: product['UnitCode'],
                                                                   Unit: product['Unit'],
                                                                   Description: product['Description'],
                                                                   IdentificationNumber: product['IdentificationNumber'],
                                                                   Quantity: quantity,
                                                                   Discount: discount.round(decimals),
                                                                   UnitPrice: product['Price'].round(decimals),
                                                                   Subtotal: subtotal,
                                                                   Taxes: nil

                                                               })


                            base_amount = (subtotal - discount).round(decimals)
                            taxes = product['Taxes'].map { |t|
                                Facturama::Models::Tax.new(
                                    Name: t['Name'],
                                    IsQuota: t['IsQuota'],
                                    IsRetention: t['IsRetention'],
                                    Rate: t['Rate'].to_f.round(decimals),
                                    Base: base_amount,
                                    Total: (base_amount * t['Rate'].to_f).round(decimals)
                                )
                            }

                            retentions_amount = 0
                            transfers_amount = 0
                            if taxes.length > 0
                                item.Taxes = taxes
                                # Calculo del monto total del concepto, tomando en cuenta los impuestos
                                retentions_amount = item.Taxes.select { |tax| tax.IsRetention  }.sum(&:Total)
                                transfers_amount = item.Taxes.select { |tax| ! tax.IsRetention  }.sum(&:Total)

                            end

                            item.Total = (item.Subtotal - item.Discount  + transfers_amount - retentions_amount).round(decimals)

                            lst_items.push(item)

                        end

                        cfdi.Items = lst_items

                    end



        end # class SampleApiWeb
    end

end
