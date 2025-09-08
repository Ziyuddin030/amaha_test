Rails.application.routes.draw do
  mount Rswag::Api::Engine => "/api-docs"
  mount Rswag::Ui::Engine => "/api-docs"
  namespace :api do
    namespace :v1 do
      post "customers/nearby", to: "customers#nearby"
    end
  end
end
