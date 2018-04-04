# -*- encoding : utf-8 -*-
module Facturama
  module Models
    class Image < Model
      attr_accessor :Image,
      :Type
     
      validates :Image,  presence: true      
    end
  end
end
