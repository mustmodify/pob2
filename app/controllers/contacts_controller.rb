class ContactsController < NestedCRUDController

  def target_on_create
    employee_contacts_path( @employee )
  end

  def local_params
    params.require(:contact).permit(:name, :relationship, :home_phone, :cell_phone, :alt_phone).merge(:employee_id => @employee.id)
  end
end
