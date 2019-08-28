const initHighlight = () => {
  const recipes = document.querySelectorAll(".recipe")
  let recipeArray = [];
  let requests_recipes = document.querySelector('#requests_recipes');
    recipes.forEach(recipe => {
      recipe.addEventListener('click', (event) => {
        event.target.classList.toggle("highlight")
        if(recipeArray.includes(recipe.dataset.id)) {
          recipeArray = [...recipeArray].filter(val => val !== recipe.dataset.id);
          console.log(recipeArray);
          requests_recipes.value = recipeArray;
          console.log(requests_recipes);
        } else {
          recipeArray.push(recipe.dataset.id);
          console.log(recipeArray);
          requests_recipes.value = recipeArray;
          console.log(requests_recipes);
        }
    })
  });
};
// QUERY THE input (look at the id)
// update value of input with recipeArray

export { initHighlight };
