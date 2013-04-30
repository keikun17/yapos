module Currency
  CURRENCY_MAPPING = {'PHP' => 1, 'US$' => 40}
  LOCAL_CURRENCY = 'PHP'

  def self.all
   CURRENCY_MAPPING.keys
  end
end
