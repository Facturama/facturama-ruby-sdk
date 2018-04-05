# -*- encoding : utf-8 -*-
module Facturama
  module Models
    class Product < Model
      attr_accessor :Unit, 
      :UnitCode, 
      :IdentificationNumber,
      :Name,
      :Description,
      :Price,
      :CodeProdServ,
      :CuentaPredial,
      :Complement,
      :Id
      
      validates :Unit,  :Name, :Description, :Price,  presence: true
      has_many_objects :Taxes, :ProductTax
    end
  end
end
