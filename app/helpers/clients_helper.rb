module ClientsHelper

  def link_to_client(client)
    if client
      text = if client.abbrev.blank?
        client.name
      else
        client.abbrev
      end
      h link_to(text, client_path(client))
    end
  end

end
