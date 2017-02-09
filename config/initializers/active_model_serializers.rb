module JsonRedux
  class Adapter < ActiveModelSerializers::Adapter::Base
    attr_accessor :options
    def serializable_hash(*)
      response = {}
      data = serializer.object
      keys = []

      data.each_with_index do |model, i|
        model.each_with_index do |record, j|
          if data.size > i + 2
            keys[i] = record.class.name.downcase
            response[keys[i]] = [] if j == 0
            response[keys[i]] << record.attributes

            response = add_associated_records_to(record, data, i, response, keys)
            #binding.pry
          end
        end
      end



      data.last.each do |pinpoint_type|
        pinpoint_type.each do |pinpoint|
          pinpoint_day = pinpoint.day_id
          response['trip'].each do |trip|
            trip.dig(:associated,'day').each do |day|
              if day['id'] == pinpoint_day
                associated = {}
                associated[pinpoint.class.name.downcase] = []
                associated[pinpoint.class.name.downcase] << pinpoint.attributes
                day[:associated].merge!(associated)
              end
            end
          end
        end
      end

      response
    end

    private

    def add_associated_records_to(record, data, i, response, keys)
      keys[i+1] = data[i+1].first.class.name.downcase
      associated_records = data[i+1].where("#{keys[i+1].pluralize}.#{keys[i]}_id = ?", record.attributes['id'])
      associated_hash = {}
      associated_hash[keys[i+1]] = []
      associated_records.each do |associated_record|
        associated_hash[keys[i+1]] << associated_record.attributes.merge(associated: {})
      end
      response[keys[i]].last.merge!(associated: associated_hash)
      response
    end
  end
end

ActiveModelSerializers::Adapter.register(:json_redux, JsonRedux::Adapter)

ActiveModel::Serializer.config.adapter = :json_redux