# -*- encoding : utf-8 -*-
module Facturama
    module Models
        class ConnectionInfo

            #API Endpoints
            URL_DEV='http://apisandbox.facturama.com.mx'
            URL_PROD='https://www.api.facturama.com.mx'

            def initialize(facturama_user, facturama_password, is_development = true)
                @facturama_user = facturama_user
                @facturama_password = facturama_password
                @is_development = is_development

                @uri_base = (is_development)? URL_DEV : URL_PROD
            end

            def uri_base
                @uri_base
            end

            def facturama_user
                @facturama_user
            end

            def facturama_password
                @facturama_password
            end

            def is_development
                @is_development
            end

        end
    end
end
