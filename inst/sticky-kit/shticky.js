var el,
    positions = {};

Shiny.addCustomMessageHandler('shtick', function(opts) {
  el = document.getElementById(opts.id);
  shtick(el, opts);
});

Shiny.addCustomMessageHandler('unshtick', function(opts) {
  el = document.getElementById(opts.id);
  unshtick(el, opts.id);
});


function shtick(el, opts){
  positions[opts.id] = el.style;
  el.style.position = "fixed";

  if(opts.options.left)
    el.style.left = opts.options.left;

  if(opts.options.right)
    el.style.right = opts.options.right;

  if(opts.options.top)
    el.style.top = opts.options.top;

  if(opts.options.bottom)
    el.style.bottom = opts.options.bottom;
}

function unshtick(el, id){
  el.style = positions[id];
}