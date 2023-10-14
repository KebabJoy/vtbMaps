Rails.application.routes.draw do
  scope module: :departments_context do
    resources :bank_offices, only: %i[index]
  end
end
