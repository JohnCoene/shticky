Shiny.addCustomMessageHandler('shtick', function(opts) {
  console.log("SHTICK");
  $(opts.selector).stick_in_parent(opts.options)
    .on("sticky_kit:stick", function(e) {
      Shiny.onInputChange("shtuck", e.target);
    })
    .on("sticky_kit:unstick", function(e) {
      Shiny.onInputChange("unshtuck", e.target);
    });
});

Shiny.addCustomMessageHandler('unshtick', function(opts) {
  $(opts.selector).trigger("sticky_kit:detach");
});
