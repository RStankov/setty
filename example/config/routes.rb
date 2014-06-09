Example::Application.routes.draw do
  get :reload, to: 'examples#reload'

  root to: 'examples#index'
end
