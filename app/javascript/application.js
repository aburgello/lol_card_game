// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import Swiper from 'swiper';




document.addEventListener("turbo:load", function () {
  const hamburger = document.getElementById("hamburger");
  const mobileMenu = document.getElementById("mobile-menu");

  if (hamburger && mobileMenu) {
    hamburger.addEventListener("click", function () {
      mobileMenu.classList.toggle("hidden");
    });
  }
});



document.addEventListener('turbo:load', () => {
  initializeSwipers();
});

document.addEventListener('turbo:frame-load', () => {
  initializeSwipers();
});

function initializeSwipers() {
  const skinSwipers = document.querySelectorAll('.skins-swiper');
  
  skinSwipers.forEach(swiper => {
    if (!swiper.swiper) {
      new Swiper(swiper, {
        slidesPerView: 'auto',
        spaceBetween: 10,
        navigation: {
          nextEl: swiper.querySelector('.swiper-button-next'),
          prevEl: swiper.querySelector('.swiper-button-prev'),
        },
        pagination: {
          el: swiper.querySelector('.swiper-pagination'),
          clickable: true,
        },
      });
    }
  });
}
