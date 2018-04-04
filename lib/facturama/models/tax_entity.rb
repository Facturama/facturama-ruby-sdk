# -*- encoding : utf-8 -*-
module Facturama
  module Models
    class TaxEntity < Model
      attr_accessor :FiscalRegime, 
      :ComercialName, 
      :Rfc,
      :TaxName,
      :Email,
      :Phone,
      #:TaxAddress,
      :PasswordSat,
      :UrlLogo              #solo Response
      
      validates :FiscalRegime,  :Rfc, :TaxName, :Email,  presence: true
      has_many_objects :TaxAddress, :Address      #solo Response
      has_many_objects :IssuedIn, :Address        #solo Response
      has_many_objects :Csd, :Csd               #solo Response
    end
  end
end
