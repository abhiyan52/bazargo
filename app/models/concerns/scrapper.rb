## This module includes classes to scrape the content from the web
# The site https://hamrobazaar.com uses cloudflare protection so we need selenium and headless to mimic a real browser
module Scrapper 
  class ScrapeProduct
    require 'open-uri'

    ## This method take a url and scrapes data from it
      # It creates an instance of Product class which represents the product containing data from scrapped site
    def self.scrape_product(url)
      # Get the content of the url 
      product_document = Nokogiri::HTML(get_content(url))
      title = product_document.css(".title").text
      description =  product_document.css("table[bgcolor='#C6C6D9'][style='margin-top:10px'] tr:last")[2].to_s 
      product_content = product_document.css(".mainbody>tbody>tr:nth-child(2) td[valign='top']>table#lblue").text   
      mobile_number = product_content.match(/Mobile Phone: ([0-9]*)/)[1] rescue nil
      price = product_content.match("Price:Rs\. ([0-9,]*)")[1] rescue nil  
      image_url = product_document.at_css("#outimg img")['src'] rescue nil
      return {
        url: url,
        title: title,
        description: description,
        mobile_number: mobile_number,
        price: price,
        image_url: image_url
      }
    end

    private
    ## This method gets the content from the given url
    def self.get_content(url)
      content = ""
      begin
        open(url) do |f|
          f.each_line {|line| content += line}
        end
      rescue OpenURI::HTTPError => e
         if !e.message.match('503').nil?
          content = get_protected_content(url)  
         else
            raise OpenURI::HTTPError
         end
      end
      content
    end

    ## This method fetches content of cloudflare protected URL's
    def self.get_protected_content(url)
        retries = 0
        while(retries < 5)
          Headless.ly do
            begin
              driver = Selenium::WebDriver.for :firefox
              driver.navigate.to url              
              sleep(3 + retries)
              page_source = driver.page_source
              unless page_source.match("cf-browser-verification cf-im-under-attack")
                return driver.page_source 
              end            
            rescue  StandardError => e
               # Failed to get data                
            end
            retries += 1
          end   
        end
    end
  end
end