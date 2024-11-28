import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["feedback", "championGrid", "attemptsCount", "searchBox", "championButton"]
  static values = {
    gameId: Number,
    attempts: Number
  }

  connect() {
    console.log("AbilityGuess controller connected")
    console.log("Game ID:", this.gameIdValue)
    console.log("Current attempts:", this.attemptsValue)
  }

  search() {
    const query = this.searchBoxTarget.value.toLowerCase()
    
    this.championButtonTargets.forEach(button => {
      const championName = button.dataset.championName.toLowerCase()
      button.style.display = championName.includes(query) ? 'block' : 'none'
    })
  }

  submitGuess(event) {
    event.preventDefault()
    const championId = event.currentTarget.dataset.championId
    
    if (this.attemptsValue >= 5) {
      this.showDailyLimit()
      return
    }

    this.submitGuessToServer(championId)
  }

  submitGuessToServer(championId) {
    const token = document.querySelector("[name='csrf-token']")?.content
    if (!token) {
      console.error("CSRF token not found")
      return
    }

    fetch(`/games/${this.gameIdValue}/submit_guess`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": token
      },
      body: JSON.stringify({ champion_id: championId })
    })
    .then(this.handleResponse.bind(this))
    .catch(this.handleError.bind(this))
  }

  handleResponse(response) {
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`)
    }
    return response.json().then(data => {
      if (data.success) {
        this.showCorrectAnswer(data)
      } else {
        this.showIncorrectAnswer(data)
      }
      
      this.updateAttempts(data.attempts)
    })
  }

  updateAttempts(attempts) {
    if (attempts !== undefined && this.hasAttemptsCountTarget) {
      this.attemptsValue = attempts
      this.attemptsCountTarget.textContent = attempts
      
      if (attempts >= 5) {
        this.disableGuessing()
      }
    }
  }

  showDailyLimit() {
    if (this.hasFeedbackTarget) {
      this.feedbackTarget.textContent = "You've reached your daily limit!"
      this.feedbackTarget.classList.add("text-red-500")
    }
  }

  showCorrectAnswer(data) {
    if (!this.hasFeedbackTarget) return
    
    this.feedbackTarget.textContent = data.message || "Correct!"
    this.feedbackTarget.classList.remove("text-red-500")
    this.feedbackTarget.classList.add("text-green-500")
  }

  showIncorrectAnswer(data) {
    if (!this.hasFeedbackTarget) return
    
    this.feedbackTarget.textContent = data.message || "Incorrect. Try again!"
    this.feedbackTarget.classList.remove("text-green-500")
    this.feedbackTarget.classList.add("text-red-500")
  }

  handleError(error) {
    console.error("Error:", error)
    if (this.hasFeedbackTarget) {
      this.feedbackTarget.textContent = "An error occurred. Please try again."
      this.feedbackTarget.classList.add("text-red-500")
    }
  }

  disableGuessing() {
    if (!this.hasChampionGridTarget) return
    
    const buttons = this.championGridTarget.querySelectorAll("button")
    buttons.forEach(button => {
      button.disabled = true
      button.classList.add("opacity-50")
    })
  }
}