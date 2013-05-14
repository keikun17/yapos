Yapos::SETTINGS = YAML.load_file("#{Rails.root}/config/application_settings.yml")[Rails.env].symbolize_keys
