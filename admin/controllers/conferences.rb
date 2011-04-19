Admin.controllers :conferences do

  get :index do
    @conferences = Conference.all
    render 'conferences/index'
  end

  get :new do
    @conference = Conference.new
    render 'conferences/new'
  end

  post :create do
    @conference = Conference.new(params[:conference])
    if @conference.save
      flash[:notice] = 'Conference was successfully created.'
      redirect url(:conferences, :edit, :id => @conference.id)
    else
      render 'conferences/new'
    end
  end

  get :edit, :with => :id do
    @conference = Conference.get(params[:id])
    render 'conferences/edit'
  end

  put :update, :with => :id do
    @conference = Conference.get(params[:id])
    if @conference.update(params[:conference])
      flash[:notice] = 'Conference was successfully updated.'
      redirect url(:conferences, :edit, :id => @conference.id)
    else
      render 'conferences/edit'
    end
  end

  delete :destroy, :with => :id do
    conference = Conference.get(params[:id])
    if conference.destroy
      flash[:notice] = 'Conference was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy Conference!'
    end
    redirect url(:conferences, :index)
  end
end