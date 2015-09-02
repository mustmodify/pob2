class CertEmailsController < ApplicationController
  def new
    @employee = Employee.find( params[:employee_id] )
    @presenter = CertEmailPresenter.new(employee: @employee)
  end

  def create
    @presenter = CertEmailPresenter.new(local_params)
    @employee = Employee.find( params[:employee_id] )

    if @presenter.valid?
      PostOffice.certs(@presenter.recipient, @presenter.employee, @presenter.certs.to_a).deliver_later
    else
      render action: 'new'
    end
  end

  def local_params
    params.require(:cert_email_presenter).permit(:employee_id, :recipient, :cert_ids => [])
  end
end
