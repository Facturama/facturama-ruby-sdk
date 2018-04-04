# -*- encoding : utf-8 -*-
module Facturama
  module Models
    class Serie < Model
      attr_accessor :IdBranchOffice, 
      :Name, 
      :Description
      :Folio
      
      validates :IdBranchOffice,  :Name,  presence: true      
    end
  end
end
