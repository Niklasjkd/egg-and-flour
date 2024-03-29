function positionIngredients(data_) {
  const ingredients_data = JSON.parse(data_.dataset.ingredients);

  var radians, radius;
  radius = 230;

  var totalItems = ingredients_data.length;
  var item = 1;

  var x, y, angle = 0, step = (2*Math.PI) / totalItems;
  var width = $('#category-circle').width()/2;
  var height = $('#category-circle').height()/2;
  var itemW = 20, itemH = 2;
  var deg = 0;

  while(item <= totalItems) {
    const item_data = ingredients_data[item - 1];
    const ingredients = item_data.ingredients;

    var inhalt = "<button type=\"button\" class=\"btn btn-default btn-sm dropdown-toggle\" data-toggle=\"dropdown\">";
    inhalt += "<img class=\"category-icon\" src="+ item_data.image +" alt=\"\">"
    inhalt += "<span class=\"glyphicon glyphicon-cog\">";
    inhalt += "</span> <span class=\"caret\"><h5>"+ item_data.title +"</h5></button>";
    inhalt += "<div  style=\"border: 0.8px solid #ced4da;\" class=\"dropdown-menu ingredients-dropdown\">";
    inhalt += "<div class=\"input-group d-flex\">";
    inhalt += "<input id="+ item_data.title +" type=\"text\" class=\"form-control\" placeholder=\""+ item_data.title +" ingredients\" aria-label=\"Recipient's username\" aria-describedby=\"button-addon2\">";

    inhalt += "</div>";

    inhalt += "<div style=\"overflow:scroll; height:200px;\" class=\"checkbox-ingredients\" id=\"ingredients-checkbox-list\">";
    ingredients.forEach(function(ingredient) {
      inhalt += "<div for=\"ingredient="+ ingredient +"\"><label class=\"small\" data-value=\"option1\" tabIndex=\"-1\"><input id=\"ingredient="+ ingredient +"\" type=\"checkbox\"/>"+ ingredient +"</label></div>";
    });
    inhalt += "</div>";
    inhalt += "</div>";

    x = Math.round(width + radius * Math.cos(angle) - itemW/2) - 80 + 45;
    y = Math.round(height + radius * Math.sin(angle) - itemH/2) - 80;

    $('#category-circle').append('<div id="'+ item +'">'+ inhalt +'<div/>')
    $('div#'+item).css('position', 'absolute')
      .css('width', 70+'px').css('height', 70+'px')
      .css('left', x+'px').css('top', y+'px')
      .css('transform-origin', x+'px' -y+'px')

    angle += step;
    ++item;
    deg += 360/totalItems;
  }
}

const clicked_ingredients = []

function checkbox_click(event) {
  const ingredient = event.target.parentElement.innerText

  if (ingredient != "") {
    if (clicked_ingredients.includes(ingredient)) {
      clicked_ingredients.pop(clicked_ingredients.indexOf(ingredient));
    } else {
      clicked_ingredients.push(ingredient);
    }

    updateBtn()
  }
}

function updateDisplayIngredients() {
  const ingredientsLabel = document.querySelector(".display");

  if (clicked_ingredients.length == 1) {
    ingredientsLabel.innerText = `${clicked_ingredients.slice(-1)}`;

  } else if (clicked_ingredients.length == 0) {
    ingredientsLabel.innerText = ``;

  } else {
    ingredientsLabel.innerText = `${clicked_ingredients.slice(0,-1).join(', ')} and ${clicked_ingredients.slice(-1)}`;
  }
}

function updateBtnText(btn, ingredients_count) {
  const btnText = btn.innerText.split(' ');
  btnText.pop();
  btn.innerText = btnText.join(' ') + " (" + ingredients_count + "/2)";
}

function updateBtn() {
  const btn = document.getElementById("find-recipies");
  const ingredients_count = clicked_ingredients.length;

  if (ingredients_count >= 2) {
    btn.classList.remove("disabled");
  } else {
    btn.classList.add("disabled");
  }
  updateBtnText(btn, ingredients_count);

  if (ingredients_count == 0) {
    $(".sticky-bar").slideUp();

  } else if (ingredients_count == 1) {
    $(".sticky-bar").slideDown();
  }

  updateDisplayIngredients()
}

function btn_click(event) {
  if (clicked_ingredients.length >= 2) {
    const link = `/recipes?ingredients=${clicked_ingredients.join('+')}`;
    window.location = link;
  }
}

function setEventListener() {
  const checkboxes = document.querySelectorAll("#category-circle input");

  checkboxes.forEach(function(checkbox) {
    checkbox.addEventListener("click", checkbox_click);
  });

  const btn = document.getElementById("find-recipies");
  btn.addEventListener("click", btn_click);

  // prevents popover close on popover click
  $('.dropdown-menu').click(function(e) {
    e.stopPropagation();
  });
};


function initIngredients() {
  const data_ = document.getElementById('ingredients_data');

  if (data_) {
    positionIngredients(data_);
    setEventListener();
  }
};

export { initIngredients };
