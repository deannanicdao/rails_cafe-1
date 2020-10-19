Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'admin/menu', to: 'admin#menu'

  get '/order/:id', to: 'cafe#order', as: 'order'

  root to: 'cafe#index'
end
