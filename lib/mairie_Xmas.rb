require 'nokogiri'
require 'open-uri'
require 'mechanize'

page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
townhall_links = page.css("a[class=lientxt]")

townhall_array = []
townhall_links.each{|url_end| townhall_array << "https://www.annuaire-des-mairies.com#{url_end['href'].delete_prefix(".")}"}

# puts townhall_array

townhall_mail_clean = []
townhall_array.each do |url_end|
 page = Nokogiri::HTML(open("#{url_end}"))
 
 townhall_mail_raw = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
 townhall_mail_raw.each { |mail| townhall_mail_clean << mail.text }
end