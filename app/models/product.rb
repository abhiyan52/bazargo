## This model handles all the product
  # The products are scrapped from hamrobazar.com by pasting the link
  # Once scrapped the information is stored in products table
class Product < ApplicationRecord
    
    # ActiveRecord Validation

    # Validate the url field
    validates :url, presence: true, uniqueness: true, format: /https:\/\/hamrobazaar\.com\/i[0-9]{7}-.*\.html/ix.freeze
    # Validate presence of title field
    validates :title, presence: true
    # Validation of Url
    validate :validness_of_url

    private 

    ## This method check the validness of the url
    def validness_of_url
      if url.present? && !url_valid?(url)
        errors.add(:url, "must be a valid url")
      end
    end

    def url_valid?(url)
      product_url = URI.parse(url) rescue false
      product_url.kind_of?(URI::HTTP) || product_url.kind_of?(URI::HTTPS)
    end 
end


