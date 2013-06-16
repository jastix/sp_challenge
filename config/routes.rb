SpChallenge::Application.routes.draw do
  get "offers/new"
  post "offers/show"
  root 'offers#new'
end
