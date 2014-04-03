jQuery(document).ready(function ($) {

  $('#submit_promo_code').on('click', function() {
    var form = createTempFormForPromoCode("promo_code_form");
    form.submit();
  });

  $('.form_showpass').on('click',function() {
    var input = $('#user_old_password');
    if ($(this).hasClass('active')) {
      input.attr('type','password');
    } else {
      input.attr('type','text');
    }
    $(this).toggleClass('active');
  });

  $('.tabs__title').click(function(){
    $(this).siblings().removeClass('selected').end().next('dd').andSelf().addClass('selected');
  });

  $('#i_will_come_to_stachka').change(function() {
    if (this.checked) {
      $.ajax({
        url: $(this).data('url'),
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        type: "PUT"
      });
    } else {
      this.checked = true;
    }
  });


  $('#order_form input[type="checkbox"]').change(function() {
    var sum = $('#two_days').is(':checked') ? parseInt($('#ticket_price_score').text()) : 0;
    sum += $('#afterparty').is(':checked') ? parseInt($('#afterparty_score').text()) : 0;
    if (sum > 0) {
      $('#submit_order').attr("disabled", false);
    } else {
      $('#submit_order').attr("disabled", true);
    }
    $('#total_score').text(sum);
  });


  function createTempFormForPromoCode(id) {
    var form = document.getElementById(id);
    var temp_form = document.createElement("form");
    temp_form.acceptCharset = "UTF-8";
    temp_form.method = 'post';
    temp_form.action = gon.promo_code_action;
    temp_form.style.display = 'none';
    document.getElementsByTagName('body')[0].appendChild(temp_form);
    copyToForm(form, temp_form);
    return temp_form;
  }

  function copyToForm(e,f) {
    for (var i = 0; i<e.childNodes.length; i++) {
      var el = e.childNodes[i];
      var elName = el.nodeName.toLowerCase();
      if (elName=='input' && el.name!='') {
        var type = el.type.toLowerCase();
        switch (type) {
        case 'text': {
          var tmp_el = document.createElement("input");
          tmp_el.name=el.name;
          tmp_el.type='hidden';
          tmp_el.value=el.value;
          f.appendChild(tmp_el);
          break;
        }
        case 'checkbox': {
          if (el.checked) {
            var tmp_el = document.createElement("input");
            tmp_el.name=el.name;
            tmp_el.type='checkbox';
            tmp_el.value=el.value;
            f.appendChild(tmp_el);
            tmp_el.checked=true;
          }
          break;
        }
        case 'radio': {
          if (el.checked) {
            var tmp_el = document.createElement("input");
            tmp_el.name=el.name;
            tmp_el.type='radio';
            tmp_el.value=el.value;
            f.appendChild(tmp_el);
            tmp_el.checked=true;
          }
          break;
        }
        case 'hidden': {
          var tmp_el = document.createElement("input");
          tmp_el.name=el.name;
          tmp_el.type='hidden';
          tmp_el.value=el.value;
          f.appendChild(tmp_el);
          break;
        }
        case 'password': {
          var tmp_el = document.createElement("input");
          tmp_el.name=el.name;
          tmp_el.type='hidden';
          tmp_el.value=el.value;
          f.appendChild(tmp_el);
          break;
        }
        default: {
          break;
        }
        }
      }
      else if (elName=='textarea' && el.name!='') {
        var tmp_el = document.createElement("textarea");
        tmp_el.name=el.name;
        tmp_el.value=el.value;
        f.appendChild(tmp_el);
      }
      else if (elName=='select' && el.name!='') {
        var tmp_el = document.createElement("input");
        tmp_el.name=el.name;
        tmp_el.type='hidden';
        tmp_el.value=el.value;
        f.appendChild(tmp_el);
      }
      else {
        copyToForm(el,f);
      }
    }
  }
  $(window.location.hash).addClass("selected");
  $(window.location.hash + "_title").addClass("selected");
});
