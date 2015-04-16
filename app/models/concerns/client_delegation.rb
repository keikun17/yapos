module ClientDelegation
  extend ActiveSupport::Concern

  included do
    delegate :name, :to => :client, :allow_nil => true, :prefix => true
    delegate :abbrev, to: :client, allow_nil: true, prefix: true
  end

  # def instance_method
  #   .. things that the instance method does
  # end
  #
  # module ClassMethods
  #   def class_method
  #     things that the clas method does
  #   end
  # end
end
