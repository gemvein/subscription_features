Rails.application.routes.draw do

  
  
  
  mount SubscriptionFeatures::Engine => '/subscription_features', :as => 'SubscriptionFeatures'
  mount SubscriptionFeatures::Engine => "/subscription_features"
end
