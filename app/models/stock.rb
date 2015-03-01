class Stock < ActiveRecord::Base
  attr_accessible :reference,
    :supplier_id,
    :remaining_quantity,
    :initial_quantity,
    :unit,
    :description,
    :remarks,
    :date_acquired,
    :date_used_up

end

# == Schema Information
#
# Table name: stocks
#
#  id                 :integer          not null, primary key
#  remaining_quantity :float(24)
#  reference          :string(255)
#  unit               :string(255)
#  supplier_id        :integer
#  description        :text
#  remarks            :text
#  date_acquired      :datetime
#  date_used_up       :datetime
#  created_at         :datetime
#  updated_at         :datetime
#  initial_quantity   :float(24)
#
