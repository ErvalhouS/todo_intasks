// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
function debounce(func, wait, immediate) {
	var timeout;
	return function() {
		var context = this, args = arguments;
		var later = function() {
			timeout = null;
			if (!immediate) func.apply(context, args);
		};
		var callNow = immediate && !timeout;
		clearTimeout(timeout);
		timeout = setTimeout(later, wait);
		if (callNow) func.apply(context, args);
	};
}

function intialize() {
  $(".submitter").unbind();
  $(".submitter").on("click", function (el) {
    $($(el.currentTarget).data("submit")).submit();
    return false;
  });
  $(".category-li").unbind();
  $(".category-li").on("click", debounce(function (el) {
    console.log('cliked');
    $("#task_list").html('<div class="spinner-grow" role="status"><span class="sr-only">Loading...</span></div>');
    $.getScript("/tasks.js?task[category_id]=" + $(el.currentTarget).data("id"));
    return false;
  }, 300));
  $(".keyup-submitter").unbind();
  $(".keyup-submitter").keyup(debounce(function(el){
      $($(el.currentTarget).data("submit")).submit();
  }, 1000));
  $(".change-submitter").unbind();
  $(".change-submitter").on("change", debounce(function(el){
      $($(el.currentTarget).data("submit")).submit();
  }, 1000));
}

(function ($) {
  "use strict"; // Start of use strict

  intialize();

})(jQuery);
