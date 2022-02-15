class ChambasController < ApplicationController
  # vista index (chambas)
  def index
    @chambas_vec = req_chambas
    @areas = %w[Mexico Web-Developer Programación Issues]
    @filters = req_filters
    @areas_chambas = AreasChamba.all
  end

  # vista chamba
  def chamba
    @chamba = Chamba.find(params[:chamba_id])
    @requerimientos = RequerimientosChamba.where(chamba_id: params[:chamba_id])
  end

  def req_chambas
    # DESIDO HACERLO FUERA EN OTRO METODO PARA DESPUES PRE-PROSESAR LAS PUBS
    Chamba.all
  end

  def req_filters
    %w[Mexico Web-Developer Programación Issues]
    # @var_back = params[:filter_active]
  end
end
