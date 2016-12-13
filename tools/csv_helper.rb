require 'csv'

module Tools
  class CSVHelper
    def self.export(data, columns)
      return if data.empty?
      CSV.generate do |f|
        f << columns
        data.each do |task|
          f << task.values
        end
      end
    end
  end
end
