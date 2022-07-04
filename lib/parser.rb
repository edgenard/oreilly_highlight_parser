require "csv"

class Parser
  def self.parse(csv_file_path, directory)
    csv = CSV.open(csv_file_path, headers: true, header_converters: [:downcase, :symbol])
    first_row = csv.first
    title = first_row[:book_title]
    file_name = title.downcase.gsub(/\s+/, " ").gsub(/\s/, "_").gsub(/\W/, "") + ".md"
    File.write("#{directory}/#{file_name}", "test")
  end
end
