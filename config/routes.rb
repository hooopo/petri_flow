Wf::Engine.routes.draw do
  resources :workflows
  root to: 'workflows#index'
end
