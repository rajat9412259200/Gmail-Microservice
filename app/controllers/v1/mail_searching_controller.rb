module V1
  class MailSearchingController < ApplicationController
      before_action :mail_params, only: [:create]
    def create
           mail = MailSearching.search(mail_params)
           hash={uid: mail_params[:uid], field: mail_params[:field], thread_id: mail[1], text: mail_params[:text], data: mail[0]}
           store = MailSearching.new(hash)
           if store.save
             render json: store, status: 201
          else
              render json: { errors:store.errors }, status: 422
          end
         end
         def index
           mail = MailSearching.all
           render json: mail, status: 200
         end
         def show
         end
         #def search
         #end
       private
       def mail_params
         params.permit(:uid, :oauth_token, :refresh_token, :text, :field, :thread_id => [])
       end
  end
end

