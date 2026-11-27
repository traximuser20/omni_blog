Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :posts, param: :slug do
    resources :comments, only: %i[create destroy]
    resources :attachments, only: :destroy
    resource :like, only: %i[create destroy], controller: "post_likes"
    resource :bookmark, only: %i[create destroy], controller: "bookmarks"
  end

  root "posts#index"
  get "blog", to: "posts#index", as: :blog
  get "categories", to: "categories#index", as: :categories
  get "category/:slug", to: "categories#show", as: :category
  get "tags", to: "tags#index", as: :tags
  get "tag/:slug", to: "tags#show", as: :tag
  get "search", to: "search#index", as: :search
  get "about", to: "pages#about", as: :about
  get "contact", to: "pages#contact", as: :contact
  get "bookmarks", to: "bookmarks#index", as: :bookmarks
  get "bookmarks", to: "bookmarks#index", as: :bookmarks_page

  get "sitemap.xml", to: "feeds#sitemap", as: :sitemap, defaults: { format: :xml }
  get "feed.xml", to: "feeds#rss", as: :feed, defaults: { format: :rss }
  get "rss.xml", to: "feeds#rss", defaults: { format: :rss }
  get "up" => "rails/health#show", as: :rails_health_check
end
