class NewissuealertsController < ApplicationController
  unloadable
  before_filter :find_project_by_project_id
  before_filter :authorize
  before_filter :find_alert, only: %w(edit update destroy)

  def index
    @alerts = Newissuealert.where(project_id: @project.id).all
    render 'projects/settings/_newissuealerts'
  end

  def new
    @newissuealert = Newissuealert.new
  end

  def create
    @newissuealert = Newissuealert.new params[:newissuealert]
    @newissuealert.project_id = @project.id
    if @newissuealert.save
      redirect_to settings_project_path(@project, :tab => 'newissuealerts'), notice: l(:newissuealerts_creation_success)
    else
      flash.now[:error] = l(:newissuealerts_creation_failed)
      render 'new'
    end
  end

  def edit
    @newissuealert = Newissuealert.find(params[:id])
  end

  def update
    if @newissuealert.update_attributes(params[:newissuealert])
      redirect_to settings_project_path(@project, :tab => 'newissuealerts'), notice: l(:newissuealerts_save_success)
    else
      flash.now[:error] = l(:newissuealerts_save_failed)
      render 'edit'
    end
  end

  def destroy
    if @newissuealert.destroy
      flash[:notice] = l(:newissuealerts_deletion_success)
    else
      flash[:error] = l(:newissuealerts_deletion_failed)
    end
    redirect_to settings_project_path(@project, :tab => 'newissuealerts')
  end

  private

  def find_alert
    @newissuealert = Newissuealert.where(project_id: @project.id).find params[:id]
  end
end
