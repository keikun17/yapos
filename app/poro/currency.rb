module Currency
  CURRENCY_MAPPING = {'PHP' => 1, 'US$' => 40, 'JPY' => '.5'.to_f}
  LOCAL_CURRENCY = 'PHP'

  def self.all
   CURRENCY_MAPPING.keys
  end
end
