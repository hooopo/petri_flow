Wf::Engine.routes.draw do
  resources :workflows do
    resources :transitions
    resources :places
  end

  root to: 'workflows#index'
end
