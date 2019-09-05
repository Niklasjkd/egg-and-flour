const displayRecipes = document.querySelector("#display-recipes");

function initDisplay() {
  const resultsId = document.getElementById("results-arr");

  if (resultsId) {
    const results = resultsId.querySelectorAll("#results");
    fetchData(results);
  }
}

const fetchData = (results) => {
  var finalRecipes = [];
  var itemsProcessed = 0;

  results.forEach((result) => {
    fetch(`https://www.food2fork.com/api/search?key=578f7f12bdb6dd279a954b7386722b0a&q=${result.innerText}`)
    .then(response => response.json())
    .then(({recipes}) => {
      itemsProcessed++;

      recipes.slice(0, 10).forEach((r, index) => {
        if (r.recipe_id != null) { finalRecipes.push(r); };
      });

      if (itemsProcessed == results.length) {
        showRecipes(finalRecipes.filter( onlyUnique ))
        initClickForPopover();
      }
    })
  });

  if (itemsProcessed == results.length) {
    showRecipes(finalRecipes.filter( onlyUnique ))
    initClickForPopover();
  }
}

function onlyUnique(value, index, self) {
    return self.indexOf(value) === index;
}

function showRecipes(recipes) {
  deactivateSpinner()

  if (recipes == null || recipes === false || recipes.length== 0) {
    viewIfNoRecipesFound()
  }

  recipes.forEach(function(r) {
    const recipesView =
          `<div class="images card">
            <div class="card-img-top" id="recipe${r.recipe_id}" data-id="${r.recipe_id}" data-title="${r.title}" data-image="${r.image_url}">
              <div class="recipe">
                <img src="${r.image_url}" alt="">
                <a data-id="${r.recipe_id}" class="badge badge-pill badge-light info-btn" style="position: absolute;top: 0;right: 0;margin: 10px;font-size: larger;">i</a>
              </div>
              <div class="card-body">
                <p>${r.title}</p>
              </div>
            </div>
          </div>`;
          displayRecipes.insertAdjacentHTML("beforeend", recipesView);
  });

  initHighlight()
}

function deactivateSpinner() {
  const spinner = document.getElementById("spinner");
  const parentContainer = spinner.parentElement;
  parentContainer.removeChild(spinner);
}

function viewIfNoRecipesFound() {
  const mainContainer = document.getElementById("main-container");
  const noRecipesView = `<div class="my-5" style="text-align: center">
  <h3>Sorry, your ingredients are very exotic!<br>We could not find any recipes.</h3>
  <a class="btn btn-primary" href="/#choose-ingredients">Let me do it again!</a>
  </div>`;
  mainContainer.insertAdjacentHTML("beforeend", noRecipesView);
}


const initHighlight = () => {
  const recipes = document.querySelectorAll(".card-img-top")

  recipes.forEach(recipe => {

    const image = recipe.querySelector("img");
    image.addEventListener('click', (event) => {
      const clickedCard = event.target.parentElement.parentElement
      clickOnRecipe(clickedCard, recipes);
    });

    const paragraph = recipe.querySelector("p");
    paragraph.addEventListener('click', (event) => {
      const clickedCard = event.target.parentElement.parentElement
      clickOnRecipe(clickedCard, recipes);
    });
  });
};

// QUERY THE input (look at the id)
// update value of input with recipeArray

export { initDisplay };

import { initClickForPopover, clickOnRecipe } from '../components/init_recipe_popover';
