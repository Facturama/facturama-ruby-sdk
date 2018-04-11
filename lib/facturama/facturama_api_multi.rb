
require_relative "models/connection_info.rb"

module Facturama

  require 'logger'
  require 'base64'
  require 'rest-client'
  require 'uri'

  class FacturamaApiMulti

    def initialize(facturama_user, facturama_password, is_development = true)
        @connection_info = Facturama::Models::ConnectionInfo.new(facturama_user, facturama_password, is_development)


        @cfdi_service = Facturama::Services::CfdiMultiService.new(@connection_info)
        @csd_service = Facturama::Services::CsdService.new(@connection_info)

    end


    # CSD
    def csds
        @csd_service
    end

    # CFDI (Facturas)
    def cfdis
        @cfdi_service
    end

    
  end  # class FacturamaApiMulti


end