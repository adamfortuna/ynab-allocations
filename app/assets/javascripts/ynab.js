$(function() {
  var dragableAreas;
  makeThingsDraggable();

  function makeThingsDraggable() {
    try { dragableAreas.destroy(); } catch(e) { }
    var areas = $.map($(".categories, .budget--area"), function(c) { return c; });
    dragableAreas = dragula(areas).on('drop', function (el) {
      var allocationCategory = $(el).closest('ul')
      if(allocationCategory.hasClass('allocation-categories')) {
        rebalance(allocationCategory);
      }
    });
  }

  function rebalance(category) {
    var total = 0;
    $.each(category.find(".budget--amount"), function(i, amount) {
      total += +$(amount).attr("data-amount");
    });
    var totalId = category.attr("data-total-id");
    $(totalId).html("$" + total);
  }

  function newAlocationCategory(name) {
    var uid = parseInt(Math.random() * 100000),
        contentId = "new-allocation-category-"+uid,
        headerId = "header-allocation-category-"+uid,
        totalId = "total-allocation-category-"+uid,
        dropArea = contentId+'-area';
    var template = [
      "<div class='card mb-1'>",
      "  <div class='card-header m-0 p-0' id='"+headerId+"'>",
      "    <h5 class='d-inline m-0'>",
      "      <button class='btn btn-link' type='button' data-toggle='collapse' data-target='#"+contentId+"' aria-expanded='true' aria-controls='#"+contentId+"'>"+name+"</button>",
      "    </h5>",
      "    <span id='"+totalId+"' class='badge badge-success badge-pill float-right m-2'>$0.00</span>",
      "  </div>",
      "  <div class='collapse show' id='"+contentId+"' aria-labelledby='"+headerId+"'>",
      "    <ul class='m-2 card-body collapse show allocation-categories budget--area' data-total-id='#"+totalId+"' id='"+dropArea+"'>",
      "    </ul>",
      "  </div>",
      "</div>"
    ].join("");

    return template;
  }
  $('.allocation-category--add').on('click', function(e) {
    e.preventDefault();
    var newCategoryName = $("#new_allocation_category").val();
    $("#new_allocation_category").val("");
    if(newCategoryName.length > 0) {
      $('#allocation').prepend(newAlocationCategory(newCategoryName))
      makeThingsDraggable();
    }
  });
})
