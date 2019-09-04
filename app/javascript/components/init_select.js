const results = document.querySelectorAll("#results");
const displayRecipes = document.querySelector("#display-recipes");

const initDisplay = () => {
  var finalRecipes = [];
  var itemsProcessed = 0;
  
  results.forEach((result) => {
    fetch(`https://www.food2fork.com/api/search?key=c44d37368092aaac047c94555292a763&q=${result.innerText}`)
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
};

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
          <div class="card-img-top">
          <div class="recipe" id="recipe${r.recipe_id}" data-id="${r.recipe_id}" data-title="${r.title}" data-image="${r.image_url}">
          <img src="${r.image_url}" alt="">
          </div>
          <div class="card-body" data-id="${r.recipe_id}">
          <p data-id="${r.recipe_id}">${r.title}</p>
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
  const recipes = document.querySelectorAll(".recipe")
  const requests_recipes = document.querySelector('#recipes_recipes');
  let recipeArray = [];
  recipes.forEach(recipe => {
    recipe.addEventListener('click', (event) => {
      event.preventDefault()
      event.currentTarget.classList.toggle("highlight")
      const recipesA = [...recipes]
      const highlightedRecipes = recipesA.filter(recipe => recipe.classList.contains("highlight"));

      recipeArray = highlightedRecipes.map(({dataset: {id, image, title}}) => {
        return {id, image, title }
      });

      requests_recipes.value = JSON.stringify(recipeArray);
      console.log(recipeArray)

      updateBtnRecipeArr(recipeArray)
    })
  });
};

// QUERY THE input (look at the id)
// update value of input with recipeArray

export { initDisplay };

import { updateBtnRecipeArr } from '../components/init_recipe_btn';

import { initClickForPopover } from '../components/init_recipe_popover';
initClickForPopover();

