import "jquery-bar-rating";
import "jquery-bar-rating/dist/themes/css-stars.css";
// import $ from 'jquery'; // <-- if you're NOT using a Le Wagon template (cf jQuery section)

const initStarRating = () => {
  // TODO
  $('#review_rating').barrating({
    theme: 'css-stars'
  });

  $('.review_rating').barrating({
    theme: 'css-stars',
    readonly: true
  });

};

export { initStarRating };
