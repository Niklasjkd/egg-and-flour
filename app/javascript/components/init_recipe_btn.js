function updateDisplay(recipeNames) {
  const displayLabel = document.querySelector(".display");

  if (recipeNames.length == 1) {
    displayLabel.innerText = `${recipeNames.slice(-1)}`;

  } else if (recipeNames.length == 0) {
    displayLabel.innerText = ``;

  } else {
    displayLabel.innerText = `${recipeNames.slice(0,-1).join(", ")} and ${recipeNames.slice(-1)}`;
  }
}

function updateBtnRecipeNamesArr(recipeNames) {
  const recipes_count = recipeNames.length;

  if (recipes_count == 0) {
    $(".sticky-bar").slideUp();

  } else if (recipes_count == 1) {
    $(".sticky-bar").slideDown();
  }

  updateDisplay
(recipeNames);
}

function updateBtnRecipeArr(requests_recipes) {
  const recipeNames = [];
  requests_recipes.forEach(function(r) { recipeNames.push(r["title"]); });
  updateBtnRecipeNamesArr(recipeNames);
}



export { updateBtnRecipeArr, updateBtnRecipeNamesArr };
