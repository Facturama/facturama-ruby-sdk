# -*- encoding : utf-8 -*-
module Facturama
    module Models
      class ThirdPartyAccount < Model
        attr_accessor :Rfc,      
        :Name,
        :FiscalRegime,
        :TaxZipCode

        validates :Rfc, :Name, :FiscalRegime, :TaxZipCode presence: true
      end
    end
  end
  