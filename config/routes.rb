Rails.application.routes.draw do
  # resources :usuario, :controller => "usuarios"
  # se haran las rutas manuales para utilizar solo las requeridas por la API
  # Obtener un usuario
  get 'usuario/:id' => 'usuarios#show'

  # Editar un usuario
  post 'usuario/:id' => 'usuarios#update'

  # Eliminar un usuario
  delete 'usuario/:id' => 'usuarios#destroy'

  # Listar todos los usuarios
  get 'usuario' => 'usuarios#index'

  # Crear un usuario
  put 'usuario' => 'usuarios#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
