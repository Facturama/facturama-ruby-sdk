# -*- encoding : utf-8 -*-
module Facturama
  module Models
    class TaxStamp < Model
      attr_accessor :Uuid,
      :Date,
      :CfdiSign,
      :SatCertNumber,
      :SatSign      
    end
  end
end
