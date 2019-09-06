const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector('.navbar-lewagon');
  if (navbar) {
    window.addEventListener('scroll', () => {
      console.log(window.scrollY);

      if (window.scrollY) {
        navbar.classList.add('navbar-lewagon-white');
      } else {
        navbar.classList.remove('navbar-lewagon-white');
      }
      removeClass(navbar, window.scrollY);
    });
  }
}

function removeClass(navbar, yPosition) {
  if (yPosition >= 1100) {
    console.log("no navbar");
    navbar.classList.remove('navbar-lewagon-white');
  }
}

export { initUpdateNavbarOnScroll };
