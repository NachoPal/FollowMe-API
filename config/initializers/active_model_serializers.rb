# module JsonRedux
#   class Adapter < ActiveModelSerializers::Adapter::Base
#     attr_accessor :options

module ActiveModelSerializers
  module Adapter
    class JsonRedux < Base
      extend ActiveSupport::Autoload
      autoload :Jsonapi
      autoload :ResourceIdentifier
      autoload :Relationship
      autoload :Link
      autoload :PaginationLinks
      autoload :Meta
      autoload :Error
      autoload :Deserialization


      def initialize(serializer, options = {})
        super
        @include = options[:include]
      end

      def serializable_hash(*)
        key = serializer.first.object.class.name.downcase.pluralize
        path = []
        #binding.pry
        response = laostiaputa(serializer, response = {}, key)
      end


      private

      def laostiaputa(serializer, response, key)

        #binding.pry
        serializer.each_with_index do |record, j|

          # path.reduce do |step|
          #   response.dig(step).last.dig(:associated)
          # end

          #current = response.dig(path)
          response[key] = [] if j == 0
          response[key] << record.attributes

          if record.associations.present? &&
            response[key].last.merge(associated: {})

            record.associations.each do |association|
              associated_key = association.key
              if @include.include?(associated_key)
                response[key].last[:associated] = laostiaputa(association.serializer, {}, associated_key)
              end
            end


            #binding.pry

          else
            break
          end
        end
        #binding.pry
        response
      end
    end
  end
end

ActiveModel::Serializer.config.adapter = :json_redux