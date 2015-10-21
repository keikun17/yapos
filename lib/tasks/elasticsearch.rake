require 'elasticsearch/rails/tasks/import'


desc "Reindex Quote and Orders to elasticsearc"
task reindex: :environment do
  puts "Reindexing Quotes"

  Quote.find_each(batch_size: 1000) do |quote|
    quote.reindex
  end

  puts "Reindexing Orders"

  Order.find_each(batch_size: 1000) do |order|
    order.reindex
  end
end
