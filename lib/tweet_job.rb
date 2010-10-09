class TweetJob < Struct.new(:company_id, :update)
  def perform
    company = Company.find(company_id)
    wrapper = TwitterWrapper.new File.join(Rails.root, 'config', 'twitter.yml'), company

    twitter = wrapper.get_twitter
    twitter.update update
  end
end
