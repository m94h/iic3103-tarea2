class UsuariosController < ApplicationController

  # Obtener coleccion de usuarios
  def index
    @usuarios = Usuario.GetAll
    output = {:usuarios => @usuarios, :total => @usuarios.size}
    render json: output
  end

  # Obtener un usuario en base a la id
  def show
    # Find by id para no levantar exception si no lo encuentra
    if @usuario = Usuario.GetById(params[:id])
      render json: @usuario
    else
      output = {:error => "Usuario no encontrado"}
      render json: output, status: 404
    end
  end

  # Crear usuario
  def create

    id = params[:id]

    if id
      output = {:error => "No se puede crear usuario con id"}
      render json: output, status: 400
    else
      if @usuario = Usuario.create(request.request_parameters)
        # Llamar a GetById para no mostrar fechas
        @usuario = Usuario.GetById(@usuario.id)
        render json: @usuario, status: 201
      else
        output = {:error => "La creación ha fallado"}
        render json: output, status: 500
      end
    end

  end

  # Update usuario
  def update

    # Check si ID esta en el contenido. No podemos chequear con params[:id], pues ese está incluido en la URL
    if request.request_parameters.key?("id")
      output = {:error => "id no es modificable"}
      render json: output, status: 400
    else

      # Obtener ID
      id = params[:id]

      if @usuario = Usuario.find_by_id(id)
        if @usuario.update(request.request_parameters)
          # Llamar a GetById para no mostrar fechas
          @usuario = Usuario.GetById(id)
          render json: @usuario
        else
          output = {:error => "La modificación ha fallado"}
          render json: output, status: 500
        end
      else
        output = {:error => "Usuario no encontrado"}
        render json: output, status: 404
      end
    end

  end

  # Obtener un usuario en base a la id
  def destroy
    # Find by id para no levantar exception si no lo encuentra
    if @usuario = Usuario.find_by_id(params[:id])
      @usuario.destroy
      render status: 204
    else
      output = {:error => "Usuario no encontrado"}
      render json: output, status: 404
    end
  end

end
