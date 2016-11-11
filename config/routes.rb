Rails.application.routes.draw do
  devise_for :employers
  root 'homepage#index'

  devise_for :students, controllers: {
    omniauth_callbacks: 'students/omniauth_callbacks'
  }

  resource :resume, controller: 'resume'
  resources :resumes
end
