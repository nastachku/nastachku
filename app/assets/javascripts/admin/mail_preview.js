var $subject = $("#subject");
var $subject_preview = $("#subject_preview");
var $begin_of_greetings_preview = $("#begin_of_greetings_preview");
var $begin_of_greetings = $("#begin_of_greetings");
var $end_of_greetings_preview = $("#end_of_greetings_preview");
var $end_of_greetings = $("#end_of_greetings");
var $mail_content_preview = $("#mail_content_preview");
var $mail_content = $("#mail_content");
var $before_link_preview = $("#before_link_preview");
var $before_link = $("#before_link");
var $after_link_preview = $("#after_link_preview");
var $after_link = $("#after_link");
var $goodbye_preview = $("#goodbye_preview");
var $goodbye = $("#goodbye");

function databind($el, $depEl) {
  $el.change(function(){
    $depEl.html($el.val())
  });
}

databind($subject, $subject_preview);
databind($begin_of_greetings, $begin_of_greetings_preview);
databind($end_of_greetings, $end_of_greetings_preview);
databind($mail_content, $mail_content_preview);
databind($before_link, $before_link_preview);
databind($after_link, $after_link_preview);
databind($goodbye, $goodbye_preview);
