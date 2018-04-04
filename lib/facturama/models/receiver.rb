# -*- encoding : utf-8 -*-
module Facturama
  module Models
    class Receiver < Model
      attr_accessor :Id,      
      :Rfc,
      :Name,
      :CfdiUse,
      :TaxResidence,      
      :TaxRegistrationNumber      
            
      validates :Rfc,  presence: true
    end
  end
end
