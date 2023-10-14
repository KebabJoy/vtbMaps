Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  scope module: :departments_context do
    resources :bank_offices, only: %i[index]
    resources :atms, only: %i[index]
  end
end
