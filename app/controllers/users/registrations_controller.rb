class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  # respond_to :json

  def new
    respond_to do |format|
      format.html { @user = User.new }
      format.json
    end
  end

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: { message: 'Signed up sucessfully.' }
  end

  def register_failed
    render json: { message: 'Something went wrong.' }
  end
end
