const results = document.querySelectorAll("#results");
const displayRecipes = document.querySelector("#display-recipes");

const initDisplay = () => {
  results.forEach((result) => {
    fetch(`https://www.food2fork.com/api/search?key=26f7b22fb219b5a30816b2f68c726786&q=${result.innerText}`)
    .then(response => response.json())
    .then(({recipes}) => {
      recipes.slice(0, 5).forEach((r) => {

        if (r.recipe_id != null) {
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
          displayRecipes.insertAdjacentHTML("afterbegin", recipesView);
        };
      });

    })
    .then(() => [ initHighlight(), initClickForPopover()]);

  });
};

const initHighlight = () => {
  const recipes = document.querySelectorAll(".recipe")
  const requests_recipes = document.querySelector('#recipes_recipes');
  console.log(requests_recipes.value)
  let recipeArray = [];
  recipes.forEach(recipe => {
    recipe.addEventListener('click', (event) => {
        event.currentTarget.classList.toggle("highlight")
        const recipesA = [...recipes]
        const highlightedRecipes = recipesA.filter(recipe => recipe.classList.contains("highlight"));

        recipeArray = highlightedRecipes.map(({dataset: {id, image, title}}) => {
          return {id, image, title }
        });

        requests_recipes.value = JSON.stringify(recipeArray);
      console.log(recipeArray)
    })
  });
};
// QUERY THE input (look at the id)
// update value of input with recipeArray

export { initDisplay };

import { initClickForPopover } from '../components/init_recipe_popover';
initClickForPopover();

