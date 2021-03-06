class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  def new
    super
    @title = "비밀번호 찾기" #for mobile
    render_by_device
  end

  # POST /resource/password
  # def create
  #   super
  # end

  def after_create
    @title = "비밀번호 찾기" #for mobile
    render_by_device
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
    @title = "비밀번호 변경" #for mobile
    @disable_nav = true #for mobile
    render_by_device
  end

  # PUT /resource/password
  # def update
  #   super
  # end

  protected
  def after_resetting_password_path_for(resource)
    puts "########################################"
    puts "resetting code called!"
    mypage_index_path
  end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    users_passwords_after_create_path
  end
end