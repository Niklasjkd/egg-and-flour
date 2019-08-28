const initHighlight = () => {
  const recipes = document.querySelectorAll(".recipe")
  let recipeArray = [];
    recipes.forEach(recipe => {
      recipe.addEventListener('click', (event) => {
        event.target.classList.toggle("highlight")
        if(recipeArray.includes(recipe.dataset.id)) {
          recipeArray = [...recipeArray].filter(val => val !== recipe.dataset.id)
        } else {
          recipeArray.push(recipe.dataset.id);

        }
    })
  });
  return recipeArray;
};

export { initHighlight };
