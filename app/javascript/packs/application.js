import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from "../components/init_mapbox";
initMapbox();

import { initIngredients } from "../components/init_ingredients_checkboxes";
initIngredients();

import { initHighlight } from "../components/init_select.js";
initHighlight()

import { initUpdateNavbarOnScroll } from '../components/init_navbar.js';
initUpdateNavbarOnScroll();

import { initCheckboxSearches } from '../components/init_checkbox_searchbar';
initCheckboxSearches();
