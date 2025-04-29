module BooksHelper
  def sort_link(field, title = nil, html_options = {})
    title ||= field.to_s.titleize
    direction = if params[:sort] == field && params[:direction] == 'asc'
                 'desc'
               else
                 'asc'
               end
    
    classes = html_options[:class].to_s.split
    classes += sort_link_classes(field)
    
    link_to books_path(sort: field, direction: direction, category_id: params[:category_id]), 
            class: classes.uniq.join(' ') do
      content = tag.span(title)
      
      icon = if params[:sort] == field
               direction == 'asc' ? 
                 tag.i(class: "bi bi-arrow-down-short") : 
                 tag.i(class: "bi bi-arrow-up-short")
             else
               tag.i(class: "bi bi-arrow-down-up text-muted")
             end
             
      if classes.include?('dropdown-item')
        content + tag.span(icon, class: 'float-end')
      else
        content + tag.span(icon, class: 'ms-1')
      end
    end
  end

  private

  def sort_link_classes(field)
    classes = ['text-decoration-none']
    if params[:sort] == field
      classes << 'active' if params[:sort] == field
      classes << (params[:direction] == 'asc' ? 'text-primary' : 'text-primary')
    else
      classes << 'text-dark'
    end
    classes
  end
end
