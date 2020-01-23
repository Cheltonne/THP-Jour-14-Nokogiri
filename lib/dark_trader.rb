require 'nokogiri'
require 'open-uri'
require 'rspec'

def scrap_names
    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

    curr_names = page.xpath('/html/body/div/div/div[2]/div[1]/div[2]/div[2]/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
    names = []
    curr_names.each{|currency| names << currency.text}
    return names
end

def scrap_values
    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

    curr_val = page.xpath('/html/body/div/div/div[2]/div[1]/div[2]/div[2]/div[2]/div[3]/div/table/tbody/tr/td[5]/a')
    values = []
    curr_val.each{|value| values << value.text}
    return values
end

def hash_creation(names, values)
    hash = Hash.new
    names.each_with_index do |e, i|
        hash[e] = values[i]
    end
    return hash
end

def array_of_hashes(hash)
    crypto_hash_array = []
    hash.each {|k,v| crypto_hash_array << {k => v.delete("$").to_f}}
    return crypto_hash_array
end

def perform
    return array_of_hashes(hash_creation(scrap_names, scrap_values))
end

puts perform