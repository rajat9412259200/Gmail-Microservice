require 'search_mail.rb'
class MailSearching < ApplicationRecord
  validates :uid, :text, presence: true
   def self.search(params = {})
     searchmail = SearchMail.new(params[:oauth_token],params[:refresh_token],params[:uid])
      if(params[:thread_id].blank? && (params[:field].blank?)==false)
          thread_id = searchmail.search(params[:field],params[:text])
          data = searchmail.thread_data(thread_id)
      elsif(params[:thread_id].blank? && params[:field].blank?)
            thread_id = searchmail.search(nil,params[:text])
            data = searchmail.thread_data(thread_id)
      else
          data = searchmail.thread_data(params[:thread_id])
      end
      data
   end
end

