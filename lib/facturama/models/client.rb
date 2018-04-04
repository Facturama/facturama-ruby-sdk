# -*- encoding : utf-8 -*-
module Facturama
  module Models
    class Client < Model
      attr_accessor :Email,
      :EmailOp1,
      :EmailOp2,
      :Rfc,
      :Name,
      :CfdiUse,
      :TaxResidence,
      :NumRegIdTrib
      
      
      has_one_object :Address
      validates :Email, :Rfc, :Name,  presence: true      
    end
  end
end
