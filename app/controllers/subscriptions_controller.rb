class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!, :needs_company!

  def show
  end

  def new
    redirect_to signup_path unless Plan::NAMES.include? params[:plan]
    @plan = Plan.find_by_name(params[:plan])
    @company = current_company
    @subscription = Subscription.new(:company => @company, :plan => @plan, :ccFirstName => current_user.firstname, :ccLastName => current_user.lastname)
  end
  
  def create  
    @plan = Plan.find_by_name(params[:plan][:name])
    @subscription = Subscription.new(params[:subscription])
    @company = current_company
    @user = current_user    
    cheddar = CheddarGetter.new('marcel@flockstreet.com', 'CGtmbg4e3', 'flockstreet_dev')
    begin
      cheddar_customer = cheddar.create_customer(build_cheddargetterhash(@company, @user, @plan, params[:subscription]))
      @company.plan = @plan
      flash[:notice] = "Das Abo wurde erfasst."
      redirect_to dashboard_url    
    rescue Exception => exc
      logger.error("Cheddar Error for the log file #{exc.message}")
      flash[:error] = "Something went wrong... #{exc.message}"
      render :action => 'new'
    end
  end
  
  def edit
  end

  private
  
  def build_cheddargetterhash(company, user, plan, subscription)
    subscription = {
      :code       => company.id.to_s + "-" + company.permalink,
      :firstName  => user.firstname,
      :lastName   => user.lastname,
      :email      => user.email,
      :company    => company.name,
      :subscription => {
        :planCode     => plan.cheddarcode,
        :ccFirstName  => subscription[:ccFirstName],
        :ccLastName   => subscription[:ccLastName],
        :ccNumber     => subscription[:ccNumber],
        :ccExpiration => "%02d" % subscription[:month].to_i + "/" + subscription[:year],
        :ccZip        => subscription[:ccZip]
      }
    }
  end

end
