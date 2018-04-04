require_relative "../../../../facturama_gem/lib/facturama/services/crud_service"

module Facturama

    module Services
        class ProductService < CrudService

            def initialize( facturama_user, facturama_password, is_development )
                super(facturama_user, facturama_password, is_development, "product")
            end

        end # class ProductService

    end  # module Services

end     # module Facturama
