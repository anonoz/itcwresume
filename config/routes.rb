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

  get '404' => 'errors#not_found'
end
