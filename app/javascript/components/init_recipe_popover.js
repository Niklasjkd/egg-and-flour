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
  fetch(`https://www.food2fork.com/api/get?key=8b8ae15fe8d57531cd193adbd9b50b15&rId=${recipe_id}`)
  .then(response => response.json())
  .then((data) => {

    const image_ele = document.querySelector(".recipe-popover .image");
    image_url =  data.recipe.image_url;
    image_ele.src = image_url;

    const title_ele = document.querySelector(".recipe-popover .header");
    title = data.recipe.title;
    title_ele.innerText = title;

    const category_ele = document.querySelector(".recipe-popover .category");
    category_ele.innerText = "Vegan";

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
  })
}

function clickClose() {
  const popupView = document.querySelector(".recipe-popover");
  popupView.style.display = "none";
}

function clickSelect() {
  const recipeCard = document.getElementById(`recipe${recipe_id}`);
  const requests_recipes = document.querySelector('#recipes_recipes');
  const recipes_arr = JSON.parse(requests_recipes.value);
  recipes_arr.push({
    "id" : recipe_id,
    "image" :image_url,
    "title": title
  })

  requests_recipes.value = JSON.stringify(recipes_arr);
  recipeCard.classList.add("highlight");
  clickClose();
}

function initClickForPopover() {
  const btnClose = document.querySelector(".recipe-popover .close-btn");

  if (btnClose) {
    btnClose.addEventListener("click", clickClose);

    const btnSelect = document.querySelector(".recipe-popover .select-btn");
    btnSelect.addEventListener("click", clickSelect);

    const member_cards = document.querySelectorAll("#display-recipes .card-body");
    member_cards.forEach(function(card) {
      card.addEventListener("click", click);
    });
  }
}

export { initClickForPopover };
