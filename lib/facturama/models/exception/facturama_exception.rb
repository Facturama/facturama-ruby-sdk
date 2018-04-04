
require_relative 'model_exception'


class FacturamaException < Exception

  def initialize( exception_message, model_exception = nil  )

    @model_exception = model_exception

    super exception_message

  end



end