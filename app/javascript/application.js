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

  document.addEventListener("turbo:load", function() {
    const searchBox = document.getElementById('championSearchBox');
    const championGrid = document.getElementById('championGrid');
  
    // Function to filter champions based on search
    searchBox.addEventListener('input', function() {
      const query = searchBox.value.toLowerCase();
  
      // Loop through all the champions and hide/show based on the search query
      const championButtons = championGrid.querySelectorAll('button');
      championButtons.forEach(button => {
        const championName = button.getAttribute('data-champion-name').toLowerCase();
        if (championName.includes(query)) {
          button.style.display = 'block'; // Show champion if it matches
        } else {
          button.style.display = 'none'; // Hide champion if it doesn't match
        }
      });
    });
  });
  