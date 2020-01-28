# frozen_string_literal: true

Wf::Engine.routes.draw do
  resources :workflows do
    resources :transitions
    resources :places
    resources :arcs
    resources :cases
  end

  resources :arcs do
    resources :guards
  end

  resources :forms do
    resources :fields
  end

  resources :workitems do
    resources :workitem_assignments, only: %i[new create destroy]
  end

  root to: "workflows#index"
end
