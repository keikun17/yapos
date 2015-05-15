module ClientsHelper

  def link_to_client(client)
    if client
      h link_to(client.decorate.display_name, client_path(client))
    end
  end

end
