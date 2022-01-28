class ChambasController < ApplicationController
  def chambas
    @filters = %w[Mexico Web-Developer Programación Issues]
    @var_back = params[:filter_active]
  end
end
