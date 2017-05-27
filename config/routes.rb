Rails.application.routes.draw do
  get '/', to: 'application#root'

#non_user routes
  post '/listCats', to: 'non_user#listCats'
  get '/listCats', to: 'non_user#listCats'
  post '/listCatProds', to: 'non_user#listCatProds'

#admin routes
  post '/admin/auth', to: 'admin#auth'

  post '/admin/addCat', to: 'admin#addCat'
  post '/admin/editCat', to: 'admin#editCat'
  post '/admin/deleteCat', to: 'admin#deleteCat'

  post '/admin/addProd', to: 'admin#addProd'
  post '/admin/editProd', to: 'admin#editProd'
  post '/admin/deleteProd', to: 'admin#deleteProd'

  post '/admin/listOrders', to: 'admin#listOrders'
  post '/admin/changeOrderStatus', to: 'admin#orderStatusEdit'

#user routes
  post '/user/register', to: 'user#create'
  post '/user/listOrders', to: 'user#listOrders'
  post '/user/placeOrder', to: 'user#placeOrder'
  post '/user/auth', to: 'user#auth'
end
