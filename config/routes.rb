Coc::Application.routes.draw do
  get "welcome/index"

  resources :characters do
    resources :characteristic_sets
  end
end
