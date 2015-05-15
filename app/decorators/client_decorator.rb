class ClientDecorator < ApplicationDecorator

  delegate_all

  def display_name
    if client.abbrev.blank?
      client.name
    else
      client.abbrev
    end
  end

end
