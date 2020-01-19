Wf::Engine.routes.draw do
  resources :workflows do
    resources :transitions
    resources :places
    resources :arcs
  end
  resources :forms
  root to: 'workflows#index'
end
