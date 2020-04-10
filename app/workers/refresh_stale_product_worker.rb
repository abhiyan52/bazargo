class RefreshStaleProductWorker
  include Sidekiq::Worker
  
  def perform(product_id)
    product = Product.find_by(id: product_id)
    product.refresh
  end
end
