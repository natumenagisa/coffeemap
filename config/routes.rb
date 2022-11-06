Rails.application.routes.draw do
  namespace :public do
    get 'genres/show'
  end
  #ユーザー用
  devise_for :customers, controllers: {
    sessions:      'public/sessions',
    passwords:     'public/passwords',
    registrations: 'public/registrations'
  }

  devise_scope :customer do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  root 'public/homes#top'

  scope module: :public do
    resource :customers, only: [:show] do
      collection do
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    get 'customers/info/edit' => 'customers#edit', as: 'edit_info'
    patch 'customers/info' => 'customers#update', as: 'update_info'

    resources :reviews, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :comments, only: [:new, :create, :show, :edit, :update, :destroy]
    resources :genres, only: [:show]
  end




  #管理者用
  devise_for :admins, controllers: {
    sessions:      'admin/sessions',
    passwords:     'admin/passwords',
    registrations: 'admin/registrations'
  }

  namespace :admin do
    root 'homes#top'
    resources :homes, only: [:top]
    resources :reviews, only: [:destroy]
    resources :comments, only: [:destroy]
    resources :genres, only: [:index, :create, :edit, :show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end
end
