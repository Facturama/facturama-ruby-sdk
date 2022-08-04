# -*- encoding : utf-8 -*-
module Facturama
    module Models
      class GlobalInformation < Model
        attr_accessor :Periodicity,      
        :Months,
        :Year

  
              
        validates :Periodicity, :Months, :Year presence: true
      end
    end
  end
  