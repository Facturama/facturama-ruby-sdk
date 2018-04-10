# -*- encoding : utf-8 -*-
#  CFDI de emisión (una factura)


module Facturama

  module CfdiType
      INGRESO = "I"
      EGRESO = "E"
      TRASLADO = "T"
      PAGO = "P"
  end

  module CfdiStatus
      ALL = "All"
      ACTIVE = "Active"
      CANCEL = "Cancel"
  end



  module InvoiceType
      ISSUED = "Issued"
      RECEIVED = "Received"
      PAYROLL = "Payroll"
  end


  module FileFormat
      XML = "Xml"
      PDF = "Pdf"
      HTML = "Html"
  end



  module Models
    class Cfdi < Model
      attr_accessor :Id,    # Solo Response
      :Folio,                # Solo Response
      :CertNumber,          # Solo Response
      :NameId,
      :Date,
      :Serie,
      :PaymentAccountNumber,
      :CurrencyExchangeRate,
      :Currency,
      :ExpeditionPlace,
      :PaymentConditions,
      #:Relations,
      :CfdiType,
      :PaymentForm,
      :PaymentMethod,
      #:Receiver,
      :Items,
      #:Complemento, _jr_* Complemento no se considera para eso
      :Observations,
      :OrderNumber,
      :PaymentTerms,        # Solo Response
      :ExchangeRate,        # Solo Response - puede ser el mismo que  CurrencyExchangeRate
      :Subtotal,            # Solo Response
      :Discount,            # Solo Response
      :Total,               # Solo Response
      #:Issuer,             # Solo Response  - Es una entidad fiscal
      :Discount
      #Taxes                # Solo Response
      #:Complement           # Solo Response
            
      
      validates :Email, :Rfc, :Name,  presence: true      
      has_many_objects :Relations, :CfdiRelation
      has_one_object :Receiver
      has_many_objects :Issuer, :TaxEntity
      #has_many_objects :Items, :Item
      has_many_objects :Taxes, :Tax
      has_one_object :Complement
    end
  end
end
