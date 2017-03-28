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
    nombre = params[:nombre]
    apellido = params[:apellido]
    usuario = params[:usuario]
    twitter = params[:twitter]

    if id
      output = {:error => "No se puede crear usuario con id"}
      render json: output, status: 400
    else
      @usuario = Usuario.create(nombre: nombre, apellido: apellido, usuario: usuario, twitter: twitter)
      # Llamar a GetById para no mostrar fechas
      @usuario = Usuario.GetById(@usuario.id)
      render json: @usuario
    end

  end

  # Update usuario
  def update

    # Check si ID esta en el contenido. No podemos chequear con params[:id], pues ese está incluido en la URL
    if JSON.parse(request.raw_post).key?("id")
      output = {:error => "id no es modificable"}
      render json: output, status: 400
    else

      # Obtener parametros
      id = params[:id]
      nombre = params[:nombre]
      apellido = params[:apellido]
      usuario = params[:usuario]
      twitter = params[:twitter]

      if @usuario = Usuario.find_by_id(id)
        if @usuario.update(nombre: nombre, apellido: apellido, usuario: usuario, twitter: twitter)
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
