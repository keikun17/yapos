module ClientsHelper

  def link_to_client(client)
    h link_to(client.name, client_path(client)) if client
  end

end
