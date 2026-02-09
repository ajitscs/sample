# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :walmart_orders, only: [:index, :show]
      post "walmart/webhooks", to: "walmart_webhooks#create"
    end
  end
end
