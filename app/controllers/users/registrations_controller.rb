class Users::RegistrationsController < Devise::RegistrationsController
  
  def new
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
     if $app_state != 'website'
       logger.debug "GAGA"
       set_flash_message :notice, :signed_up
       sign_in(resource_name, resource)
       UserMailer.registration_confirmation(resource).deliver
       redirect_to dashboard_url
      else # application is not yet available
        set_flash_message :notice, 'besten Dank fuer ihr Interesse! Sobald die Beta Phase von flockstreet losgeht werden wir sie informieren!'
#        UserMailer.beta_registration_confirmation(resource).deliver
        redirect_to root_url
      end
        
    else
      clean_up_passwords(resource)
      render_with_scope :new
    end
  end
  
end
