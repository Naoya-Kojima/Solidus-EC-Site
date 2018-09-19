module ProductsHelper
  def product_description(product)
    if Spree::Config[:show_raw_product_description]
      raw(product.description)
    else
      raw(product.description.gsub(/(.*?)\r?\n\r?\n/m, '<p>\1</p>'))
    end
  end
end
