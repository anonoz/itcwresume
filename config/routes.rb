Rails.application.routes.draw do
  root 'homepage#index'

  devise_for :students, controllers: {
    omniauth_callbacks: 'students/omniauth_callbacks'
  }
  devise_for :employers
  devise_for :vetters

  resource :resume, controller: 'resume' do
    get 'open'
  end

  namespace :employers do
    resources :resumes, only: [:index]
    get 'contact_us'
  end

  namespace :vetters do
    resources :resumes, only: [:index, :edit, :update] do
      patch 'approve', on: :member
      patch 'reject', on: :member
    end
    resources :employers
  end

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
end
