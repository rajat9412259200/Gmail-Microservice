require 'api_version'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   scope module: :v1, constraints: ApiVersion.new('v1',true) do
        resources :mail_searching,:only=>[:show,:index,:create] do
        end
        #get "v1/user/:text", to: "user#search", as: :search
   end
end

