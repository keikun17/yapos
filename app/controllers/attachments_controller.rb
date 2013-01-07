class AttachmentsController < ApplicationController

  def show
    @attachment = Attachment.find(params[:id])
    path_to_file = File.join(Rails.root, @attachment.document_url)
    send_file(path_to_file)
  end

end
