import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const form = this.element.querySelector("#skin-name-form");
    const removeBlurIcon = document.getElementById("remove-blur-icon");
    const refreshIcon = document.getElementById("refresh-icon");
    const imageElement = document.getElementById("skin-image");

    if (form) {
      const observer = new MutationObserver((mutations) => {
        const feedback = this.element.querySelector("#feedback");
        if (feedback && feedback.textContent.includes("Correct")) {
            imageElement.classList.remove("blur-effect");
            setTimeout(() => {
            window.location.reload();
          }, 2000);
        }
      });

      observer.observe(this.element, { childList: true, subtree: true });
    }

    if (removeBlurIcon) {
      removeBlurIcon.addEventListener("click", () => this.removeBlur());
    }

    if (refreshIcon) {
      refreshIcon.addEventListener("click", () => window.location.reload());
    }
  }

  removeBlur() {
    const imageElement = document.getElementById("skin-image");
    if (imageElement) {
      imageElement.classList.remove("blur-effect");
      setTimeout(() => {
        imageElement.classList.add("blur-effect");
      }, 1500);
    }
  }
}