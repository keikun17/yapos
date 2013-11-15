class Stock < ActiveRecord::Base
end

# == Schema Information
#
# Table name: stocks
#
#  id            :integer          not null, primary key
#  quantity      :float
#  reference     :string(255)
#  unit          :string(255)
#  supplier_id   :integer
#  description   :text
#  remarks       :text
#  date_acquired :datetime
#  date_used_up  :datetime
#  created_at    :datetime
#  updated_at    :datetime
#

