class LogoJob < Struct.new(:company_id)
  def perform
    Company.find(self.company_id).regenerate_styles!
  end
end