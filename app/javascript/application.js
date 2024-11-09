// This file is automatically compiled by the asset pipeline, along with any other files
// present in this directory. You're free to add application-wide JavaScript to this file
// using the JavaScript code in this file.

//= require rails-ujs
//= require activestorage
//= require_tree .

// Your custom JavaScript code can go below this line
import "@hotwired/turbo-rails"
import "./controllers" // Stimulusコントローラのインポート
import Rails from '@rails/ujs';
Rails.start();
