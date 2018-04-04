require_relative "../../../../facturama_gem/lib/facturama/services/crud_service"

module Facturama

    module Services
        class ClientService < CrudService

            def initialize( facturama_user, facturama_password, is_development )
                super(facturama_user, facturama_password, is_development, "client")
            end




        end # class ClientService

    end  # module Services

end     # module Facturama
