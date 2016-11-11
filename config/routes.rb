Rails.application.routes.draw do
  root 'homepage#index'

  devise_for :students, controllers: {
    omniauth_callbacks: 'students/omniauth_callbacks'
  }
  devise_for :employers

  resource :resume, controller: 'resume'
  resources :resumes
end
