CollegeCultureFit::Application.routes.draw do

  root 'welcome#index'

  get '/school_comparison/compare' => 'schools#compare'

  resources :schools

  resources :topics

  get 'about' => 'about#index'

  get 'compare' => 'schools#compare'

  get 'schoolcompare' => 'schools#schoolcompare'

end
