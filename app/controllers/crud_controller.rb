class CRUDController < ApplicationController

  def index
#    set_records model.paginate(params[:page])
    set_records model.all

    respond_to do |format|
      format.html do
        set_records( collection )
      end
      format.json do
        render :json => collection
      end
    end
  end

  def show
    set_record model.find( params[:id] )

    respond_to do |format|
      format.html { }
      format.json { render :json => instance.to_json }
    end
  end

  def new
    set_record model.new
  end

  def edit
    set_record model.find( params[:id] )
  end

  def create
    set_record model.create( local_params )

    if( instance.save )
      respond_to do |format|
        format.html { redirect_to target_on_create }
        format.json { render :json => instance.to_json, :status => :created, :location => target_on_create }
        format.xml { render :xml => instance.to_xml, :status => :created, :location => target_on_create }
      end
    else
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render :json => instance.errors.full_messages, :status => :forbidden }
        format.xml { render :xml => instance.to_xml, :status => :created, :location => polymorphic_path(instance) }
      end
    end
  end

  def update
    set_record model.update( params[:id], local_params )
    respond_to do |format|
      format.html { redirect_to target_on_update }
      format.json { render :json => instance.to_json }
      format.xml  { render :xml => instance.to_xml }
    end
  end

  def destroy
    set_record model.destroy( params[:id] )
    redirect_to target_on_destroy
  end

  private

  def target_on_create
    polymorphic_path( instance )
  end

  def target_on_destroy
    {:controller => params[:controller], :action => :index} 
  end

  def target_on_update
    target_on_create
  end

  def model_name
    @model_name ||= self.class.name.gsub(/Controller$/, '').singularize
  end

  def params_model_name
    @params_model_name ||= model_name.underscore
  end

  def model
    eval(model_name)
  end

  def instance_name
    '@'+params_model_name
  end

  def collection_name
    '@' + params_model_name.pluralize
  end

  def collection
    instance_variable_get( collection_name )
  end

  def instance
    instance_variable_get( instance_name )
  end

  def set_record(value)
    instance_variable_set(instance_name, value)
  end

  def set_records(values)
    instance_variable_set(collection_name, values)
  end
end

