
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

                    if ex.details
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
                facturama_user='sdkpruebas'
                facturama_password='pruebas2022'
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
                    Rfc: "EKU9003173C9",
                    Certificate: "MIIFuzCCA6OgAwIBAgIUMzAwMDEwMDAwMDA0MDAwMDI0MzQwDQYJKoZIhvcNAQELBQAwggErMQ8wDQYDVQQDDAZBQyBVQVQxLjAsBgNVBAoMJVNFUlZJQ0lPIERFIEFETUlOSVNUUkFDSU9OIFRSSUJVVEFSSUExGjAYBgNVBAsMEVNBVC1JRVMgQXV0aG9yaXR5MSgwJgYJKoZIhvcNAQkBFhlvc2Nhci5tYXJ0aW5lekBzYXQuZ29iLm14MR0wGwYDVQQJDBQzcmEgY2VycmFkYSBkZSBjYWRpejEOMAwGA1UEEQwFMDYzNzAxCzAJBgNVBAYTAk1YMRkwFwYDVQQIDBBDSVVEQUQgREUgTUVYSUNPMREwDwYDVQQHDAhDT1lPQUNBTjERMA8GA1UELRMIMi41LjQuNDUxJTAjBgkqhkiG9w0BCQITFnJlc3BvbnNhYmxlOiBBQ0RNQS1TQVQwHhcNMTkwNjE3MTk0NDE0WhcNMjMwNjE3MTk0NDE0WjCB4jEnMCUGA1UEAxMeRVNDVUVMQSBLRU1QRVIgVVJHQVRFIFNBIERFIENWMScwJQYDVQQpEx5FU0NVRUxBIEtFTVBFUiBVUkdBVEUgU0EgREUgQ1YxJzAlBgNVBAoTHkVTQ1VFTEEgS0VNUEVSIFVSR0FURSBTQSBERSBDVjElMCMGA1UELRMcRUtVOTAwMzE3M0M5IC8gWElRQjg5MTExNlFFNDEeMBwGA1UEBRMVIC8gWElRQjg5MTExNk1HUk1aUjA1MR4wHAYDVQQLExVFc2N1ZWxhIEtlbXBlciBVcmdhdGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCN0peKpgfOL75iYRv1fqq+oVYsLPVUR/GibYmGKc9InHFy5lYF6OTYjnIIvmkOdRobbGlCUxORX/tLsl8Ya9gm6Yo7hHnODRBIDup3GISFzB/96R9K/MzYQOcscMIoBDARaycnLvy7FlMvO7/rlVnsSARxZRO8Kz8Zkksj2zpeYpjZIya/369+oGqQk1cTRkHo59JvJ4Tfbk/3iIyf4H/Ini9nBe9cYWo0MnKob7DDt/vsdi5tA8mMtA953LapNyCZIDCRQQlUGNgDqY9/8F5mUvVgkcczsIgGdvf9vMQPSf3jjCiKj7j6ucxl1+FwJWmbvgNmiaUR/0q4m2rm78lFAgMBAAGjHTAbMAwGA1UdEwEB/wQCMAAwCwYDVR0PBAQDAgbAMA0GCSqGSIb3DQEBCwUAA4ICAQBcpj1TjT4jiinIujIdAlFzE6kRwYJCnDG08zSp4kSnShjxADGEXH2chehKMV0FY7c4njA5eDGdA/G2OCTPvF5rpeCZP5Dw504RZkYDl2suRz+wa1sNBVpbnBJEK0fQcN3IftBwsgNFdFhUtCyw3lus1SSJbPxjLHS6FcZZ51YSeIfcNXOAuTqdimusaXq15GrSrCOkM6n2jfj2sMJYM2HXaXJ6rGTEgYmhYdwxWtil6RfZB+fGQ/H9I9WLnl4KTZUS6C9+NLHh4FPDhSk19fpS2S/56aqgFoGAkXAYt9Fy5ECaPcULIfJ1DEbsXKyRdCv3JY89+0MNkOdaDnsemS2o5Gl08zI4iYtt3L40gAZ60NPh31kVLnYNsmvfNxYyKp+AeJtDHyW9w7ftM0Hoi+BuRmcAQSKFV3pk8j51la+jrRBrAUv8blbRcQ5BiZUwJzHFEKIwTsRGoRyEx96sNnB03n6GTwjIGz92SmLdNl95r9rkvp+2m4S6q1lPuXaFg7DGBrXWC8iyqeWE2iobdwIIuXPTMVqQb12m1dAkJVRO5NdHnP/MpqOvOgLqoZBNHGyBg4Gqm4sCJHCxA1c8Elfa2RQTCk0tAzllL4vOnI1GHkGJn65xokGsaU4B4D36xh7eWrfj4/pgWHmtoDAYa8wzSwo2GVCZOs+mtEgOQB91/g==",
                    PrivateKey: "MIIFDjBABgkqhkiG9w0BBQ0wMzAbBgkqhkiG9w0BBQwwDgQIAgEAAoIBAQACAggAMBQGCCqGSIb3DQMHBAgwggS8AgEAMASCBMh4EHl7aNSCaMDA1VlRoXCZ5UUmqErAbucRFLOMmsAaFNkyWR0dXIAh0CMjE6NpQIMZhQ0HH/4tHgmwh4kCawGjIwERoG6/IH3mCt7u19J5+m6gUEGOJdEMXj976E5lKCd/EG6t6lCq66GE3rgux/nFmeQZvsjLlzPyhe2j+X81LrGudITTjDdgLI0EdbdV9CUJwWbibzrVxjuAVShRh07XPL/DiEw3Wk2+kdy4cfWmMvh0U55p0RKZopNkWuVVSvr3ai7ZNCwHZWDVqkUDpwDDGdyt0kYQ7qoKanIxv/A9wv6ekq0LQ/yLlOcelkxQeb8Glu4RXe+krRvrASw1eBAQ3mvNKpngwF8vtlyoil41PjHUOKALMJtNpywckRRYOk4703ylWIzTfdBlrZ6VmDBjdC5723G1HAx3R/x+o+08++RNiFaN06Ly5QbZZvjnealDfSKz1VKRHWeXggaW87rl4n0SOOWnvabKs4ZWRXTS0dhWK+KD/yYYQypTslDSXQrmyMkpc1Zcb4p9RTjodXxGCWdsR5i5+Ro/RiJvxWwwaO3YW6eaSavV0ROqANQ+A+GizMlxsVjl6G5Ooh6ORdA7jTNWmK44Icgyz6QFNh+J3NibxVK2GZxsQRi+N3HXeKYtq5SDXARA0BsaJQzYfDotA9LFgmFKg9jVhtcc1V3rtpaJ5sab8tdBTPPyN/XT8fA0GxlIX+hjLd3E9wB7qzNR6PZ84UKDxhCGWrLuIoSzuCbr+TD9UCJprsfTu8kr8Pur4rrxm7Zu1MsJRR9U5Ut+O9FZfw4SqGykyTGGh0v1gDG8esKpTW5MKNk9dRwDNHEmIF6tE6NeXDlzovf8VW6z9JA6AVUkgiFjDvLUY5MgyTqPB9RJNMSAZBzrkZgXyHlmFz2rvPqQGFbAtukjeRNS+nkVayLqfQnqpgthBvsgDUgFn03z0U2Svb094Q5XHMeQ4KM/nMWTEUC+8cybYhwVklJU7FBl9nzs66wkMZpViIrVWwSB2k9R1r/ZQcmeL+LR+WwgCtRs4It1rNVkxXwYHjsFM2Ce46TWhbVMF/h7Ap4lOTS15EHC8RvIBBcR2w1iJ+3pXiMeihArTELVnQsS31X3kxbBp3dGvLvW7PxDlwwdUQOXnMoimUCI/h0uPdSRULPAQHgSp9+TwqI0Uswb7cEiXnN8PySN5Tk109CYJjKqCxtuXu+oOeQV2I/0knQLd2zol+yIzNLj5a/HvyN+kOhIGi6TrFThuiVbbtnTtRM1CzKtFGuw5lYrwskkkvenoSLNY0N85QCU8ugjc3Bw4JZ9jNrDUaJ1Vb5/+1GQx/q/Dbxnl+FK6wMLjXy5JdFDeQyjBEBqndQxrs9cM5xBnl6AYs2Xymydafm2qK0cEDzwOPMpVcKU8sXS/AHvtgsn+rjMzW0wrQblWE0Ht/74GgfCj4diCDtzxQ0ggi6yJD+yhLZtVVqmKS3Gwnj9RxPLNfpgzPP01eYyBBi/W0RWTzcTb8iMxWX52MTU0oX9//4I7CAPXn0ZhpWAAIvUmkfjwfEModH7iwwaNtZFlT2rlzeshbP++UCEtqbwvveDRhmr5sMYkl+duEOca5156fcRy4tQ8Y3moNcKFKzHGMenShEIHz+W5KE=",
                    PrivateKeyPassword:"12345678a"
                   })

                facturama.csds.create(csd_model)
                puts "Se ha cargado un nuevo CSD para el Rfc: #{csd_model.Rfc}"

                puts "===== Cargar nuevo CSD - Fin ====="

            end



            # Ejemplo de eliminacion del un CSD asociado como RFC
            def sample_csds_remove(facturama)
                puts "===== Eliminar CSD asociado con un RFC- Inicio ====="

                facturama.csds.remove("EKU9003173C9")
                puts "Se ha eliminado el CSD asociado al Rfc"

                puts "===== Eliminar CSD asociado con un RFC- Inicio ====="
            end


            # Ejemplo de actualización de CSD asociado con un RFC
            def sample_csds_update(facturama)
                puts "===== Actualiza el CSD asociado con un RFC- Inicio ====="

                csd = facturama.csds.retrieve("EKU9003173C9")

                csd['Certificate'] = "MIIFuzCCA6OgAwIBAgIUMzAwMDEwMDAwMDA0MDAwMDI0MzQwDQYJKoZIhvcNAQELBQAwggErMQ8wDQYDVQQDDAZBQyBVQVQxLjAsBgNVBAoMJVNFUlZJQ0lPIERFIEFETUlOSVNUUkFDSU9OIFRSSUJVVEFSSUExGjAYBgNVBAsMEVNBVC1JRVMgQXV0aG9yaXR5MSgwJgYJKoZIhvcNAQkBFhlvc2Nhci5tYXJ0aW5lekBzYXQuZ29iLm14MR0wGwYDVQQJDBQzcmEgY2VycmFkYSBkZSBjYWRpejEOMAwGA1UEEQwFMDYzNzAxCzAJBgNVBAYTAk1YMRkwFwYDVQQIDBBDSVVEQUQgREUgTUVYSUNPMREwDwYDVQQHDAhDT1lPQUNBTjERMA8GA1UELRMIMi41LjQuNDUxJTAjBgkqhkiG9w0BCQITFnJlc3BvbnNhYmxlOiBBQ0RNQS1TQVQwHhcNMTkwNjE3MTk0NDE0WhcNMjMwNjE3MTk0NDE0WjCB4jEnMCUGA1UEAxMeRVNDVUVMQSBLRU1QRVIgVVJHQVRFIFNBIERFIENWMScwJQYDVQQpEx5FU0NVRUxBIEtFTVBFUiBVUkdBVEUgU0EgREUgQ1YxJzAlBgNVBAoTHkVTQ1VFTEEgS0VNUEVSIFVSR0FURSBTQSBERSBDVjElMCMGA1UELRMcRUtVOTAwMzE3M0M5IC8gWElRQjg5MTExNlFFNDEeMBwGA1UEBRMVIC8gWElRQjg5MTExNk1HUk1aUjA1MR4wHAYDVQQLExVFc2N1ZWxhIEtlbXBlciBVcmdhdGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCN0peKpgfOL75iYRv1fqq+oVYsLPVUR/GibYmGKc9InHFy5lYF6OTYjnIIvmkOdRobbGlCUxORX/tLsl8Ya9gm6Yo7hHnODRBIDup3GISFzB/96R9K/MzYQOcscMIoBDARaycnLvy7FlMvO7/rlVnsSARxZRO8Kz8Zkksj2zpeYpjZIya/369+oGqQk1cTRkHo59JvJ4Tfbk/3iIyf4H/Ini9nBe9cYWo0MnKob7DDt/vsdi5tA8mMtA953LapNyCZIDCRQQlUGNgDqY9/8F5mUvVgkcczsIgGdvf9vMQPSf3jjCiKj7j6ucxl1+FwJWmbvgNmiaUR/0q4m2rm78lFAgMBAAGjHTAbMAwGA1UdEwEB/wQCMAAwCwYDVR0PBAQDAgbAMA0GCSqGSIb3DQEBCwUAA4ICAQBcpj1TjT4jiinIujIdAlFzE6kRwYJCnDG08zSp4kSnShjxADGEXH2chehKMV0FY7c4njA5eDGdA/G2OCTPvF5rpeCZP5Dw504RZkYDl2suRz+wa1sNBVpbnBJEK0fQcN3IftBwsgNFdFhUtCyw3lus1SSJbPxjLHS6FcZZ51YSeIfcNXOAuTqdimusaXq15GrSrCOkM6n2jfj2sMJYM2HXaXJ6rGTEgYmhYdwxWtil6RfZB+fGQ/H9I9WLnl4KTZUS6C9+NLHh4FPDhSk19fpS2S/56aqgFoGAkXAYt9Fy5ECaPcULIfJ1DEbsXKyRdCv3JY89+0MNkOdaDnsemS2o5Gl08zI4iYtt3L40gAZ60NPh31kVLnYNsmvfNxYyKp+AeJtDHyW9w7ftM0Hoi+BuRmcAQSKFV3pk8j51la+jrRBrAUv8blbRcQ5BiZUwJzHFEKIwTsRGoRyEx96sNnB03n6GTwjIGz92SmLdNl95r9rkvp+2m4S6q1lPuXaFg7DGBrXWC8iyqeWE2iobdwIIuXPTMVqQb12m1dAkJVRO5NdHnP/MpqOvOgLqoZBNHGyBg4Gqm4sCJHCxA1c8Elfa2RQTCk0tAzllL4vOnI1GHkGJn65xokGsaU4B4D36xh7eWrfj4/pgWHmtoDAYa8wzSwo2GVCZOs+mtEgOQB91/g=="
                csd['PrivateKey'] = "MIIFDjBABgkqhkiG9w0BBQ0wMzAbBgkqhkiG9w0BBQwwDgQIAgEAAoIBAQACAggAMBQGCCqGSIb3DQMHBAgwggS8AgEAMASCBMh4EHl7aNSCaMDA1VlRoXCZ5UUmqErAbucRFLOMmsAaFNkyWR0dXIAh0CMjE6NpQIMZhQ0HH/4tHgmwh4kCawGjIwERoG6/IH3mCt7u19J5+m6gUEGOJdEMXj976E5lKCd/EG6t6lCq66GE3rgux/nFmeQZvsjLlzPyhe2j+X81LrGudITTjDdgLI0EdbdV9CUJwWbibzrVxjuAVShRh07XPL/DiEw3Wk2+kdy4cfWmMvh0U55p0RKZopNkWuVVSvr3ai7ZNCwHZWDVqkUDpwDDGdyt0kYQ7qoKanIxv/A9wv6ekq0LQ/yLlOcelkxQeb8Glu4RXe+krRvrASw1eBAQ3mvNKpngwF8vtlyoil41PjHUOKALMJtNpywckRRYOk4703ylWIzTfdBlrZ6VmDBjdC5723G1HAx3R/x+o+08++RNiFaN06Ly5QbZZvjnealDfSKz1VKRHWeXggaW87rl4n0SOOWnvabKs4ZWRXTS0dhWK+KD/yYYQypTslDSXQrmyMkpc1Zcb4p9RTjodXxGCWdsR5i5+Ro/RiJvxWwwaO3YW6eaSavV0ROqANQ+A+GizMlxsVjl6G5Ooh6ORdA7jTNWmK44Icgyz6QFNh+J3NibxVK2GZxsQRi+N3HXeKYtq5SDXARA0BsaJQzYfDotA9LFgmFKg9jVhtcc1V3rtpaJ5sab8tdBTPPyN/XT8fA0GxlIX+hjLd3E9wB7qzNR6PZ84UKDxhCGWrLuIoSzuCbr+TD9UCJprsfTu8kr8Pur4rrxm7Zu1MsJRR9U5Ut+O9FZfw4SqGykyTGGh0v1gDG8esKpTW5MKNk9dRwDNHEmIF6tE6NeXDlzovf8VW6z9JA6AVUkgiFjDvLUY5MgyTqPB9RJNMSAZBzrkZgXyHlmFz2rvPqQGFbAtukjeRNS+nkVayLqfQnqpgthBvsgDUgFn03z0U2Svb094Q5XHMeQ4KM/nMWTEUC+8cybYhwVklJU7FBl9nzs66wkMZpViIrVWwSB2k9R1r/ZQcmeL+LR+WwgCtRs4It1rNVkxXwYHjsFM2Ce46TWhbVMF/h7Ap4lOTS15EHC8RvIBBcR2w1iJ+3pXiMeihArTELVnQsS31X3kxbBp3dGvLvW7PxDlwwdUQOXnMoimUCI/h0uPdSRULPAQHgSp9+TwqI0Uswb7cEiXnN8PySN5Tk109CYJjKqCxtuXu+oOeQV2I/0knQLd2zol+yIzNLj5a/HvyN+kOhIGi6TrFThuiVbbtnTtRM1CzKtFGuw5lYrwskkkvenoSLNY0N85QCU8ugjc3Bw4JZ9jNrDUaJ1Vb5/+1GQx/q/Dbxnl+FK6wMLjXy5JdFDeQyjBEBqndQxrs9cM5xBnl6AYs2Xymydafm2qK0cEDzwOPMpVcKU8sXS/AHvtgsn+rjMzW0wrQblWE0Ht/74GgfCj4diCDtzxQ0ggi6yJD+yhLZtVVqmKS3Gwnj9RxPLNfpgzPP01eYyBBi/W0RWTzcTb8iMxWX52MTU0oX9//4I7CAPXn0ZhpWAAIvUmkfjwfEModH7iwwaNtZFlT2rlzeshbP++UCEtqbwvveDRhmr5sMYkl+duEOca5156fcRy4tQ8Y3moNcKFKzHGMenShEIHz+W5KE="
                csd['PrivateKeyPassword'] = "12345678a"

                facturama.csds.update(csd, "EKU9003173C9")

                puts "===== Actualiza CSD asociado con un RFC - Inicio ====="
            end



            # ---------------------------------------------------------------------------------------------------------------------
            # EJEMPLO DEL SERVICIO DE CFDI
            def sample_cfdis( facturama )
                puts "===== Ejemplo de CFDI - Inicio ====="

                # Creacion del cfdi en su forma general (sin items / productos) asociados
                #cfdi = sample_cfdis_create(facturama)
                #cfdi = sample_cfdis_create40(facturama)
                cfdi = sample_cfdis_factura_global(facturama)

                cfdi_uuid = cfdi['Complement']['TaxStamp']['Uuid']
                puts "Se creó exitosamente el cfdi con el folio fiscal:  " + cfdi_uuid

                # Descarga de los arvhivos PDF y XML del cfdi recien creado
                #file_path = "factura" + cfdi_uuid
                #facturama.cfdis.save_pdf( file_path + ".pdf",  cfdi['Id'])
                #facturama.cfdis.save_xml( file_path + ".xml",  cfdi['Id'])

                # Envio del cfdi por correo
                #if facturama.cfdis.send_by_mail(cfdi['Id'], "chucho@facturama.mx", "Factura del servicio" )
                #    puts "Se envió por correo exitosamente el cfdi con el folio fiscal: " + cfdi_uuid
                #end

                # Se elimina el cfdi recien creado
                facturama.cfdis.remove(cfdi['Id'],"02","fb296674-52b3-4824-8d77-669dbc82846e")
                puts "Se elminó exitosamente el cfdi con el folio fiscal: " + cfdi_uuid


                # Consulta de cfdi por palabra clave o Rfc
                #lst_by_rfc = facturama.cfdis.list_by_rfc("ESO1202108R2")
                #lst_by_keyword = facturama.cfdis.list_by_keyword("Software")

                #puts "Se obtiene la lista de facturas por RFC: #{lst_by_rfc.length}"
                #puts "Se obtiene la lista de facturas por KEYWORD: #{lst_by_keyword.length}"


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


            #Ejemplo de CFDI 40
            def sample_cfdis_create40(facturama)

                cfdi = {
                   "Serie": "R",
                   "Currency": "MXN",
                   "ExpeditionPlace": "78140",
                   "PaymentConditions": "CREDITO A SIETE DIAS",
                   "Folio": "100",
                   "CfdiType": "I",
                   "PaymentForm": "03",
                   "PaymentMethod": "PUE",


                   "Issuer": {
                       "FiscalRegime": "601",
                       "Rfc": "EKU9003173C9",
                       "Name": "ESCUELA KEMPER URGATE"
                   },


                   "Receiver": {
                       "Rfc": "URE180429TM6",
                       "Name": "UNIVERSIDAD ROBOTICA ESPAÑOLA",
                       "CfdiUse": "G03",
                       "FiscalRegime": "601",
                       "TaxZipCode": "65000"
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
                           "TaxObject": "02",
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
                           "TaxObject": "02",
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
                facturama.cfdis.create3(cfdi)
            end

            #Ejemplo de CFDI 40 Factura Global
            def sample_cfdis_factura_global(facturama)

                cfdi = {
                   "Serie": "R",
                   "Currency": "MXN",
                   "ExpeditionPlace": "78140",
                   "PaymentConditions": "CREDITO A SIETE DIAS",
                   "Folio": "100",
                   "CfdiType": "I",
                   "PaymentForm": "03",
                   "PaymentMethod": "PUE",
                   "Exportation": "01",
                   "GlobalInformation": 
                   {
                        "Periodicity": "02",
                        "Months": "04",
                        "Year": "2022"
                   },
                    "Issuer": {
                       "FiscalRegime": "601",
                       "Rfc": "EKU9003173C9",
                       "Name": "ESCUELA KEMPER URGATE"
                   },


                   "Receiver": {
                       "Rfc": "XAXX010101000",
                       "Name": "PUBLICO EN GENERAL",
                       "CfdiUse": "S01",
                       "FiscalRegime": "616",
                       "TaxZipCode": "78140"
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
                           "TaxObject": "02",
                           "Taxes": [{
                                         "Total": 16.0,
                                         "Name": "IVA",
                                         "Base": 100.0,
                                         "Rate": 0.16,
                                         "IsRetention": false
                                     }],
                           "Total": 116.0
                       }
                   ]
               }


                # Creación del CFDI mediante la API, para su creación
                facturama.cfdis.create3(cfdi)
           end 

        end # class SampleApiWeb
    end

end
