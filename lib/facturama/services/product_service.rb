require_relative "crud_service"

module Facturama

    module Services
        class ProductService < CrudService

            def initialize( connection_info )
                super(connection_info, "product")
            end

        end # class ProductService

    end  # module Services

end     # module Facturama
