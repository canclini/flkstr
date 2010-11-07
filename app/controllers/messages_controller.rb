class MessagesController < ApplicationController
  before_filter :authenticate_user!
   
  def index
    @messages = current_company.received_messages.paginate :per_page => 10, :page => params[:page], :order => 'updated_at DESC'
    @active = :in
  end
  
  def actionbox
    @messages = current_company.received_messages.limit(5)
  end
  
  def sent
    @messages = current_company.sent_messages.paginate :per_page => 10, :page => params[:page], :order => 'created_at DESC'
    @active = :out
  end
  
  def show
    @message = Message.find(params[:id])
    if @message.author == current_company
      @active = :out
    else
      @active = :in
    end
  end
  
  def new
    @message = current_company.sent_messages.build
    @active = :create
  end
  
  def reply
    @original = current_company.received_messages.find_by_message_id(params[:id])
  
    subject = @original.subject.sub(/^(Re: )?/, "Re: ")
    body = @original.body.gsub(/^/, "> ")
    @message = current_company.sent_messages.build(:to => @original.author.name, :subject => subject, :body => body)
    @active = :create
  end  
  
  def create
    params[:message][:to] = params[:message][:to]
    @message = current_company.sent_messages.build(params[:message])
  
    if @message.save
      flash[:notice] = "Message sent."
      redirect_to messages_path()
    else
      @active = :create
      render :action => "new"
    end
  end
  
end
