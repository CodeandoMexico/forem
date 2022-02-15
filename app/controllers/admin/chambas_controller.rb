module Admin
  class ChambasController < Admin::ApplicationController
    layout "admin"

    @chamba_record_save = nil

    def index
      @chambas = Chamba.all
      @chamba_save = @chamba_record_save
      # variable para crear una nueva chamba
      @chamba = Chamba.new
    end

    # //////para crear nueva chamaba

    def create
      @chamba = Chamba.new(chamba_params)
      if @chamba.save
        @chamba_record_save = true
      else
        @chamba_record_save = false
        render admin_path
      end
    end

    # def create
    #   @employee = Employee.new(employee_params)
    #   if @employee.save
    #     redirect_to pages_employees_path
    #   else
    #     render :new
    #   end
    # end

    # //////para editar una chamaba
    def edit
      @chamba = Chamba.find(params[:id_chamba])
    end

    # //////para borrar una chamaba
    def delete
      id_to_delete = params[:id_chamba]

      # modificar esto despues para eliminar en cascada (por medio de los modelos)
      RequerimientosChamba.find(id_to_delete).destroy
      AreasChamba.find(id_to_delete).destroy
      Chamba.find(id_to_delete).destroy
      Area.find(id_to_delete).destroy
    end

    private

    def chamba_params
      params.require(:chamba).permit(:title, :exp_date, :location, :description, :organization, :salary)
    end
  end
end
