require_relative "./lib/facturama"
require_relative "./lib/samples/sample_api_web"
require_relative "./lib/samples/sample_api_multi"




# Ejemplo de uso de API Web
sample_api_web = Facturama::Samples::SampleApiWeb.new
sample_api_web.run


# Ejemplo de uso de API Multiemisor
#sample_api_multi = Facturama::Samples::SampleApiMulti.new
#sample_api_multi.run






