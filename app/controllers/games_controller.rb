class GamesController < ApplicationController
  before_action :set_game, only: [:show, :submit_answer]
  before_action :check_quiz_attempts, only: [:show, :submit_answer]

  QUESTIONS = [
    { question: "What is the cooldown of Flash in League of Legends?", answers: ["180 seconds", "210 seconds", "300 seconds", "150 seconds"], correct_answer: "300 seconds" },
    { question: "Which champion has the ability 'R' - Leap Strike?", answers: ["Lee Sin", "Riven", "Jax", "Kennen"], correct_answer: "Jax" },
    { question: "What is the maximum level a champion can reach?", answers: ["15", "18", "20", "25"], correct_answer: "18" },
    { question: "Which item grants bonus movement speed when out of combat?", answers: ["Boots of Speed", "Ionian Boots of Lucidity", "Berserker's Greaves", "Boots of Mobility"], correct_answer: "Boots of Mobility" },
    { question: "What is the name of the dragon that grants a team bonus attack damage?", answers: ["Cloud Drake", "Mountain Drake", "Infernal Drake", "Ocean Drake"], correct_answer: "Infernal Drake" },
    { question: "Which champion is known as the 'Unforgiven'?", answers: ["Yasuo", "Zed", "Riven", "Jhin"], correct_answer: "Yasuo" },
    { question: "What is the primary resource used by champions to cast abilities?", answers: ["Energy", "Mana", "Rage", "Health"], correct_answer: "Mana" },
    { question: "Which item is used to counteract healing effects?", answers: ["Executioner's Calling", "Mortal Reminder", "Greaves of the Legion", "Riftmaker"], correct_answer: "Mortal Reminder" },
    { question: "What is the name of the Rift Herald's ability?", answers: ["Rift Assault", "Herald's Charge", "Rift Surge", "Herald's Wrath"], correct_answer: "Rift Surge" },
    { question: "Which champion can teleport to a ward?", answers: ["Kennen", "Kassadin", "Shen", "Twisted Fate"], correct_answer: "Shen" },
    { question: "What does the Baron Nashor buff grant?", answers: ["Increased health regeneration", "Bonus attack damage and ability power", "Vision of the enemy jungle", "Increased gold per minion"], correct_answer: "Bonus attack damage and ability power" },
    { question: "Which champion has a passive ability called 'Adrenaline Rush'?", answers: ["Warwick", "Rengar", "Olaf", "Dr. Mundo"], correct_answer: "Warwick" },
    { question: "What is the name of the jungle monster that grants a shield when killed?", answers: ["Gromp", "Krug", "Rift Scuttler", "Blue Buff"], correct_answer: "Rift Scuttler" },
    { question: "Which item is known for providing 'Spell Vamp'?", answers: ["Gunblade", "Rylai's Crystal Scepter", "Riftmaker", "Morellonomicon"], correct_answer: "Gunblade" },
    { question: "What is the cooldown of the ability 'Smite'?", answers: ["60 seconds", "90 seconds", "45 seconds", "30 seconds"], correct_answer: "15 seconds" },
    { question: "Which champion is known as the 'Cryophoenix'?", answers: ["Anivia", "Lissandra", "Zyra", "Frost Queen"], correct_answer: "Anivia" },
    { question: "What is the name of the in-game currency?", answers: ["Gold", "Silver", "Platinum", "Crystal"], correct_answer: "Gold" },
    { question: "Which champion can create a 'Doppelganger'?", answers: ["Kassadin", "Shaco", "Zed", "Mordekaiser"], correct_answer: "Shaco" },
    { question: "What is the name of the ability that allows champions to dodge incoming attacks?", answers: ["Evasion ", "Dodge", "Spell Shield", "Counter"], correct_answer: "Spell Shield" },
    { question: "Which champion has the ability 'R' - Destiny?", answers: ["Twisted Fate", "Zyra", "Kennen", "Gragas"], correct_answer: "Twisted Fate" },
    { question: "What does the 'S' rank in a game signify?", answers: ["Satisfactory", "Superb", "S-tier", "Special"], correct_answer: "Superb" }
  ]

 
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @current_question_index = params[:question_index].to_i || 0
  
    # Shuffle the QUESTIONS array for random order and store in session
    session[:shuffled_questions] = QUESTIONS.shuffle
  
    # Retrieve shuffled questions from session
    @shuffled_questions = session[:shuffled_questions]

    if @current_question_index < @shuffled_questions.length
      @question = @shuffled_questions[@current_question_index][:question]
      @answers = @shuffled_questions[@current_question_index][:answers]
      @correct_answer = @shuffled_questions[@current_question_index][:correct_answer]
    else
      flash[:notice] = "Quiz completed!"
      redirect_to root_path and return
    end
  
    # Pass the shuffled QUESTIONS constant to the view
    @questions = @shuffled_questions
  end

  def submit_answer
    Rails.logger.info("Received parameters: #{params.inspect}")
    selected_answer = params[:selected_answer]
    question_index = params[:question_index].to_i
  
    # Retrieve shuffled questions from session
    @shuffled_questions = session[:shuffled_questions]
  
    # Ensure the shuffled questions exist
    if @shuffled_questions.nil?
      Rails.logger.error("Shuffled questions not found in session.")
      render json: { success: false, error: "Session expired. Please restart the quiz." }, status: :unprocessable_entity and return
    end
  
    # Ensure the question index is valid
    if question_index < 0 || question_index >= @shuffled_questions.length
      Rails.logger.error("Invalid question index: #{question_index}")
      render json: { success: false, error: "Invalid question index." }, status: :unprocessable_entity and return
    end
  
    # Check if the selected answer is correct
    correct_answer = @shuffled_questions[question_index][:correct_answer]
    user_score = (selected_answer == correct_answer) ? 1 : 0
  
    # Increment the user's Hextech cores if the answer is correct
    if user_score > 0
      current_user.increment!(:hextech_cores, user_score * 50)
    end
  
    # Prepare the response data
    response_data = {
      success: true,
      next_question: question_index + 1 < @shuffled_questions.length,
      question: @shuffled_questions[question_index + 1] || nil,
      correct_answer: @shuffled_questions[question_index + 1][:correct_answer] || nil,
      answers: @shuffled_questions[question_index + 1][:answers] || []
    }
  
    render json: response_data
  rescue StandardError => e
    Rails.logger.error("Error in submit_answer: #{e.message}")
    render json: { success: false, error: "An error occurred while processing your request." }, status: :internal_server_error
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def check_quiz_attempts
    if current_user.quiz_attempts_today >= 5
      flash[:alert] = "You've reached your quiz limit for today."
    else
      current_user.increment!(:quiz_attempts_today)
    end
  end
end