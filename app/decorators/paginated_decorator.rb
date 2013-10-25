class PaginatedDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages, :total_entries, :per_page, :offset
end
