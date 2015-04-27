module ApplicationHelper

  def link_to_remove_fields(name, f, target = 'this')
    icon = content_tag :span, '',class: 'glyphicon glyphicon-remove'
    anchor_text = content_tag :i, name,  class: 'icon-trash'

    f.hidden_field(:_destroy) + link_to(raw(icon + anchor_text),'javascript:;', onclick: "remove_fields(#{target})", class: 'btn btn-danger btn-sm')
  end

  def link_to_add_fields(name, f, association, target = 'this')
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    anchor_text = content_tag :i, name, class: 'icon-plus'
    link_to(anchor_text, 'javascript:;', onclick: "add_fields(#{target}, \"#{association}\", \"#{escape_javascript(fields)}\")", class: 'btn btn-success')
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

    if object.is_a?(String)
    link_to(text, "##{object}", html_options)
    else
      modal_id = html_options.delete(:modal_id) || ""
    link_to(text, "##{dom_id(object) + modal_id}", html_options)
    end

  end

  def display_quantity(quantity, unit)

    content_tag :span, class: "label label-important" do
      [quantity, unit].join(" ")
    end

  end

end
