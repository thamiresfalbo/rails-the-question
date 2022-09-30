namespace :dev do
  DEFAULT_PASSWORD = 123_456

  desc 'Configura o ambiente.'
  task setup: :environment do
    if Rails.env.development?
      show_spinner('Apagando o BD...') { `rails db:drop` }
      show_spinner('Criando BD...') { `rails db:create` }
      show_spinner('Migrando...') { `rails db:migrate` }
      show_spinner('Criando o administrador...') { `rails dev:add_default_admin` }
      show_spinner('Criando o usuário...') { `rails dev:add_default_user` }
    else
      puts 'Não está em ambiente de desenvolvimento!'
    end
  end

  desc 'Adiciona o Administrador Padrão'
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@123.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc 'Adiciona o Administrador Padrão'
  task add_default_user: :environment do
    User.create!(
      email: 'user@123.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  private

  def show_spinner(msg_start, msg_end = 'Feito!')
    spinner = TTY::Spinner.new(":spinner #{msg_start}", format: :dots)
    spinner.auto_spin
    yield
    spinner.success(msg_end.to_s)
  end
end
