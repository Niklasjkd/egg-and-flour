var recipe_id = 0;

function click(event) {
  recipe_id = event.target.dataset.id;

  fetch(`https://www.food2fork.com/api/get?key=26f7b22fb219b5a30816b2f68c726786&rId=${recipe_id}`)
  .then(response => response.json())
  .then((data) => {
    console.log(data);

    const image_ele = document.querySelector(".recipe-popover .image");
    image_ele.src = data.recipe.image_url;

    const title_ele = document.querySelector(".recipe-popover .header");
    title_ele.innerText = data.recipe.title;

    const category_ele = document.querySelector(".recipe-popover .category");
    category_ele.innerText = "Vegan";

    const method_ele = document.querySelector(".recipe-popover .method");
    method_ele.innerText = "Wait ten minutes.";

    const description_ele = document.querySelector(".recipe-popover .description");
    description_ele.innerText = data.recipe.ingredients;
    console.log(data.recipe.ingredients);

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
