FactoryGirl.define do
  factory :product

  factory :ar_belt, class: Product do
    name "Abrasive Resistant Belt"

    after :create do |ar_belt|
      create(:product_field, name: 'Width', field_type: 'float',  product: ar_belt)
      create(:product_field, name: 'EP', field_type: 'float',  product: ar_belt)
      create(:product_field, name: 'X or /', field_type: 'string',  product: ar_belt)
      create(:product_field, name: 'ply', field_type: 'float', product: ar_belt)
      create(:product_field, name: 'Top Cover', field_type: 'float',  product: ar_belt)
      create(:product_field, name: 'Bottom Cover', field_type: 'float', product: ar_belt)
      create(:product_field, name: 'Resistance', field_type: 'string', product: ar_belt)
    end

  end


  factory :bolter, class: Product do
    name "Bolter"
    after :create do |b|
      create(:product_field, name: 'Weight', unit: 'kg', field_type: 'string',  product: b)
      create(:product_field, name: 'Year', field_type: 'string',  product: b)
      create(:product_field, name: 'Model', field_type: 'string',  product: b)
    end
  end

  factory :chainsaw, class: Product do
    name "Chainsaw"
    after :create do |cs|
      create(:product_field, name: 'Weight', unit: 'kg', field_type: 'string',  product: cs)
      create(:product_field, name: 'Year', field_type: 'string',  product: cs)
      create(:product_field, name: 'Model', field_type: 'string',  product: cs)
    end
  end
end
