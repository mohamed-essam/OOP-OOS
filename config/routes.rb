Rails.application.routes.draw do
  get '/', to: 'application#root'

#debug routes

  get '/debug/listCategories', to: 'debug#listCategories'
  get '/debug/listOrders', to: 'debug#listOrders'
  get '/debug/listUsers', to: 'debug#listUsers'
  get '/debug/listProducts', to: 'debug#listProducts'
  get '/debug/listAdmins', to: 'debug#listAdmins'

#non_user routes
  post '/listCats', to: 'non_user#listCats'
  post '/listCatProds', to: 'non_user#listCatProds'
  post '/getUser', to: 'non_user#getUserPublicData'
  post '/getUserRevs', to: 'non_user#getUserReviews'
  post '/getProdRevs', to: 'non_user#getProductReviews'

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

  post '/admin/addPicture', to: 'admin#addPictureToProduct'
  post '/admin/removePicture', to: 'admin#deletePictureFromProduct'

#user routes
  post '/user/register', to: 'user#create'
  post '/user/listOrders', to: 'user#listOrders'
  post '/user/placeOrder', to: 'user#placeOrder'
  post '/user/auth', to: 'user#auth'
  post '/user/addReview', to: 'user#writeReview'
  post '/user/editOrder', to: 'user#editOrder'
  post '/user/deleteOrder', to: 'user#deleteOrder'
  post '/user/removeReview', to: 'user#removeReview'

  get '*unmatched_route', to: 'application#not_found'
end
