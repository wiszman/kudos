Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  devise_for :user

  post "home/give_kudo" => 'home#give_kudo', :as => 'give_kudo'

end
