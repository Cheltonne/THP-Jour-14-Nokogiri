require 'nokogiri'
require 'open-uri'

def get_urls
    page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    townhall_links = page.css("a[class=lientxt]")
    townhall_array = []
    townhall_links.each{ |url_end| townhall_array << "https://www.annuaire-des-mairies.com#{url_end['href'].delete_prefix(".")}" }
    return townhall_array
end

def get_names
    page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    townhall_links = page.css("a[class=lientxt]")
    townhall_name_array = []
    townhall_links.each{ |url_end| townhall_name_array << "#{url_end.text.capitalize.gsub(" ", "-")}" }
    return townhall_name_array
end

def fetch_mail(townhall_array)
    townhall_mail_clean = []
    townhall_array.each do |url_end|
    page = Nokogiri::HTML(open("#{url_end}"))
    townhall_mail_raw = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
    townhall_mail_raw.each { |mail| townhall_mail_clean << mail.text }
    end
    return townhall_mail_clean
end

def create_hash(townhall_name_array, townhall_mail_clean)
    hash = Hash.new
    townhall_name_array.each_with_index do |e, i|
        hash[e] = townhall_mail_clean[i]
    end
    return hash
end

def array_of_hashes(hash)
    mail_hash_array = []
        hash.each {|k,v| mail_hash_array << {k => v}}
    return mail_hash_array
end

def perform
    return array_of_hashes(create_hash(get_names, fetch_mail(get_urls)))
end

puts perform