Wf::Engine.routes.draw do
  resources :workflows do
    resources :transitions
    resources :places
    resources :arcs
  end
  resources :forms do
    resources :fields
  end
  root to: 'workflows#index'
end
