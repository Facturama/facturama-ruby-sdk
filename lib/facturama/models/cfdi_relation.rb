# -*- encoding : utf-8 -*-
module Facturama
  module Models
    class CfdiRelation < Model
      attr_accessor :Uuid      
     
      validates :Uuid,  presence: true      
    end
  end
end
