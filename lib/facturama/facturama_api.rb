
require_relative "../../../facturama_gem/lib/facturama/services/product_service"

module Facturama

  require 'logger'
  require 'base64'
  require 'rest-client'
  require 'uri'


  LOG= Logger.new(STDOUT)
  #change to Logger::DEBUG if need trace information
  #due the nature of the information, we recommend to never use a log file when in debug
  LOG.level=Logger::FATAL




  class FacturamaApi

    #API Endpoints
    # URL_DEV='http://apisandbox.facturama.com.mx/'
    # URL_PROD='https://www.api.facturama.com.mx/'


    def initialize(facturama_user, facturama_password, is_development = true)
        @facturama_user = facturama_user
        @facturama_password = facturama_password
        @is_development = is_development

        @client_service = Facturama::Services::ClientService.new(@facturama_user, @facturama_password, @is_development)
        @product_service = Facturama::Services::ProductService.new(@facturama_user, @facturama_password, @is_development)
    end


    # Clientes
    def clients
        @client_service
    end




    # Artículos ( Productos o servicios )
    def products
      @product_service
    end

    
  end  # class FacturamaApi


end