# -*- encoding : utf-8 -*-


#Conectividad
#require 'rest-client'
#require 'json'



module Facturama


    #MODELOS
    require_relative 'facturama/version'
    require_relative 'facturama/models/model'
    require_relative 'facturama/models/product_tax'
    require_relative 'facturama/models/product'
    require_relative 'facturama/models/address'
    require_relative 'facturama/models/client'
    require_relative 'facturama/models/cfdi_relation'
    require_relative 'facturama/models/cfdi_relations'
    require_relative 'facturama/models/cfdi'
    require_relative 'facturama/models/receiver'
    require_relative 'facturama/models/tax'
    require_relative 'facturama/models/item'
    require_relative 'facturama/models/branch_office'
    require_relative 'facturama/models/csd'
    require_relative 'facturama/models/serie'
    require_relative 'facturama/models/image'
    require_relative 'facturama/models/complement'
    require_relative 'facturama/models/tax_stamp'
    require_relative 'facturama/models/tax_entity'



    # SERVICIOS
    require_relative 'facturama/services/http_service'
    require_relative 'facturama/services/crud_service'
    require_relative 'facturama/services/client_service'
    require_relative 'facturama/services/product_service'
    require_relative 'facturama/services/catalog_service'

    require_relative 'facturama/facturama_api'

    

end



