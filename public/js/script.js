$(function(){
	

	
	/*if((new Date()) > ts){
		// Задаем точку отсчета для примера. Пусть будет очередной Новый год или дата через 10 дней.
		// Обратите внимание на *1000 в конце - время должно задаваться в миллисекундах
		ts = (new Date()).getTime() + 10*24*60*60*1000;
		newYear = false;
	}*/
		
	/*$('#countdown').countdown({
		timestamp	: ts,
		callback	: function(days, hours, minutes, seconds){
			
			var message = "";
			
			message += "Дней: " + days +", ";
			message += "часов: " + hours + ", ";
			message += "минут: " + minutes + " и ";
			message += "секунд: " + seconds + " <br />";
			
			if(newYear){
				message += "осталось до Нового года!";
			}
			else {
				message += "осталось до момента через 10 дней!";
			}
			
			note.html(message);
		}
	});*/



    $('#pravila_recepts_nav li').on('click', function () {
        $('#pravila_recepts_nav li').removeClass('active');
        $(this).addClass('active');
        $('#pravila, #recepts').hide();
        $('#' + $(this).attr('data-text-id')).fadeIn(500);
        if ($('#recepts').is(':visible')) {
            $('#rec_navi').fadeIn(500);
        }
        else {
            $('#rec_navi').hide();
        }

    });

    /*function displayTime() {
     var str = "";
     */
    var ts = new Date(2014, 01, 07, 23, 59, 59);
    setInterval(function(){
        var currentTime = new Date(),
            time = currentTime.getTime(),
            days = currentTime.getDate(),
            hours = currentTime.getHours(),
            minutes = currentTime.getMinutes(),
            seconds = currentTime.getSeconds(),

            finTime = ts.getTime(),
            finDay = ts.getDate(),
            finHour = ts.getHours(),
            finMin = ts.getMinutes(),
            finSec = ts.getSeconds(),

            lastDay = -(finDay - days),
            lastHour = (finHour - hours),
            lastMin = (finMin - minutes),
            lastSec = (finSec - seconds);
/*
console.log(finTime);
            lastDay =  days - finDay,
            lastHour = hours - finHour,
            lastMin = minutes - finMin,
            lastSec = seconds - finSec;
*/

        $('#timer_count').attr('data-time', time);
        $('#timer_count').attr('my_time', ts.getTime());
        $('#timer_count').attr('fin_time', finTime);
        $('#timer_count > li').eq(0).children('span.my_time').text(lastDay);
        $('#timer_count > li').eq(1).children('span.my_time').text(lastHour);
        $('#timer_count > li').eq(2).children('span.my_time').text(lastMin);
        $('#timer_count > li').eq(3).children('span.my_time').text(lastSec);
    }, 1000);

});
