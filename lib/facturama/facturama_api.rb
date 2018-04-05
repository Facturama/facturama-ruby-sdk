
require_relative "models/connection_info.rb"

module Facturama

  require 'logger'
  require 'base64'
  require 'rest-client'
  require 'uri'

  class FacturamaApi

    def initialize(facturama_user, facturama_password, is_development = true)

        @connection_info = Facturama::Models::ConnectionInfo.new(facturama_user, facturama_password, is_development)

        @client_service = Facturama::Services::ClientService.new(@connection_info)
        @product_service = Facturama::Services::ProductService.new(@connection_info)
        @catalog_service = Facturama::Services::CatalogService.new(@connection_info)
        @branch_office_service = Facturama::Services::ProductService.new(@connection_info)
        @cfdi_service = Facturama::Services::ProductService.new(@connection_info)

    end


    # Clientes
    def clients
        @client_service
    end

    # Artículos ( Productos o servicios para los conceptos )
    def products
      @product_service
    end

    # Catálogo
    def catalog
        @catalog_service
    end

    # Lugares de expedición (Sucursales)
    def branch_office_service
        @branch_office_service
    end

    # CFDI (Facturas)
    def cfdi_service
        @cfdi_service
    end

    
  end  # class FacturamaApi


end