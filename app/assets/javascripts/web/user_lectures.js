jQuery(document).ready(function ($) {
  $('.custom_select').fancySelect({
    legacyEvents: true,
    optionTemplate: function(optionEl) {
      return '<span class="before_select_option" style="background-image: url(\'' + optionEl.data('icon') + '\');"></span><span class="select_option">' + optionEl.text() + '</span>';
    }
  });

  $('#filter_user_lectures_by_workshop option[value=' + $.url().param("workshop_id_eq") + ']').prop('selected', true).trigger('change');

  $('#filter_user_lectures_by_workshop').on('change.fs', function(){
    $.ajax({
      url: Routes.user_lectures_path(),
      type: "GET",
      dataType: "script",
      data: {
        q: {
          workshop_id_eq: $('#filter_user_lectures_by_workshop option:selected').val()
        }
      },
      success: function() {
        startShare42();
        window.history.pushState('string', 'Доклады 2.0', Routes.user_lectures_path() + "?q[workshop_id_eq]=" + $('#filter_user_lectures_by_workshop option:selected').val());
      }
    })
  });

  $('#lectures').on('click', '.sorting a', function() {
    $.getScript(this.href,  function( data, textStatus, jqxhr ) {
      startShare42();
    });
    return false;
  });

  $(document).on('click', '.voting_button:not(".added")', function(){
    var self = this;
    $.ajax({
      url: Routes.api_lecture_lecture_votings_path($(this).data('id')),
      type: "POST",
      dataType: "json",
      success: function() {
        var $votings_count = $(self).siblings('.lecture_voting_count');
        $votings_count.html(parseInt($votings_count.html(), 10) + 1);
        $(self).html('Убрать');
        $(self).addClass("added");
        $(self).siblings(".lecture_added").show();
      }
    })
  });

  $(document).on('click', '.voting_button.added', function() {
    var self = this;
    $.ajax({
      url: Routes.api_lecture_lecture_votings_path($(this).data('id')),
      type: "DELETE",
      dataType: "json",
      success: function() {
        var $votings_count = $(self).siblings('.lecture_voting_count');
        $votings_count.html(parseInt($votings_count.html(), 10) - 1);
        $(self).html('Я пойду на доклад');
        $(self).removeClass("added");
        $(self).siblings('.lecture_added').hide();
      }
     })
   });

   function setResultForFeedback() {
     $('.feedback_result').each(function(index, el) {
       var res = parseInt($(el).data('average-result'));
       if(res) {
         changeAverageFeedback(res, $(el).closest('.lectures__item_feedback'));
       }
     })
   };

   function changeAverageFeedback(vote, $lecture) {
     var $current = $lecture.find('.feedback_button_' + Math.round(vote));
     $lecture.find('.feedback_result').html(vote);
     $current.addClass('voted');
     $current.prevAll().addClass('voted')
     $current.nextAll().removeClass('voted')
   };

   setResultForFeedback();

   $(document).on('mouseover', '.feedback_button', function() {
     var $this = $(this);
     $this.addClass('hover');
     $this.prevAll().addClass('hover');
     $this.nextAll().removeClass('hover');
   });

   $(document).on('mouseout', '.lectures__item__adding', function() {
     $(this).find('.feedback_button').removeClass('hover');
   });

   $(document).on('click', '.feedback_button', function() {
     var vote = $(this).data('value');
     var lecture_id = $(this).closest('.lectures__item').data('id');
     var $parent = $(this).parent();
     $.ajax({
       url: Routes.api_lecture_feedbacks_path(lecture_id),
       data: {
         vote: vote
       },
       type: "POST",
       dataType: "json",
       success: function(result) {
         $parent.find('.feedback_no_vote_text').hide();
         $parent.find('.feedback_text').show();
         changeAverageFeedback(result.average_feedback_vote, $parent);
         $parent.find('.feedback_success').fadeIn(500);
         setTimeout(function() { $parent.find('.feedback_success').fadeOut(500); }, 2000);
       }
     })
   });
});
