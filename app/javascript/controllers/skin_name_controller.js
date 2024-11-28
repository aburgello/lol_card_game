import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const form = this.element.querySelector("#skin-name-form");
    const feedback = this.element.querySelector("#feedback");
    const imageElement = document.getElementById("skin-image");
    const removeBlurIcon = document.getElementById("remove-blur-icon");
    const refreshIcon = document.getElementById("refresh-icon");

    // Handle form submission success
    if (form) {
      form.addEventListener("ajax:success", (event) => {
        const [response] = event.detail;

        console.log("Response received: ", response);

        if (response.correct) {
          feedback.innerHTML = `🎉 Correct! You've earned ${response.reward} Hextech Cores!`;
          feedback.classList.add("text-[#C8AA6E]");
          feedback.classList.remove("text-red-500");

          // Optionally reset form or load new skin
          form.reset();
          
          // Automatically remove the blur effect after correct guess
          this.removeBlur();

          setTimeout(() => {
            location.reload(); // Avoid using a full page reload if possible
          }, 2000);
        } else {
          feedback.innerHTML = "❌ Incorrect! Try again.";
          feedback.classList.add("text-red-500");
          feedback.classList.remove("text-[#C8AA6E]");
        }
      });

      form.addEventListener("ajax:error", () => {
        feedback.innerHTML = "An error occurred. Please try again.";
        feedback.classList.add("text-red-500");
      });
    }

    // Remove blur effect on image when the eye icon is clicked
    if (removeBlurIcon) {
      removeBlurIcon.addEventListener("click", () => {
        console.log("Eye icon clicked, removing blur...");
        this.removeBlur();
      });
    }

    // Refresh the game when the dice icon is clicked (reloading the page or generating a new skin)
    if (refreshIcon) {
      refreshIcon.addEventListener("click", () => {
        console.log("Dice icon clicked, refreshing game...");
        // Trigger a new game or refresh the page without reloading entirely
        setTimeout(() => {
          location.reload(); // You can customize this to fetch a new game instead of full reload
        }, 500);  // A small delay for the dice roll animation effect
      });
    }
  }

  // Helper method to remove the blur effect
  removeBlur() {
    const imageElement = document.getElementById("skin-image");

    if (imageElement) {
      console.log("Removing blur effect from the image...");
      imageElement.classList.remove("blur-effect");

      // Reapply blur after 1.5s (as before)
      setTimeout(() => {
        console.log("Reapplying blur effect after 1.5s...");
        imageElement.classList.add("blur-effect");
      }, 1500);
    } else {
      console.log("Image element not found!");
    }
  }
}
