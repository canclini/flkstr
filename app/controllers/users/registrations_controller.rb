class Users::RegistrationsController < Devise::RegistrationsController
  
  def new
    redirect_to signup_path unless Plan::NAMES.include? params[:plan]
    @plan = Plan.find_by_name(params[:plan])
    @company = Company.find(params[:company])
    super
  end
  
  def create
    @planname = params[:plan][:name]
    @company = Company.find(params[:company][:id])
    
    build_resource
    
    if resource.save
      @company.users << resource
      set_flash_message :notice, :signed_up
      sign_in(resource_name, resource)
      # redirect to credit card page or if free plan -> dashboard
      if @planname == "ready"
        redirect_to dashboard_url
      else
        redirect_to payment_url(:plan => @planname)
      end
    else
      clean_up_passwords(resource)
      render_with_scope :new
    end
  end
  
end
