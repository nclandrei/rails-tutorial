# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def new_product(image_url)
    Product.new(title: 'My book title',
                description: 'My description',
                image_url: image_url,
                price: 1)
  end

  test 'image url' do
    ok = %w[ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
             http://a.b.c/x/y/z/fred.gif ]
    bad = %w[fred.doc fred.gif/more fred.gif.more]

    ok.each do |image|
      assert new_product(image).valid?, "#{image} shouldn't be invalid"
    end

    bad.each do |image|
      assert new_product(image).valid?, "#{image} shouldn't be valid"
    end
  end

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
