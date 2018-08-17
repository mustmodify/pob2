class OpsNotesController < CRUDController
  def model
    OpsNote.order('created_at desc')
  end

  def create
    notes = params[:ops_notes]

    notes.each do |note|
      ops_note = OpsNote.new(note.permit(:body))
      ops_note.author = current_user
      ops_note.save
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
