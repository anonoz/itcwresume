Rails.application.routes.draw do
  root 'homepage#index'

  devise_for :students, controllers: {
    omniauth_callbacks: 'students/omniauth_callbacks'
  }
  devise_for :employers
  devise_for :vetters

  # STUDENT UI
  resource :resume, controller: 'students/resume' do
    get 'open'
  end
  resource :contact_info, controller: 'students/contact_info', via: [:patch]

  # EMPLOYERS UI
  get '/resumes' => "employers/resumes#index"
  scope '/resumes' do
    get '/view/:id' => "employers/resumes#show", as: :view_resume
    get '/search' => "employers/resumes#search", as: :search
    get '/inbox' => "employers/resumes#inbox", as: :inbox_resumes
    get '/starred' => "employers/resumes#starred", as: :starred_resumes
    get '/completed' => "employers/resumes#completed", as: :completed_resumes
    get '/ignored' => "employers/resumes#ignored", as: :ignored_resumes
  end
  match "/students/:student_id/progress", to: "employers/progresses#update", via: :put
  get "contact_us" => "employers#contact_us"

  # VETTER UI
  namespace :vetters do
    resources :resumes, only: [:index, :edit, :update] do
      patch 'approve', on: :member
      patch 'reject', on: :member
    end
    resources :companies do
      resources :recruiters
    end
  end

  # Misc
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
end
