class Users::RegistrationsController < Devise::RegistrationsController
  
  def new
#    redirect_to signup_path unless Plan::NAMES.include? params[:plan]
#    @plan = Plan.find_by_name(params[:plan])
    @company = Company.find(params[:company])
    super
  end
  
  def create
#    redirect_to signup_path unless Plan::NAMES.include? params[:plan][:name]
    @plan = Plan.find_by_name(session[:plan])    
    
    @company = Company.find(params[:company][:id])
    
    build_resource
    
    if resource.save
      @company.users << resource
      set_flash_message :notice, :signed_up
      sign_in(resource_name, resource)
      UserMailer.registration_confirmation(resource).deliver
      # redirect to credit card page or if free plan -> create subscription and redirect to dashboard
      if @plan.name == "ready"
        @company.plan = @plan
        redirect_to dashboard_url
      else
        redirect_to new_company_subscription_path(@company, :plan => @plan.name)
      end
    else
      clean_up_passwords(resource)
      render_with_scope :new
    end
  end
  
end
