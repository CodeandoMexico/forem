module Admin
  class ChambasController < Admin::ApplicationController
    layout "admin"

    def index
      delete_exp_date()
      @chamba = Chamba.new
      @chambas = Chamba.all
    end

    def update_chamba_from_list
      record_chamba = Chamba.find(params[:chamba_to_edit][:id])
      record_chamba.created_at = params[:chamba_to_edit][:published_at] + " " + params[:chamba_to_edit][:time] + ":00"
      if params[:chamba_to_edit][:approve] == "on"
        record_chamba.approve = true
      elsif params[:chamba_to_edit][:bann] == "on"
        record_chamba.approve = false
      end
      record_chamba.save
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

    def delete
      id_to_delete = params[:id_chamba]
      # modificar esto despues para eliminar en cascada (por medio de los modelos)
      RequerimientosChamba.find(id_to_delete).destroy
      AreasChamba.find(id_to_delete).destroy
      Chamba.find(id_to_delete).destroy
      Area.find(id_to_delete).destroy
    end

    def create_chamba_from_forem
      chamba = Chamba.new(form_create_chamba_params)
      new_chamba = Chamba.create(title: chamba.title, exp_date: chamba.exp_date, location: chamba.location,
                    description: chamba.description, organization: chamba.organization, salary: chamba.salary, stall: chamba.stall, requirements: chamba.requirements)
      if new_chamba.save
        redirect_to "/admin/content_manager/chambas", :notice => 'La chambita fue agregada! 😀'
      else
        redirect_to "/admin/content_manager/chambas", :flash => { :record_save_status => 'La chambita no fue agregada 😔'} 
      end
    end

    def update_chamba
      record_to_update = Chamba.find(params[:chamba][:id])
      record_to_update.title = params[:chamba][:title]
      record_to_update.location = params[:chamba][:location]
      record_to_update.organization = params[:chamba][:organization]
      record_to_update.exp_date = params[:chamba][:exp_date]
      record_to_update.stall = params[:chamba][:stall]
      record_to_update.salary = params[:chamba][:salary]
      record_to_update.description = params[:chamba][:description]
      record_to_update.requirements = params[:chamba][:requirements]

      if record_to_update.save
        redirect_to "/admin/content_manager/chambas", :notice => 'La chambita se actualizo correctamente! 😀'
      else
        redirect_to "/admin/content_manager/chambas", :flash => { :record_save_status => 'La chambita no se actualizo! 😔'} 
      end
    end

    private
    def form_create_chamba_params
      params.require(:chamba).permit(:title, :exp_date, :location, :description, :organization, :salary, :stall,
                                     :requirements)
    end
  end
end
