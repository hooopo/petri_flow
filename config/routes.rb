Wf::Engine.routes.draw do
  resources :workflows do
    resources :transitions
    resources :places
    resources :arcs
  end

  root to: 'workflows#index'
end
