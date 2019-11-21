class MessagesController < ApplicationController
  before_action :authenticate_user!, :set_conversation

  def index
    # @conversations = Conversation.all
    @conversations = Conversation.where(sender_id: current_user.id).or(Conversation.where(recipient_id: current_user.id))
    unless @conversations.include?(@conversation)
      redirect_to conversations_path
    else
      @messages = @conversation.messages
      # if @messages.length > 10
      #   @over_ten = true
      #   @messages = @messages[-10..-1]
      # end
      if params[:m]
        @over_ten = false
        @messages = @conversation.messages
      end
      if @messages.last
        if @messages.last.user_id != current_user.id
          @messages.last.read = true
          @messages.last.save
        end
      end
      @is_blank = @messages.blank?
      @message = @conversation.messages.new
      if @conversation.sender_id == current_user.id
        @recipient = User.find(@conversation.recipient_id)
      else
        @recipient = User.find(@conversation.sender_id)
      end
    end
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    # if @message.save
    #   redirect_to conversation_messages_path(@conversation)
    # end

    @message.save
    redirect_to conversation_messages_path(@conversation)
  end

  private
    def set_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end

    def message_params
      params.require(:message).permit(:body, :user_id)
    end
end
