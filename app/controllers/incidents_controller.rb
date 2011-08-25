class IncidentsController < ApplicationController
  def show
    @incident = Incident.find_by_number(params[:id])
    render :layout=>false
  end
end
