class QuoteComment < Comment
  # attr_accessible :commentable, :body, :user_id
end

# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer
#  commentable_type :string(255)
#  title            :string(255)
#  body             :text(65535)
#  subject          :string(255)
#  user_id          :integer          not null
#  parent_id        :integer
#  lft              :integer
#  rgt              :integer
#  created_at       :datetime
#  updated_at       :datetime
#
