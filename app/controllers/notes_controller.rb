class NotesController < CRUDController 

  def target_on_create
    employee_path( @note.employee )
  end

  def target_on_destroy
    @note.employee
  end

  def local_params
    params.fetch(:note, {}).permit(:body, :employee_id).merge(:author_id => current_user.id)
  end
end
