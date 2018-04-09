# -*- encoding : utf-8 -*-
require 'active_model'

module Facturama
  module Models
    class Model

      include ActiveModel::Validations
      include ActiveModel::Serializers::JSON

      attr_accessor :all_errors

      def initialize(values)
        values.each_pair do |k, v|
          send("#{k}=", v)
        end
        after_initialize
      end

      def after_initialize
      end

      def attributes
        instance_values
      end

      def prepare_data
        prepare_keys.to_json
      end

      def get_instance_values
        instance_values.delete_if do |k, v|
          %w(all_errors errors validation_context).include?(k)
        end
      end


      class << self

        def has_many_objects(association, class_name)
          define_writer(association, class_name)
          define_reader(association)
        end

        def has_one_object(association)
          define_writer(association, association)
          define_reader(association)
        end

        def define_writer(association, class_name)
          class_eval <<-CODE
          def #{association}=(value)
            @#{association} =
            if value.class.name == "Array"
              value.collect do |val|
                #{class_name.to_s.camelize}.new(val)
              end
            else
              #{class_name.to_s.camelize}.new(value)
            end
          end
          CODE
        end

        def define_reader(association)
          attr_reader association
        end

      end



    end
  end
end
