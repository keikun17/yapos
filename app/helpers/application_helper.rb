module ApplicationHelper

  def link_to_remove_fields(name, f, target = 'this')
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(#{target})", class: 'btn btn-small btn-danger')
  end

  def link_to_add_fields(name, f, association, target = 'this')
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(#{target}, \"#{association}\", \"#{escape_javascript(fields)}\")", class: 'btn btn-small btn-success')
  end

  def link_to_badge(text, path, options = {})
    text = content_tag(:span, text)
    counter = content_tag(:span, options.delete(:count), class: 'badge badge-important') 
    text.safe_concat(' ').safe_concat( counter)
    link_to(text, path, options)
  end

  # The html_options(:modal_id) is used to refer to succeeding modal views
  # for an object that already has a modal
  def link_to_modal(text, object, html_options = {})
    html_options[:class] ||= 'btn'
    html_options[:role] ||= 'button'
    html_options[:data] ||= {toggle: 'modal'}
    modal_id = html_options.delete(:modal_id) || ""

    link_to(text, "##{dom_id(object) + modal_id}", html_options)
  end

end
