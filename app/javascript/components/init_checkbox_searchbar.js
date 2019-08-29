function updateDOM(arr, input) {
  const divCheckbox = input.parentElement.parentElement.querySelectorAll(".checkbox-ingredients div");

  divCheckbox.forEach(function(div) {
    if (arr.includes(div.querySelector("a").innerText)) {
      div.style.display = "block";
    } else {
      div.style.display = "none";
    }
  });
}

const filterItems = (arr, query) => {
  if (query.length == 0) { return arr; }
  return arr.filter(el => el.toLowerCase().indexOf(query.toLowerCase()) > -1);
};

function changeEvent(event) {
  const input = event.target;
  const ingredientCategory = input.id;
  const inputText = input.value;

  const data_ = document.getElementById('ingredients_data');
  const ingredients_data = JSON.parse(data_.dataset.ingredients);

  ingredients_data.forEach(function(ingredientType) {
    if (ingredientType.title === ingredientCategory) {
      const result_arr = filterItems(ingredientType.ingredients, inputText);
      updateDOM(result_arr, input);
    }
  });
}

function initCheckboxSearches() {
  const searchInputs = document.querySelectorAll(".input-group input");

  if (searchInputs) {
    searchInputs.forEach(function(input) {
      input.addEventListener('change', changeEvent);
    });
  }
}

export { initCheckboxSearches };
