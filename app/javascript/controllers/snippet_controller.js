import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["zoomableImage", "feedback"]

  submitGuess(event) {
    event.preventDefault()
    const form = event.target
    const formData = new FormData(form)
    
    fetch(form.action, {
      method: 'POST',
      headers: {
        'Accept': 'application/json',  // Explicitly request JSON
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").content,
        'X-Requested-With': 'XMLHttpRequest'  // Mark as AJAX request
      },
      body: formData
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        this.handleCorrectGuess(data)
      } else {
        this.handleIncorrectGuess(data)
      }
      
      this.feedbackTarget.textContent = data.message
      form.reset()
    })
    .catch(error => {
      console.error('Error:', error)
      this.feedbackTarget.textContent = "An error occurred. Please try again."
    })
  }

  handleCorrectGuess(data) {
    this.feedbackTarget.classList.remove("text-red-500")
    this.feedbackTarget.classList.add("text-green-500")
    document.getElementById("attempts-count-snippet").textContent = 
      `${data.attempts} / 7`
  }

  handleIncorrectGuess(data) {
    this.feedbackTarget.classList.remove("text-green-500")
    this.feedbackTarget.classList.add("text-red-500")
    document.getElementById("attempts-count-snippet").textContent = 
      `${data.attempts} / 7`
    
    this.updateImageDisplay(data.newZoom, data.cropData)
  }

  updateImageDisplay(zoomLevel, cropData) {
    const image = this.zoomableImageTarget
    image.style.backgroundSize = `${zoomLevel}%`
    image.style.transform = `translate(${cropData.x}%, ${cropData.y}%)`
  }
}