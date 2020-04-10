require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "product url must be valid of format https://hamrobazaar.com/i<number>-<string>.html" do
    product = Product.new
    product.title = "Samsung s11"
    product.price = 10000
    product.url = "https://google.com"
    product.description =  "Brand new"
    product.mobile_number = "1234567890"
    assert_not product.save, "Saved with invalid url"

    product = Product.new
    product.title = "Samsung s11"
    product.price = 20000
    product.url = "https://hamrobazaar.com/i2150478-baby-car-on-sale.html"
    product.description =  "Brand new"
    product.mobile_number = "1234567890"
    assert product.save, "Saved with valid url"
  end

end
