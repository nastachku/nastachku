
$(document).ready(function(){
    $('#to_win').on('click', function(){
        if($('#block_t').is(':visible'))
        {
            $('#block_t').slideUp(1000);
        }
        else{

            $('#block_t').slideDown(1000);
        }
    });
    $('#chekbox input[type=radio]').on('click', function(){
        $('#chekbox span').removeClass('check');
        $(this).parent('span').addClass('check');
    });

    var params = {
        changedEl: "#my_select",
        visRows: 5
    }
    cuSel(params);

/* $('.count_arr_up').on('click',function(){
     var count =  $(this).parent().parent().children().children().val();
     console.log(parseInt(count) + 1);
 });*/
});
 function countUp(){

 console.log($(this).attr('class'));
 }
 function countDown(id){
 var count =  $(this).parent().parent().children().children().val();
 //    var count =  $(this).closest('.count_inp input').text();
 //    console.log($(this).parent().parent().html());
 console.log(count - 1);
 }