class RegistrationController < Devise::RegistrationsController
  def new
    @member= Member.new
    @contact = Contact.new
  end

  def create
      @member = Member.new
      @member.email = params[:member][:email]
      @member.password = params[:member][:password]
      @member.password_confirmation =params[:member][:password_confirmation]

      if @member.errors.blank?
        @member.save
        redirect_to dashboard_path
      else
        render :action => "new"
      end
  end
end
