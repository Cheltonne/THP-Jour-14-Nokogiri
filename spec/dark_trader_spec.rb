require_relative '../lib/dark_trader.rb'

describe "the method perform" do
    it "should return an array" do
        expect(crypto_scrapper(hash_creation(scrap_names, scrap_values)).class).to eq(Array)
    end
    it "should return an array of hashes" do
        expect(crypto_scrapper(hash_creation(scrap_names, scrap_values))[0].class).to eq(Hash)
    end
end