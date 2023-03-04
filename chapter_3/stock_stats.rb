require_relative "csv_reader"

reader = CsvReader.new

ARGV.each do |file|
  $stderr.puts "Processing #{file}"
  reader.read_in_csv_data(file)
end

puts "Total value = #{reader.total_value_in_stock}"
