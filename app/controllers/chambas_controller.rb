class ChambasController < ApplicationController
 
  def index
    delete_exp_date()
    @chambas_vec = Chamba.all.where(approve: true)
    @areas = %w[Mexico Web-Developer Programación Issues]
    @filters = req_filters
    @areas_chambas = AreasChamba.all
  end

  def delete_exp_date
    chambas = Chamba.all
    chambas.length.times do |reg|
      if chambas[reg].exp_date.to_s < Time.now.strftime("%F").to_s
        record = Chamba.find(chambas[reg].id)
        record.destroy
        record.save
      end
    end
  end

  # vista chamba
  def chamba
    @chamba = Chamba.find(params[:chamba_id])
    @requerimientos = ''
    variable = Chamba.find(params[:chamba_id]).requirements
    if variable.nil? == false
      @requerimientos = variable.split(",")
    end
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
