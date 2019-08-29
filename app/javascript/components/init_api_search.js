const results = document.querySelector("#results");

fetch(`https://www.food2fork.com/api/search?key=${RECIPE_API_KEY}&q=${results}` )
  .then(response => response.json())
  .then((data) => {
    data.Search.forEach((result) => {
      console.log(result);
    });
  });
