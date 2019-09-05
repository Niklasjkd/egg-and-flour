var recipe_id = 0;
var image_url = "";
var title = "";

function ingredientsUnpack(ingredientString) {
  var unpacked_ingredients = [];
  ingredientString.forEach(function(ingredient) {
    const arr = ingredient.split(" ");
    const amount = arr.shift();
    var new_property = {
      amount: amount,
      ingredient: arr.join(" ")
    }

    unpacked_ingredients.push(new_property);
  });
  return unpacked_ingredients
}

function click(event) {
  recipe_id = event.target.dataset.id;
  console.log(recipe_id);

  fetch(`https://www.food2fork.com/api/get?key=26f7b22fb219b5a30816b2f68c726786&rId=${recipe_id}`)
  .then(response => response.json())
  .then((data) => {

    const image_ele = document.querySelector(".recipe-popover .image");
    image_url =  data.recipe.image_url;
    image_ele.src = image_url;

    const title_ele = document.querySelector(".recipe-popover .header");
    title = data.recipe.title;
    title_ele.innerText = title;

    const category_ele = document.querySelector(".recipe-popover .category");
    category_ele.innerText = "Home-made";

    const description_ele = document.querySelector(".recipe-popover .ingredients");
    const ingredients = ingredientsUnpack(data.recipe.ingredients);
    description_ele.innerText = "";
    ingredients.forEach(function(ingredient) {
      const movie = `<div class="row">
      <p class="col-9">${ingredient["ingredient"]}</p>
      <p class="col-1">${ingredient["amount"]}</p>
      </div>`;
      description_ele.insertAdjacentHTML("beforeend", movie);
    });

    const popover = document.querySelector(".recipe-popover");
    popover.style.display = "inline";
    $(".recipe-data").slideToggle();
  })
}

function clickClose() {
  const popupView = document.querySelector(".recipe-popover");
  popupView.style.display = "none";
  $(".recipe-data").slideToggle();
}

function checkForUniqueness(recipes, recipe) {
  var itemsProcessed = 0;

  recipes.forEach(function(recipeIndex) {
    itemsProcessed++;
    if (recipe["id"] === recipeIndex["id"]) {
      return false
    }

    if (itemsProcessed == recipes.length) {
      return true
    }
  });
  if (itemsProcessed == recipes.length) {
      return true
    }
}

function clickSelect() {
  const clickedCard = document.getElementById(`recipe${recipe_id}`);
  clickedCard.classList.remove("highlight")

  const recipes = document.querySelectorAll(".card-img-top")
  clickOnRecipe(clickedCard, recipes)
  clickClose();
}

function initClickForPopover() {
  const btnClose = document.querySelector(".recipe-popover .close-btn");

  if (btnClose) {
    btnClose.addEventListener("click", clickClose);

    const btnSelect = document.querySelector(".recipe-popover .select-btn");
    btnSelect.addEventListener("click", clickSelect);

    const member_cards = document.querySelectorAll("#display-recipes .info-btn");
    member_cards.forEach(function(card) {
      card.addEventListener("click", click);
    });
  }
}

function clickOnRecipe(clickedCard, recipes) {
  const requests_recipes = document.querySelector('#recipes_recipes');
  let recipeArray = [];

  event.preventDefault()

  clickedCard.classList.toggle("highlight")
  const recipesA = [...recipes]
  const highlightedRecipes = recipesA.filter(recipe => recipe.classList.contains("highlight"));

  recipeArray = highlightedRecipes.map(({dataset: {id, image, title}}) => {
    return {id, image, title }
  });

  requests_recipes.value = JSON.stringify(recipeArray);
  console.log(recipeArray)

  updateBtnRecipeArr(recipeArray)
}

function initDashboardPopover() {
  const title = document.querySelector(".recipe-index-title");

  if (title) {
    const member_cards = document.querySelectorAll(".card-img-top");
    member_cards.forEach(function(card) {
      card.addEventListener("click", click);
    });
  }
}

import { updateBtnRecipeNamesArr, updateBtnRecipeArr } from "../components/init_recipe_btn";

export { initClickForPopover, clickOnRecipe, initDashboardPopover };
