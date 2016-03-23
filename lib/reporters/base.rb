class Reporters::Base
  class << self
    def make_csv(records)
      csv_string = CSV.generate do |csv|
        csv << head
        records.find_each do |record|
          csv << record_to_row(record)
        end
      end
    end

    def record_to_row(record)
      raise NotImplementedError
    end

    def head(record)
      raise NotImplementedError
    end
  end
end
