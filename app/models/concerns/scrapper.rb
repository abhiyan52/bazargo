## This module includes classes to scrape the content from the web
# The site https://hamrobazaar.com uses cloudflare protection so we need selenium and headless to mimic a real browser
module Scrapper 
  class ScrapeProduct
    require 'open-uri'
    def self.scrape(url)
      content = get_content(url)
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

    def self.get_protected_content(url)
        retries = 0
        while(retries < 5)
          Headless.ly do
            driver = Selenium::WebDriver.for :firefox
            driver.navigate.to url
            sleep(5 + retries)
            page_source = driver.page_source
            unless page_source.match("cf-browser-verification cf-im-under-attack")
               return driver.page_source 
            end
            retries += 1
          end   
        end
    end
  end
end