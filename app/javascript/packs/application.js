import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from "../components/init_mapbox";
initMapbox();

import { initPopover } from "../components/init_popover.js";
initPopover();

import initHighlight  from "../components/init_select.js";
initHighlight()

import { initUpdateNavbarOnScroll } from '../components/init_navbar.js';
initUpdateNavbarOnScroll();


