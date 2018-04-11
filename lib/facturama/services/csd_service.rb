require_relative "crud_service"

module Facturama

    module Services
        class CsdService < CrudService

            def initialize( connection_info )
                super(connection_info, "api-lite/csds")
            end

        end # class CsdService

    end  # module Services

end     # module Facturama
