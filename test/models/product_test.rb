# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'product attributes must no be empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test 'product prices must be positive' do
    product = Product.new(
      title: 'My book title',
      description: 'My description',
      image_url: 'zzz.jpg'
    )
    product.price = -1
    assert product.invalid?
    assert_equal ['must be greater or equal to 0.01'], product.errors[:price]
    product.price = 1
    assert product.valid?
  end
end
