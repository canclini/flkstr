# -*- encoding : utf-8 -*-
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development? or Rails.env.staging?
