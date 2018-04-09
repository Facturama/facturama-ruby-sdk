
require_relative "../../facturama/models/exception/facturama_exception"
require_relative "../models/connection_info.rb"

module Facturama

    module Services

        class HttpService

            def initialize(connection_info, uri_resource )
                @connection_info = connection_info
                @uri_resource = uri_resource

                #puts "Mi UriBase: #{@connection_info.uri_base} con uri resource:  #{@uri_resource}"
            end



            def get(args='')
                #puts ""
                #puts "     ----- HttpService:get - Inicio -----"
                #puts "     Resource URL:#{url(args )}"


                res=RestClient::Request.new(
                    :method => :get,
                    :url => url(args),
                    :user => @connection_info.facturama_user,
                    :password => @connection_info.facturama_password ,
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

                #puts "     ----- HttpService:get - Fin -----"
                #puts ""

                JSON[json_out]

            end




            def post(message, args = "")

                #puts ""
                #puts "     ----- HttpService:post - Inicio -----"

                #puts "   POST Resource URL:#{url(args)}"
                json =message.to_json
                #puts "   json: #{json}"

                begin

                    #request
                    res= RestClient::Request.new(
                        :method => :post,
                        :url => url(args),
                        :user => @connection_info.facturama_user,
                        :password => @connection_info.facturama_password,
                        :payload => json,
                        :headers => { :content_type => :json }
                    ).execute

                #exceptions
                rescue Exception => e
                    case e.class.name
                    when "RestClient::BadRequest"
                        json_response = JSON[e.response]
                        fact_exception = FacturamaException.new( json_response['Message'], json_response['ModelState'].map{|k,v| [k.to_s, v]}   )
                        raise( fact_exception  )
                    else
                        raise( FacturamaException.new( e.response ) )
                    end

                end



                #puts "     ----- HttpService:post - Fin -----"
                #puts ""

                #return
                if res.code != 204     # 204 = sin contenido
                    res = JSON[ res]
                end

                res

            end





            def put(message, args = "")

                #puts ""
                #puts "     ----- HttpService:put - Inicio -----"

                #puts "   PUT Resource URL:#{url(args)}"

                json =message.to_json

                #puts "   json: #{json}"

                begin

                    #request
                    res= RestClient::Request.new(
                        :method => :put,
                        :url => url(args),
                        :user => @connection_info.facturama_user,
                        :password => @connection_info.facturama_password ,
                        :payload => json,
                        :headers => {:accept => :json,
                                     :content_type => :json,
                                     :json => json}
                    ).execute

                        #exceptions
                rescue Exception => e
                    raise( FacturamaException.new( e.response ) )
                end



                #puts "     ----- HttpService:put - Fin -----"
                #puts ""

                #return
                if res.code != 204     # 204 = sin contenido
                    res = JSON[ res]
                end

                res

            end




            def delete(args = "")

                #puts ""
                #puts "     ----- HttpService:delete - Inicio -----"

                #puts "     Resource URL:#{url(args )}"

                res=RestClient::Request.new(
                    :method => :delete,
                    :url => url(args),
                    :user => @connection_info.facturama_user,
                    :password => @connection_info.facturama_password ,
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

                #puts "     ----- HttpService:delete - Fin -----"
                #puts ""

                JSON[json_out]

            end




            private

            def url(args = '')

                # puts "   ---- URL:"
                slash = ""
                args = args.to_s

                if args.length > 0
                    slash = (args =~ /^\?/)? "" : "/"
                end

                if(@uri_resource.length > 0)
                    @uri_resource = "/" + @uri_resource;
                end

                @connection_info.uri_base + @uri_resource + slash + args

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
