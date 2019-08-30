# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Cleaning databases...'
Request.destroy_all
RecipeIngredient.destroy_all
UserIngredient.destroy_all
Recipe.destroy_all
Ingredient.destroy_all
User.destroy_all

puts 'Creating user...'

users = [{
  email: "test1@example.com",
  first_name: "test1",
  last_name: "example",
  password: "123456",
  image: "https://images.unsplash.com/photo-1556911220-dabc1f02913a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80",
  address: "Berlin, Checkpoint Charlie"
}, {
  email: "test2@example.com",
  first_name: "test2",
  last_name: "example",
  password: "123456",
  image: "https://images.unsplash.com/photo-1556911220-e15b29be8c8f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80" ,
  address: "Berlin, Alexanderplatz"
},{
  email: "test3@example.com",
  first_name: "test3",
  last_name: "example",
  password: "123456",
  image: "https://images.unsplash.com/photo-1556911220-e15b29be8c8f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80" ,
  address: "Berlin, Rosenthalerplatz"
}]

users.each { |user| User.new(user).save! }

puts 'Creating recipes...'

recipes = [ {
    name: "Spanish tortilla",
    description: "A Spanish classic",
    category: "Spanish" ,
    method: "Peel the potatoes using a speed-peeler, then carefully cut them into thin slices. Pat the potato slices dry with a clean tea towel.
Peel and finely slice the onion. Drizzle 2 tablespoons of oil into a small frying pan over a medium heat, then add the onion and potatoes.
Turn the heat down to low and cook for 25 to 30 minutes, or until the onions are turning golden and the potato slices are cooked through. Try not to stir it too much or the potatoes will break up – just use a fish slice to flip them over halfway through.
Crack the eggs into a mixing bowl, season with a tiny pinch of sea salt and black pepper, then whisk together with a fork.
When the onions and potatoes are cooked, remove the pan from the heat and carefully tip them into the eggs. Transfer the mixture back into the frying pan and place it over a low heat. Cook for around 20 minutes, or until there’s almost no runny egg on top.
Use a fish slice to slightly lift and loosen the sides of the tortilla. Carefully flip the pan over a dinner plate and tip out the tortilla, then slide it back into the pan and cook for another 5 minutes, or until golden and cooked through.
Turn out the tortilla onto a serving board, then cut into 6 wedges and serve hot or cold with a simple green salad. ",
    image: "https://img.jamieoliver.com/jamieoliver/recipe-database/xtra_med/46260004.jpg?tr=w-430"
  },{
    name: "Mexican baked eggs",
    description: "With zincy fresh lime" ,
    category: "Mexican" ,
    method:  "Preheat the oven to full whack.
Grease a small skillet pan or round baking dish with a drizzle of olive oil, then crack in the eggs.
Finely slice the red chilli (deseed if you like) and scatter over the eggs.
Peel and destone the avocado, then slice. Halve the lime and squeeze over the juice of one half.
Arrange the avocado around the eggs, and season with a little sea salt and black pepper.
Place in the oven for 7 to 10 minutes, or until the whites are set but the yolks are still runny.
Pick and roughly chop a few coriander leaves and sprinkle over the eggs, then cut the remaining lime half into wedges for squeezing over. Delicious served with hot buttered toast.",
    image: "https://img.jamieoliver.com/jamieoliver/recipe-database/xtra_med/90303516.jpg?tr=w-430"
  },{
    name: "Avocado on rye toast with ricotta",
    description: "Tomato, fresh basil & toasted pine nuts" ,
    category: "Vegetarian" ,
    method:  "Spread the ricotta cheese over the rye bread or toast.
Finely slice the avocado and tomato, then toss with a squeeze of lemon juice.
Season to taste and arrange on the toast.
Sprinkle over the pine nuts and a few fresh baby basil leaves, if you’ve got them.",
    image: "https://img.jamieoliver.com/jamieoliver/recipe-database/xtra_med/46264954.jpg?tr=w-430"
  }]
recipes.each { |recipe| Recipe.new(recipe).save! }


puts 'Creating ingredients...'

VEGETABLES = %w(onion garlic tomato potato carrot bell pepper basil parsley broccoli corn spinach mushroom green beans ginger chili pepper celery rosemary salad greens red onion cucumber sweet potato pickle avocado zucchini cilantro frozen vegetables olive asparagus cabbage cauliflower dill kale mixed vegetable pumpkin squash mint scallion sun dried tomato shallot eggplant beet butternut squash horseradish leek caper brussels sprout artichoke heart chia seeds radish sauerkraut artichoke portobello mushroom sweet pepper arugula spaghetti squash capsicum bok choy parsnip okra yam fennel turnip snow peas bean sprouts seaweed chard collard canned tomato pimiento watercress tomatillo rocket mustard greens bamboo shoot rutabaga endive broccoli rabe jicama kohlrabi hearts of palm butternut celery root daikon radicchio porcini chinese broccoli jerusalem artichoke cress water chestnut dulse micro greens burdock chayote)
DAIRY = %w(butter egg milk parmesan cheddar american cheese sour cream cream cheese mozzarella yogurt cream evaporated milk whipped cream feta monterey jack cheese condensed milk cottage cheese ice cream swiss cheese velveeta frosting buttermilk ricotta goat cheese provolone blue cheese powdered milk colby cheese pepper jack italian cheese soft cheese gouda pepperjack cheese romano brie pizza cheese ghee creme fraiche cheese soup gruyere pecorino cheese custard muenster queso fresco cheese hard cheese havarti cheese asiago mascarpone neufchatel halloumi paneer brick cheese camembert cheese goat milk garlic herb cheese edam cheese manchego fontina stilton cheese emmenthaler cheese red leicester cheese jarlsberg cheese bocconcini cheese farmer cheese creme de cassis wensleydale cheese longhorn cheese double gloucester cheese raclette cheese lancashire cheese cheshire cheese)
FRUITS = %w(lemon apple banana lime strawberry orange pineapple blueberry raisin coconut grape peach raspberry cranberry mango pear blackberry cherry date watermelon berries kiwi grapefruit mandarin craisins cantaloupe plum apricot clementine prunes apple butter pomegranate nectarine fig tangerine papaya rhubarb sultanas plantain currant passion fruit guava persimmons lychee lingonberry tangelos kumquat boysenberry star fruit quince honeydew crabapples)
BAKING_GRAINS = %w(rice pasta flour bread baking powder baking soda bread crumbs cornstarch rolled oats noodle flour tortillas pancake mix yeast cracker quinoa brown rice cornmeal self rising flour cake mix saltines popcorn macaroni cheese mix corn tortillas ramen cereal biscuits stuffing mix couscous pie crust bisquick chips angel hair coconut flake bread flour croutons lasagne pizza dough bagel puff pastry hot dog bun barley multigrain bread potato flakes pretzel cornbread english muffin cornflour crescent roll dough cream of wheat coconut flour pita risotto muffin mix bicarbonate of soda ravioli wheat rice flour polenta baguette gnocchi vermicelli semolina wheat germ buckwheat croissants bread dough filo dough yeast flake pierogi matzo meal rye tapioca flour shortcrust pastry potato starch breadsticks ciabatta spelt angel food tapioca starch starch whole wheat flour gram flour sourdough starter wafer bran challah sponge cake malt extract sorghum flour)
ADDED_SWEETENERS = %w(sugar brown sugar honey confectioners sugar maple syrup corn syrup molasses artificial sweetener agave nectar)
SPICES = %w(cinnamon vanilla garlic powder paprika oregano chili powder red pepper flake cumin cayenne italian seasoning thyme onion powder nutmeg ground nutmeg curry powder bay leaf taco seasoning sage clove allspice turmeric chive peppercorn ground coriander cajun seasoning coriander celery salt vanilla essence herbs steak seasoning poultry seasoning chile powder cardamom italian herbs tarragon garam masala marjoram mustard seed celery seed chinese five spice italian spice saffron onion flake herbes de provence chipotle dill seed fennel seed caraway cacao star anise savory chili paste tamarind aniseed fenugreek lavender old bay seasoning lemon balm)
MEATS = %w(chicken breast ground beef bacon sausage beef steak ham hot dog pork chops chicken thighs ground turkey cooked chicken turkey pork pepperoni whole chicken chicken leg ground pork chorizo chicken wings beef roast polish sausage salami pork roast ground chicken pork ribs spam venison pork shoulder bologna bratwurst prosciutto lamb corned beef chicken roast lamb chops pancetta ground lamb beef ribs duck pork belly beef liver leg of lamb canadian bacon beef shank veal chicken giblets cornish hen lamb shoulder lamb shank deer ground veal pastrami rabbit sliced turkey pork loin elk beef suet veal cutlet lamb loin marrow bones goose chicken tenders veal chops quail oxtail pheasant lamb liver moose turkey liver pork liver veal shank foie gras beef sirloin liver sausage sweetbread wild boar snail pigeon duck liver goose liver grouse ostrich soppressata alligator)
FISH = %w(canned tuna salmon tilapia fish fillets cod canned salmon anchovy smoked salmon sardines tuna steak whitefish halibut trout haddock flounder catfish mahi mahi mackerel sole sea bass red snapper swordfish pollock herring perch grouper caviar monkfish rockfish lemon sole pike barramundi eel bluefish carp cuttlefish pompano arctic char john dory marlin amberjack sturgeon)
SEAFOOD = %w(shrimp crab prawns scallop clam lobster mussel oyster squid calamari crawfish octopus cockle conch sea urchin)
CONDIMENTS = %w(mayonnaise ketchup mustard vinegar soy sauce balsamic vinegar worcestershire hot sauce barbecue sauce ranch dressing wine vinegar apple cider vinegar cider vinegar italian dressing rice vinegar salad dressing tabasco fish sauce teriyaki steak sauce tahini enchilada sauce vinaigrette dressing oyster sauce honey mustard sriracha caesar dressing taco sauce mirin blue cheese dressing sweet sour sauce thousand island picante sauce buffalo sauce french dressing tartar sauce cocktail sauce marsala adobo sauce tzatziki sauce sesame dressing ponzu duck sauce pickapeppa sauce yuzu juice cream sauce)
OILS = %w(olive oil vegetable oil cooking spray canola oil shortening sesame oil coconut oil peanut oil sunflower oil lard grape seed oil corn oil almond oil avocado oil safflower oil walnut oil hazelnut oil palm oil soybean oil mustard oil pistachio oil soya oil)
SEASONINGS = %w(bouillon ground ginger sesame seed cream of tartar chili sauce soya sauce apple cider hoisin sauce liquid smoke rice wine vegetable bouillon poppy seed balsamic glaze miso wasabi fish stock rose water pickling salt champagne vinegar bbq rub jamaican jerk spice accent seasoning pickling spice mustard powder mango powder adobo seasoning kasuri methi caribbean jerk seasoning brine matcha powder cassia)
SAUCES = %w(tomato sauce tomato paste salsa pesto alfredo sauce beef gravy curry paste chicken gravy cranberry sauce turkey gravy mushroom gravy sausage gravy onion gravy cream gravy pork gravy tomato gravy giblet gravy)
LEGUMENS = %w(green beans peas black beans chickpea lentil refried beans hummus chili beans lima beans kidney beans pinto beans edamame split peas snap peas soybeans cannellini beans navy beans french beans red beans great northern beans fava beans)
SOUP = %w(chicken broth mushroom soup beef broth tomato soup vegetable stock chicken soup onion soup vegetable soup celery soup dashi lamb stock pork stock veal stock)
NUTS = %w(peanut butter almond walnut pecan peanut cashew flax pine nut pistachio almond meal hazelnut macadamia almond paste chestnut praline macaroon)
INGREDIENT_TYPES = [
  { title: "added sweetener", ingredients: ADDED_SWEETENERS },
  { title: "vegetable", ingredients: VEGETABLES },
  { title: "dairy", ingredients: DAIRY },
  { title: "fruit", ingredients: FRUITS },
  { title: "spice", ingredients: SPICES },
  { title: "seafood", ingredients: SEAFOOD },
  { title: "meat", ingredients: MEATS },
  { title: "condiment", ingredients: CONDIMENTS },
  { title: "baking & grain", ingredients: BAKING_GRAINS },
  { title: "fish", ingredients: FISH },
  { title: "oil", ingredients: OILS },
  { title: "seasoning", ingredients: SEASONINGS },
  { title: "sauce", ingredients: SAUCES },
  { title: "legume", ingredients: LEGUMENS },
  { title: "soup", ingredients: SOUP },
  { title: "nut", ingredients: NUTS }
]

INGREDIENT_TYPES.each do |t|

  t[:ingredients].each do |i|
    ingredient = Ingredient.new(
      name: i,
      unit: "grammes",
      category: t[:title]
    )
  ingredient.save
  end
end

ingredients = [{
  name: "waxy potatoes",
  unit: "grammes",
  category: "vegetable"
}, {
#   name: "lemon",
#   category: "vegetable"
# }, {
  name: "rye bread",
  unit: "75g slice",
  category: "vegetable"
},{
  name: "pine nuts",
  unit: "teaspoon",
  category: "vegetable"
# }, {
# name: "tomato",
# category: "vegetable"
# }, {
#   name: "lime",
#   category: "vegetable"
# }, {
#  name: "avocado",
#  category: "vegetable"
}, {
  name: "red chilli",
  category: "vegetable"
# }, {
#  name: "onion",
#  category: "vegetable"
}, {
  name: "eggs",
  category: "vegetable"
}, {
  name: "pussy",
  category: "meat"
}
]

ingredients.each { |ingredient| Ingredient.new(ingredient).save! }


puts 'Creating recipes...'

recipe_ingredients = [{
  recipe_id: Recipe.where(name: "Spanish tortilla").first.id,
  quantity: 300,
  ingredient_id: Ingredient.where(name: "waxy potatoes").first.id
}, {
  recipe_id: Recipe.where(name: "Spanish tortilla").first.id,
  quantity: 1,
  ingredient_id: Ingredient.where(name: "onion").first.id
}, {
  recipe_id: Recipe.where(name: "Spanish tortilla").first.id,
  quantity: 5,
  ingredient_id: Ingredient.where(name:"eggs").first.id
},{
  recipe_id: Recipe.where(name: "Mexican baked eggs").first.id,
  quantity: 4,
  ingredient_id: Ingredient.where(name: "eggs").first.id
},{
  recipe_id: Recipe.where(name: "Mexican baked eggs").first.id,
  quantity: 1,
  ingredient_id: Ingredient.where(name: "red chilli").first.id
},{
  recipe_id: Recipe.where(name: "Mexican baked eggs").first.id,
  quantity: 1,
  ingredient_id: Ingredient.where(name: "avocado").first.id
},{
  recipe_id: Recipe.where(name: "Mexican baked eggs").first.id,
  quantity: 1,
  ingredient_id: Ingredient.where(name: "lime").first.id
},
]

recipe_ingredients.each { |recipe_ingredient| RecipeIngredient.new(recipe_ingredient).save! }

user_ingredients = [{
  user_id: User.where(email: "test1@example.com").first.id,
  ingredient_id: Ingredient.where(name: "lime").first.id,
  quantity: 1
},{
  user_id: User.where(email: "test1@example.com").first.id,
  ingredient_id: Ingredient.where(name: "avocado").first.id,
  quantity: 1
}, {
  user_id: User.where(email: "test1@example.com").first.id,
  ingredient_id: Ingredient.where(name: "eggs").first.id,
  quantity: 3
}, {
  user_id: User.where(email: "test2@example.com").first.id,
  ingredient_id: Ingredient.where(name: "eggs").first.id,
  quantity: 4
}, {
  user_id: User.where(email: "test3@example.com").first.id,
  ingredient_id: Ingredient.where(name: "red chilli").first.id,
  quantity: 4
}
]

user_ingredients.each { |user_ingredient| UserIngredient.new(user_ingredient).save! }


puts 'create requests'


requests = [{
  recipe_id: Recipe.where(name: "Spanish tortilla").first.id,
  user_id: User.where(email: "test1@example.com").first.id,
  host: false
}, {
  recipe_id: Recipe.where(name: "Spanish tortilla").first.id,
  user_id: User.where(email: "test2@example.com").first.id,
  host: false
}]
requests.each { |request| Request.new(request).save!}

puts 'Finished!'
