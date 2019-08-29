function updateDOM(arr, btn) {
  const div = btn.parentElement.parentElement.querySelector(".checkbox-ingredients");
  div.innerHTML = "";

  arr.forEach(function(ingredient) {
      div.innerHTML += "<div><a class=\"small\" data-value=\"option1\" tabIndex=\"-1\"><input type=\"checkbox\"/>"+ ingredient +"</a></div>";
  });
}

const filterItems = (arr, query) => {
  if (query.length == 0) { return arr; }
  return arr.filter(el => el.toLowerCase().indexOf(query.toLowerCase()) > -1);
};

function clickEvent(event) {
  const eventBtn = event.target;
  const ingredient_category = eventBtn.id;
  const input_text = eventBtn.value;

  const data_ = document.getElementById('ingredients_data');
  const ingredients_data = JSON.parse(data_.dataset.ingredients);

  ingredients_data.forEach(function(ingredient_type) {
    if (ingredient_type.title === ingredient_category) {
      const result_arr = filterItems(ingredient_type.ingredients, input_text);
      console.log(result_arr);
      updateDOM(result_arr, eventBtn);
    }
  });
}

function initCheckboxSearches() {
  const searchBtns = document.querySelectorAll(".input-group input");

  if (searchBtns) {
    searchBtns.forEach(function(btn) {
      btn.addEventListener('change', clickEvent);
    });
  }
}



export { initCheckboxSearches };
