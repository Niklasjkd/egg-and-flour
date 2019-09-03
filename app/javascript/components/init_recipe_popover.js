var recipe_id = 0;

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

  fetch(`https://www.food2fork.com/api/get?key=578f7f12bdb6dd279a954b7386722b0a&rId=${recipe_id}`)
  .then(response => response.json())
  .then((data) => {
    console.log(data);

    const image_ele = document.querySelector(".recipe-popover .image");
    image_ele.src = data.recipe.image_url;

    const title_ele = document.querySelector(".recipe-popover .header");
    title_ele.innerText = data.recipe.title;

    const category_ele = document.querySelector(".recipe-popover .category");
    category_ele.innerText = "Vegan";

    const description_ele = document.querySelector(".recipe-popover .ingredients");
    const ingredients = ingredientsUnpack(data.recipe.ingredients);
    console.log(ingredients);
    ingredients.forEach(function(ingredient) {
      const movie = `<div class="row">
        <p class="col-10">${ingredient["ingredient"]}</p>
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
  recipeCard.classList.add("highlight");
  clickClose();
}

function initClickForPopover() {
  const btnClose = document.querySelector(".recipe-popover .close-btn");
  console.log(btnClose);

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
