require 'spec_helper'

describe TourController do

  describe "GET 'profile'" do
    it "should be successful" do
      get 'profile'
      response.should be_success
    end
  end

  describe "GET 'request'" do
    it "should be successful" do
      get 'request'
      response.should be_success
    end
  end

  describe "GET 'tags'" do
    it "should be successful" do
      get 'tags'
      response.should be_success
    end
  end

  describe "GET 'leads'" do
    it "should be successful" do
      get 'leads'
      response.should be_success
    end
  end

  describe "GET 'notifications'" do
    it "should be successful" do
      get 'notifications'
      response.should be_success
    end
  end

  describe "GET 'messages'" do
    it "should be successful" do
      get 'messages'
      response.should be_success
    end
  end

  describe "GET 'network'" do
    it "should be successful" do
      get 'network'
      response.should be_success
    end
  end

  describe "GET 'updates'" do
    it "should be successful" do
      get 'updates'
      response.should be_success
    end
  end

end
