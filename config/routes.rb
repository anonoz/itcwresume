Rails.application.routes.draw do
  root 'homepage#index'

  devise_for :students, controllers: {
    omniauth_callbacks: 'students/omniauth_callbacks'
  }
  devise_for :employers
  devise_for :vetters

  # STUDENT UI
  resource :resume, controller: 'resume' do
    get 'open'
  end

  # EMPLOYERS UI
  get '/resumes' => "employers/resumes#index"
  scope '/resumes' do
    get '/search' => "employers/resumes#search", as: :search
    get '/full-time' => "employers/resumes#full_time", as: :full_time_resumes
    get '/internship' => "employers/resumes#internship", as: :internship_resumes
  end
  get "contact_us" => "employers#contact_us"

  # VETTER UI
  namespace :vetters do
    resources :resumes, only: [:index, :edit, :update] do
      patch 'approve', on: :member
      patch 'reject', on: :member
    end
    resources :employers
  end

  # Misc
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
end
