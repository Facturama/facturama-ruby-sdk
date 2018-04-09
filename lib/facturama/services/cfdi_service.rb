require_relative "crud_service"
require 'base64'

module Facturama

    module Services
        class CfdiService < CrudService

            def initialize( connection_info )
                super(connection_info, "")
            end



            def create(model)
                return post(model, "2/cfdis")
            end


            def remove(id)

                if !id.nil? && id != ""
                    delete("cfdi/" + id  + "?type=issued")
                else
                    raise( FacturamaException("El Id del cfdi a eliminar es obligatorio") )
                end
            end


            def retrive(id, type = nil)

                if type.nil?
                    str_type = "Issued"
                else
                    str_type = type
                end

                get("cfdi/" + id + "?type=#{str_type}")
            end





            # Obtiene un archivo referente a un CFDI del tipo "Issued"
            # @param id Identificador del CFDI
            # @param format Formato deseado ( pdf | html | xml )
            # @param type Tipo de comprobante ( payroll | received | issued )
            # @return Archivo en cuestion
            def get_file(id, format, type)
                resource = "cfdi/" +  format + "/" + type + "/"  + id
                get(resource)
            end


            # Decodifica y guarda un archivo base64 en una ruta
            def save_file(file_path, file_content_base64)
                file_content_decoded = Base64.decode64(file_content_base64)
                File.open(file_path, "wb") do |f|
                    f.write(file_content_decoded)
                end
            end


            def save_pdf(file_path, id, type = Facturama::InvoiceType::ISSUED)
                file_content = get_file(id, Facturama::FileFormat::PDF, type)
                save_file(file_path, file_content['Content'])
            end

            def save_xml(file_path, id, type = Facturama::InvoiceType::ISSUED)
                file_content = get_file(id, Facturama::FileFormat::XML, type)
                save_file(file_path, file_content['Content'])
            end






        end # class CfdiService

    end  # module Services

end     # module Facturama
