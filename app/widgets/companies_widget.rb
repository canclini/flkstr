widget :companies do
  key "4c7ca9ae692239990554d62ce4da2259bf6da315"
  type "number_and_secondary"
  data do
    {
      :value => Company.count,
      :previous => Company.count(:conditions => "created_at < '#{1.day.ago.to_s(:db)}'")
    }
  end
end
