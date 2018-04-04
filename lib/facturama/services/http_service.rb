require_relative "../../facturama/models/exception/facturama_exception"

module Facturama

    module Services

        class HttpService

            #API Endpoints
            URL_DEV='http://apisandbox.facturama.com.mx/'
            URL_PROD='https://www.api.facturama.com.mx/'


            def initialize(facturama_user, facturama_password, is_development,  uri_resource )
                @facturama_user = facturama_user
                @facturama_password = facturama_password
                @is_development = is_development
                @uri_resource = uri_resource

                @uri_base = (is_development)? URL_DEV : URL_PROD

                puts "Mi UriBase: #{@uri_base} con uri resource:  #{@uri_resource}"
            end



            def get(args='')
                puts ""
                puts "     ----- HttpService:get - Inicio -----"
                puts "     Resource URL:#{url(args )}"


                res=RestClient::Request.new(
                    :method => :get,
                    :url => url(args),
                    :user => @facturama_user,
                    :password => @facturama_password ,
                    :headers => {:accept => :json,
                                 :content_type => :json,
                                 :user_agent => '',
                    }
                )

                json_out=nil
                begin
                    json_out=res.execute
                        #exceptions
                rescue Exception => e
                    raise( FacturamaException.new( e.response ) )
                end

                puts "     ----- HttpService:get - Fin -----"
                puts ""

                JSON[json_out]

            end




            def post(message, args = "")

                puts ""
                puts "     ----- HttpService:post - Inicio -----"


                LOG.debug("#{resource_name}:")
                puts "   POST Resource URL:#{url(args)}"
                LOG.debug("   POST Resource URL:#{url(args)}")

                json =message.to_json

                LOG.debug "   json: #{json}"
                puts "   json: #{json}"

                begin

                    #request
                    res= RestClient::Request.new(
                        :method => :post,
                        :url => url(args),
                        :user => @facturama_user,
                        :password => @facturama_password ,
                        :payload => json,
                        :headers => {:accept => :json,
                                     :content_type => :json,
                                     :json => json}
                    ).execute

                        #exceptions
                rescue Exception => e
                    raise( FacturamaException.new( e.response ) )
                end



                puts "     ----- HttpService:post - Fin -----"
                puts ""

                #return
                if res.code != 204     # 204 = sin contenido
                    res = JSON[ res]
                end

                res

            end





            def put(message, args = "")

                puts ""
                puts "     ----- HttpService:put - Inicio -----"

                LOG.debug("#{resource_name}:")
                puts "   PUT Resource URL:#{url(args)}"
                LOG.debug("   PUT Resource URL:#{url(args)}")

                json =message.to_json

                LOG.debug "   json: #{json}"
                puts "   json: #{json}"

                begin

                    #request
                    res= RestClient::Request.new(
                        :method => :put,
                        :url => url(args),
                        :user => @facturama_user,
                        :password => @facturama_password ,
                        :payload => json,
                        :headers => {:accept => :json,
                                     :content_type => :json,
                                     :json => json}
                    ).execute

                        #exceptions
                rescue Exception => e
                    raise( FacturamaException.new( e.response ) )
                end



                puts "     ----- HttpService:put - Fin -----"
                puts ""

                #return
                if res.code != 204 then     # 204 = sin contenido
                    res = JSON[ res]
                end

                res

            end




            def delete(args = "")

                puts ""
                puts "     ----- HttpService:delete - Inicio -----"

                LOG.debug("#{resource_name}:")
                puts "     Resource URL:#{url(args )}"
                LOG.debug("      Resource URL:#{url(args)}")


                res=RestClient::Request.new(
                    :method => :delete,
                    :url => url(args),
                    :user => @facturama_user,
                    :password => @facturama_password ,
                    :headers => {:accept => :json,
                                 :content_type => :json,
                                 :user_agent => '',
                    }
                )

                json_out=nil
                begin
                    json_out=res.execute
                        #exceptions
                rescue Exception => e
                    raise( FacturamaException.new( e.response ) )
                end

                puts "     ----- HttpService:delete - Fin -----"
                puts ""

                JSON[json_out]

            end




            private

            def url(args = '')

                # puts "   ---- URL:"
                slash = ( args =~ /^\?/ )? "" : "/"

                args = args.to_s

                @uri_base + @uri_resource + slash + args

            end

            def resource_name
                self.class.name.to_s.downcase
            end

            def is_filter_string?(args)
                is_filter = false
                if args =~ /^\?/
                    is_filter = true
                end
                is_filter
            end

        end # class HttpService

    end  # module Services

end     # module Facturama
