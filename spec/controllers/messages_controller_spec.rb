require 'spec_helper'

describe MessagesController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'reply'" do
    it "should be successful" do
      get 'reply'
      response.should be_success
    end
  end

  describe "GET 'sent'" do
    it "should be successful" do
      get 'sent'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end

end
