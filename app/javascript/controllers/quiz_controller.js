import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    gameId: Number,
    correctAnswer: String,
    minReward: Number,
    questions: Array,
  };

  connect() {
    console.log("Quiz controller connected");

    // Access the data attributes from the DOM element
    const element = this.element;
    this.gameIdValue = element.dataset.quizGameId;
    this.minRewardValue = element.dataset.quizMinReward;

    // Attempt to parse questions data
    const questionsData = element.dataset.quizQuestions;

    // Debugging output
    console.log("Raw Questions Data:", questionsData);

    try {
        this.questionsValue = JSON.parse(questionsData);
    } catch (error) {
        console.error("Failed to parse questions data:", error);
        this.questionsValue = []; // Fallback to an empty array
    }

    // Check if questionsValue is an array
    if (!Array.isArray(this.questionsValue)) {
        console.error("Expected questionsValue to be an array, but got:", this.questionsValue);
        this.questionsValue = []; // Fallback to an empty array
    }

    // Set the initial correct answer and question index
    if (this.questionsValue.length > 0) {
        // Ensure that the first question has a correct_answer property
        this.correctAnswerValue = this.questionsValue[0].correct_answer; // Set the correct answer for the first question
        console.log("Initial Correct Answer:", this.correctAnswerValue);
    } else {
        console.error("No questions available.");
    }

    console.log("Game ID:", this.gameIdValue);
    console.log("Min Reward:", this.minRewardValue);
    console.log("Questions:", this.questionsValue);
}


selectAnswer(event) {
  const selectedAnswer = event.target.dataset.answer;

  // Disable all buttons after an answer is selected
  const buttons = this.element.querySelectorAll("button");
  buttons.forEach(button => button.disabled = true);

  // Highlight selected answer
  buttons.forEach(button => button.classList.remove("bg-[#C8AA6E]", "text-slate-900"));
  event.target.classList.add("bg-[#C8AA6E]", "text-slate-900");

  // Show feedback
  const feedbackElement = this.element.querySelector("#feedback");
  if (selectedAnswer === this.correctAnswerValue) {
    feedbackElement.textContent = `Correct! You've earned ${this.minRewardValue} cores.`;
    feedbackElement.classList.add("text-green-500");
    feedbackElement.classList.remove("text-red-500");
  } else {
    feedbackElement.textContent = `Incorrect! The correct answer is: ${this.correctAnswerValue}`;
    feedbackElement.classList.add("text-red-500");
    feedbackElement.classList.remove("text-green-500");
  }

  // Prepare the data to send to the server
  const selectedAnswerData = {
    selected_answer: selectedAnswer,
    question_index: this.getCurrentQuestionIndex() // Get the current question index
  };

  const token = document.querySelector('meta[name="csrf-token"]').content;

  fetch(`/games/${this.gameIdValue}/submit_answer`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": token,  // Include CSRF token
    },
    body: JSON.stringify(selectedAnswerData),
  })
  .then(response => response.json()) // Get the response as JSON
  .then(data => {
    console.log("Response Data:", data); // Log the data received from the server
    if (data.success) {
      // Update attempts count in the UI
      this.updateAttemptsDisplay(data.attempts); // Ensure this accesses the correct property
  
      // Wait for 2 seconds before moving to the next question
      setTimeout(() => {
        if (data.next_question) {
          this.loadNextQuestion(data.question); // Pass the next question data
        } else {
          // Handle quiz completion
          this.showModal("Quiz Complete", `You earned ${this.minRewardValue} cores!`);
        }
      }, 2000);
    } else {
      console.error("Error in response:", data.error); // Handle error case
    }
  })
  .catch(error => {
    console.error('Error:', error);
  });
}

updateAttemptsDisplay(attempts) {
  const attemptsElement = document.getElementById("attempts-count");
  if (attemptsElement) {
      attemptsElement.textContent = `${attempts} / 5`; // Update with the new attempts count
  }
}

  // This method should handle loading the next question
  loadNextQuestion(data) {
    // Log the data received
    console.log("Loading next question with data:", data);

    // Get the question element and feedback element
    const questionElement = document.getElementById('question');
    const feedbackElement = this.element.querySelector("#feedback");
    const answersContainer = this.element.querySelector('.grid'); // Assuming your answers are in a grid

    // Check if the questionElement exists
    if (questionElement) {
        // Update the question text
        questionElement.textContent = data.question || "No more questions!";
    } else {
        console.error("Question element not found!");
    }

    // Clear previous answers
    if (answersContainer) {
        answersContainer.innerHTML = ''; // Clear existing answers
    } else {
        console.error("Answers container not found!");
    }

    // Check if the feedbackElement exists
    if (feedbackElement ) {
        feedbackElement.textContent = ""; // Clear feedback
    } else {
        console.error("Feedback element not found!");
    }

    // Add new answer buttons
    if (data.answers && Array.isArray(data.answers)) {
        data.answers.forEach(answer => {
            const button = document.createElement('button');
            button.className = "block w-full bg-slate-700 text-slate-300 hover:bg-[#C8AA6E] hover:text-slate-900 py-4 px-4 rounded-lg transition-all duration-200";
            button.dataset.action = "click->quiz#selectAnswer";
            button.dataset.answer = answer;
            button.textContent = answer;

            // Append the button to the answers container
            answersContainer.appendChild(button);
        });
    } else {
        console.error("No answers found for the next question.");
    }

    // Update the correct answer for the next question
    this.correctAnswerValue = data.correct_answer; // Store the correct answer for comparison later
    console.log("Correct answer for the next question:", this.correctAnswerValue);

    // Update the current question index in the URL or state
    const currentIndex = this.getCurrentQuestionIndex();
    const newIndex = currentIndex + 1;
    const url = new URL(window.location);
    url.searchParams.set('question_index', newIndex);
    window.history.pushState({}, '', url); // Update the URL without reloading
}
  getCurrentQuestionIndex() {
    // Logic to determine the current question index based on the URL or other means
    const urlParams = new URLSearchParams(window.location.search);
    return parseInt(urlParams.get('question_index')) || 0; // Default to 0 if not found
  }

  showModal(title, message) {
    // Display modal with completion message
    const modal = document.createElement("div");
    modal.classList.add("modal", "modal-open");
    modal.innerHTML = `
      <div class="modal-content">
        <h2>${title}</h2>
        <p>${message}</p>
        <button class="close-modal">Close</button>
      </div>
    `;
    document.body.appendChild(modal);

    // Close modal when clicked
    modal.querySelector(".close-modal").addEventListener("click", () => {
      modal.remove();
    });
  }
}