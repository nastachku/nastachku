//= require hamlcoffee
function render_lectures(lectures) {
  //+ Jonas Raoni Soares Silva
  //@ http://jsfromhell.com/array/shuffle [v1.0]
  function shuffle(o, count){ //v1.0
    if (count) {
      var temp_arr = [];
      var count = count > o.length ? o.lenght : count;
      for(var j, i = o.length - 1; i >= 0 && count > 0; i--, count--) {
        j = Math.floor(Math.random() * i);
        temp_arr.push(o[j]);
        o.splice(j, 1);
      }
      return temp_arr;
    } else {
      for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    }
    return o;
  };

  var lecturesView = JST['welcome/lectures'];
  var four_shuffle_lectures = shuffle(lectures, 4);
  var html = lecturesView({four_lectures: four_shuffle_lectures});
  $("#lectures").html(html);
}
