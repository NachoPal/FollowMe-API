module ActiveModelSerializers
  module Adapter
    class JsonRedux < Base

      def initialize(serializer, options = {})
        super
        @include = options[:include]
      end

      def serializable_hash(*)
        model_name = serializer.first.object.class.name.downcase.pluralize
        associations_json_tree(serializer, response = {}, model_name)
      end

      private

      def associations_json_tree(serializer, response, model_name)

        serializer.each_with_index do |record, i|
          response[model_name] = [] if i == 0
          response[model_name] << record.attributes

          if record.associations.present?
            record.associations.each do |association|
              associated_key = association.key

              if @include.include?(associated_key)
                unless response[model_name].last.key?(:associated)
                  response[model_name].last.merge!(associated: {})
                end
                response[model_name].last[:associated].merge!((associations_json_tree(association.serializer, {}, associated_key)))
              end
            end
          else
            break
          end
        end
        response
      end
    end
  end
end

ActiveModel::Serializer.config.adapter = :json_redux