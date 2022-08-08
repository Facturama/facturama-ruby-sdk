# -*- encoding : utf-8 -*-
module Facturama
  module Models
    class Item < Model
      attr_accessor :ProductCode, 
      :IdentificationNumber, 
      :Description,
      :Unit,
      :UnitCode,
      :UnitPrice,
      :Quantity,
      :Subtotal,
      :Discount,
      #:Taxes,
      :CuentaPredial,
      :Total,
      :TaxObject,
      :ThirdPartyAccount,
      :Taxes,
      :UnitValue              # solo Response
      #:Complement  _jr_* por el momento, no se consideran los complementos
      
      validates :ProductCode,  :Description, :UnitCode, :UnitPrice, :Quantity, :Subtotal, :Total,   presence: true
      #has_many_objects :Taxes, :Tax
    end
  end
end
