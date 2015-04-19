task all_specs: :environment  do
  ['rubocop -R', 'rails_best_practices', 'rspec', 'haml-lint'].each do |task|
    puts "RUNNING #{task}"
    sh task
  end
end
