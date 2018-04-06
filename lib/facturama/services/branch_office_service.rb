require_relative "crud_service"

module Facturama

    module Services
        class BranchOfficeService < CrudService

            def initialize(connection_info )
                super(connection_info, "BranchOffice")
            end

        end # class BranchOfficeService

    end  # module Services

end     # module Facturama
