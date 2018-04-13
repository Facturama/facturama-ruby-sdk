Gem::Specification.new do |s|
    s.name        = "facturama"
    s.version     = "0.0.1"
    s.date        = "2018-04-12"
    s.summary     = "Facturama API Web y API Multiemisor"
    s.description = "Funcionalidad básica de creación de Cfdis empleando las APIs Web y Multiemisor"
    s.authors     = ["Facturama"]
    s.email       = "info@facturama.mx"
    s.files = Dir.glob("{bin,lib}/**/*")
    s.homepage    = 'http://rubygems.org/gems/facturama'
    s.license     = 'MIT'
    s.required_ruby_version = ">= 2.2.0"
    s.add_runtime_dependency "rest-client", [">= 2.1.0.rc1"]
end