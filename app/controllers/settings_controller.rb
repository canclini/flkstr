class SettingsController < ApplicationController
  before_filter :authenticate_user!, :twitter_wrapper

  def index
    # twitter stuff
    begin
      @twitter = @wrapper.get_twitter
    rescue
      @twitter = nil
    end
  end

end
