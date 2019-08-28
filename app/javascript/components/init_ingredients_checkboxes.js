function positionIngredients(data_) {
  const ingredients_data = JSON.parse(data_.dataset.markers);

  var radians, radius;
  radius = 250;

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
    inhalt += "</span> <span class=\"caret\"></button>";
    inhalt += "<h5>"+ item_data.title +"</h5>"
    inhalt += "<ul class=\"dropdown-menu\">";

    ingredients.forEach(function(ingredient) {
      inhalt += "<li><a class=\"small\" data-value=\"option1\" tabIndex=\"-1\"><input type=\"checkbox\"/>"+ ingredient +"</a></li>";
    });
    inhalt += "</ul>";

    x = Math.round(width + radius * Math.cos(angle) - itemW/2) - 80;
    y = Math.round(height + radius * Math.sin(angle) - itemH/2) - 80;

    $('#category-circle').append('<div id="'+ item +'">'+ inhalt +'<div/>')
    $('div#'+item).css('position', 'absolute')
      .css('width', 100+'px').css('height', 100+'px')
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

  if (clicked_ingredients.includes(ingredient)) {
    clicked_ingredients.pop(clicked_ingredients.indexOf(ingredient));
  } else {
    clicked_ingredients.push(ingredient);
  }
}

function btn_click(event) {
  const link = `/recipes?ingredients=${clicked_ingredients.join('+')}`;
  console.log(link);
  window.location = link;
}

function setEventListener() {
  const checkboxes = document.querySelectorAll("#category-circle input");
  console.log(checkboxes);
  checkboxes.forEach(function(checkbox) {
    checkbox.addEventListener("click", checkbox_click);
  });

  const btn = document.getElementById("find-recipies");
  btn.addEventListener("click", btn_click);
};


function initIngredients() {
  const data_ = document.getElementById('ingredients_data');

  if (data_) {
    positionIngredients(data_);
    setEventListener();
  }
}

export { initIngredients };
