require 'nokogiri'
require 'open-uri'
require 'json'

def create_library_hash
  page = Nokogiri::HTML(open("http://www.publiclibraries.com/kansas.htm"))
  libraries = {}

  page.css("table#libraries tr td").each_slice(5) do |library|
    library_name = library[1].children[0].text
    libraries[library_name] = {
      :city => library[0].children[0].text,
      :address => library[2].children[0].nil? ? "" : library[2].children[0].text,
      :zip_code => library[3].children[0].nil? ? "" : library[3].children[0].text,
      :phone_no => library[4].children[0].nil? ? "" : library[4].children[0].text
    }
  end

  File.open("library.json", 'w') { |file| file.write(libraries.to_json) }
  # libraries
end

puts create_library_hash
