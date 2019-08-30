import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from "../components/init_mapbox";
initMapbox();

import { initPopover } from "../components/init_popover.js";
initPopover();

import { initIngredients } from "../components/init_ingredients_checkboxes";
initIngredients();

import { initDisplay } from "../components/init_select.js";
initDisplay();

import { initUpdateNavbarOnScroll } from '../components/init_navbar.js';
initUpdateNavbarOnScroll();






