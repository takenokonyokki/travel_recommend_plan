// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import '@fortawesome/fontawesome-free/js/all'
import "../stylesheets/application"
window.$ = window.jQuery = require('jquery')
import "../stylesheets/signup"
import "../stylesheets/login"
import "../stylesheets/index"
import "../stylesheets/newplan"
import "../stylesheets/newcontent"
import "../stylesheets/showplan"
import "../stylesheets/top"
import "../stylesheets/mypage"
import "rate.js"

Rails.start()
// Turbolinks.start()
ActiveStorage.start()