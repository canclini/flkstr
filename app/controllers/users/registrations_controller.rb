class Users::RegistrationsController < Devise::RegistrationsController
  ssl_required :all

  def new
    company_name = ""
    @company = Company.new
    super
  end
  
  def edit
    @active = :second
    super
  end

  def update
    @active = :second
    super
  end
  
  def create    
    @company = Company.new(params[:user][:company])
    build_resource
    
    if @company.valid? && resource.valid?
      @company.save
      resource.save
      @company.plan = Plan.find_by_name('ready')    
      @company.users << resource

      set_flash_message :notice, :signed_up
      sign_in(resource_name, resource)
      #UserMailer.registration_confirmation(resource).deliver
      redirect_to dashboard_url
        
    else
      clean_up_passwords(resource)
      @company_name = @company.name if @company.name.present?
      render_with_scope :new
    end
  end
  
end
