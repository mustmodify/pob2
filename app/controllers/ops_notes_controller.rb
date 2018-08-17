class OpsNotesController < CRUDController
  def model
    OpsNote.order('created_at desc')
  end

  def create
    notes = params[:ops_notes]

    notes.each do |note|
      OpsNote.create(note.permit(:body))
    end

    redirect_to ops_notes_path
  end

  def local_params
    params.fetch(:ops_note, {}).permit(:body)
  end

  def target_on_create
    ops_notes_path
  end
end
