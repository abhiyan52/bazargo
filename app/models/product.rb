## This model handles all the product
  # The products are scrapped from hamrobazar.com by pasting the link
  # Once scrapped the information is stored in products table
class Product < ApplicationRecord
    
    # ActiveRecord Validation

    # Validate the url field
    validates :url, presence: true, uniqueness: true, format: /https:\/\/hamrobazaar\.com\/(m\/)*i[0-9]{7}-.*\.html/ix.freeze
    # Validate presence of title field
    validates :title, presence: true
    # Validation of Url
    validate :validness_of_url


    ## This helper method checks if product is stale or not
    def is_stale?
      refreshed_at.present? ? refreshed_at <= (Time.now - 7.days) : created_at <= (Time.now - 7.days)
    end

    def load_product
      product_info = OpenStruct.new(Scrapper::ScrapeProduct.scrape_product(self.url))
      self.price = product_info.price
      self.description = product_info.description
      self.image_url = product_info.image_url
      self.mobile_number = product_info.mobile_number
      self.title = product_info.title
    end

    ## This method refreshes the product when it is stale
    def refresh
      begin
        self.load_product
        self.refreshed_at = Time.now 
        self.save        
      rescue => exception
         # Failed to refresh 
      end
    end
    
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


