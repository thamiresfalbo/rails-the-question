# frozen_string_literal: true

DEFAULT_PASSWORD = '123456'
DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

namespace :dev do
  desc 'Configura o ambiente.'
  task setup: :environment do
    if Rails.env.development?
      show_spinner('Apagando o BD...') { `rails db:drop` }
      show_spinner('Criando BD...') { `rails db:create` }
      show_spinner('Migrando...') { `rails db:migrate` }
      show_spinner('Criando o administrador padrão...') { `rails dev:add_default_admin` }
      show_spinner('Criando mais administradores...') { `rails dev:add_more_admins` }
      show_spinner('Criando o usuário...') { `rails dev:add_default_user` }
      show_spinner('Cadastrando os assuntos padrões...') { `rails dev:add_subjects` }
      show_spinner('Cadastrando perguntas e respostas...') { `rails dev:add_questions_and_answers` }
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

  desc 'Adiciona mais admistradores'
  task add_more_admins: :environment do
    10.times do
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc 'Adiciona assuntos'
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end

  desc 'Adiciona perguntas e respostas'
  task add_questions_and_answers: :environment do
    Subject.all.each do |subject|
      rand(1..5).times do |_i|
        params = create_question_params(subject)
        answer_array = params[:question][:answers_attributes]
        add_answers(answer_array)
        elect_true_answer(answer_array)
        Question.create!(params)
      end
    end
  end

  private

  def create_question_params(subject)
    { question: {
      description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
      subject: subject,
      answers_attributes: []
    } }
  end

  def create_answer_params(correct: false)
    { description: Faker::Lorem.sentence, correct: correct }
  end

  def add_answers(answer_array = [])
    5.times do
      answer_array.push(create_answer_params)
    end
  end

  def elect_true_answer(answer_array = [])
    answer_array[rand(answer_array.size)] = create_answer_params(correct: true)
  end

  def show_spinner(msg_start, msg_end = 'Feito!')
    spinner = TTY::Spinner.new(":spinner #{msg_start}", format: :dots)

    spinner.auto_spin
    yield
    spinner.success(msg_end.to_s)
  end
end
