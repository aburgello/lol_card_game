// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", function () {
  const hamburger = document.getElementById("hamburger");
  const mobileMenu = document.getElementById("mobile-menu");

  if (hamburger && mobileMenu) {
    hamburger.addEventListener("click", function () {
      mobileMenu.classList.toggle("hidden");
    });
  }
});


document.addEventListener('turbo:load', function() {
    const searchBox = document.getElementById('championSearchBox');
    let debounceTimeout;
  
    if (searchBox) {
      searchBox.addEventListener('input', function(e) {
        clearTimeout(debounceTimeout);
  
        debounceTimeout = setTimeout(() => {
          const searchTerm = e.target.value.trim();
          const url = new URL(searchBox.dataset.url);
          
          url.searchParams.set('search', searchTerm);
          
          const regionId = new URLSearchParams(window.location.search).get('region_id');
          if (regionId) {
            url.searchParams.set('region_id', regionId);
          }
  
          fetch(url, {
            headers: {
              'Accept': 'text/javascript',
              'X-Requested-With': 'XMLHttpRequest'
            },
            credentials: 'same-origin'
          })
          .then(response => response.text())
          .then(html => {
            const gridContainer = document.querySelector('#champions-grid-container');
            if (gridContainer) {
              gridContainer.innerHTML = html;
            }
          })
          .catch(error => {
            console.error('Error updating champions grid:', error);
          });
        }, 300);
      });
    }
  });