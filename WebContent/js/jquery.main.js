$(function(){
    //original field values
    var field_values = {
            //id        :  value
            'username'  : 'username',
            'password'  : 'password',
            'cpassword' : 'password',
            'firstname'  : 'first name',
            'lastname'  : 'last name',
            'email'  : 'email address'
    };


    //inputfocus
    //$('input#txtcompid').inputfocus({ value: field_values['Code'] });
    //$('input#password').inputfocus({ value: field_values['password'] });
    //$('input#cpassword').inputfocus({ value: field_values['cpassword'] }); 
    //$('input#lastname').inputfocus({ value: field_values['lastname'] });
    //$('input#firstname').inputfocus({ value: field_values['firstname'] });
    //$('input#email').inputfocus({ value: field_values['email'] }); 




    //reset progress bar
    $('#progress').css('width','0');
    $('#progress_text').html('0% Complete');

    //first_step
    $('form').submit(function(){ return false; });
    $('#submit_first').click(function(){
        //remove classes
        $('#first_step input').removeClass('error').removeClass('valid');

        //ckeck if inputs aren't empty
        var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        /*var fields = $('#first_step input[type=text], #first_step input[type=password], #first_step input[type=email]');*/
        var fields = $('#first_step input[type=text]');
        var error = 0;
        fields.each(function(){
            var value = $(this).val();
            /*if( value.length<1 || value==field_values[$(this).attr('id')] ) {*/
            if( value.length<1 || value==field_values[$(this).attr('id')] || ( $(this).attr('id')=='txtemail' && !emailPattern.test(value) ) ) {
                $(this).addClass('error');
                $(this).effect("shake", { times:3 }, 50);
                
                error++;
            } else {
                $(this).addClass('valid');
            }
        });        
        
        if(!error) {
            if( $('#password').val() != $('#cpassword').val() ) {
                    $('#first_step input[type=password]').each(function(){
                        $(this).removeClass('valid').addClass('error');
                        $(this).effect("shake", { times:3 }, 50);
                    });
                    
                    return false;
            } else {   
                //update progress bar
                $('#progress_text').html('33% Complete');
                $('#progress').css('width','113px');
                
              //prepare the fourth step
                var fields = new Array(
                	$('#txtcompid').val() + ' - ' + $('#txtcompname').val()
                );
                var tr = $('#second_step tr');
                tr.each(function(){
                    //alert( fields[$(this).index()] )
                    $(this).children('td:nth-child(3)').html(fields[$(this).index()]);
                });
                
                //slide steps
                $('#first_step').slideUp();
                $('#second_step').slideDown();     
            }               
        } else return false;
    });


    $('#submit_second').click(function(){
        //remove classes
        $('#second_step input').removeClass('error').removeClass('valid');

        var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;  
        var fields = $('#second_step input[type=text]');
        var error = 0;
        fields.each(function(){
            var value = $(this).val();
            /*if( value.length<1 || value==field_values[$(this).attr('id')] ) {*/
            if( value.length<1 || value==field_values[$(this).attr('id')] || ( $(this).attr('id')=='txtbranchemail' && !emailPattern.test(value) ) ) {
                $(this).addClass('error');
                $(this).effect("shake", { times:3 }, 50);
                
                error++;
            } else {
                $(this).addClass('valid');
            }
        });

        if(!error) {
                //update progress bar
                $('#progress_text').html('66% Complete');
                $('#progress').css('width','226px');
                
                //prepare the fourth step
                var fields = new Array(
                	$('#txtcompid').val() + ' - ' + $('#txtcompname').val(),
                	$('#txtbranchid').val() + ' - ' + $('#txtbranchname').val()
                );
                var tr = $('#third_step tr');
                tr.each(function(){
                    //alert( fields[$(this).index()] )
                    $(this).children('td:nth-child(3)').html(fields[$(this).index()]);
                });
                
                //slide steps
                $('#second_step').slideUp();
                $('#third_step').slideDown();     
        } else return false;

    });


    $('#submit_third').click(function(){
    	
    	$('#third_step input').removeClass('error').removeClass('valid');

        //ckeck if inputs aren't empty
        var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        /*var fields = $('#first_step input[type=text], #first_step input[type=password], #first_step input[type=email]');*/
        var fields = $('#third_step input[type=text]');
        var error = 0;
        fields.each(function(){
            var value = $(this).val();
            /*if( value.length<1 || value==field_values[$(this).attr('id')] ) {*/
            if( value.length<1 || value==field_values[$(this).attr('id')] || ( $(this).attr('id')=='txtuseremail' && !emailPattern.test(value) ) ) {
                $(this).addClass('error');
                $(this).effect("shake", { times:3 }, 50);
                
                error++;
            } else {
                $(this).addClass('valid');
            }
        });        
        
        if(!error) {
            if( $('#txtuserpassword').val() != $('#txtuserpasswordconfirm').val() ) {
                    $('#third_step input[type=password]').each(function(){
                        $(this).removeClass('valid').addClass('error');
                        $(this).effect("shake", { times:3 }, 50);
                    });
                    
                    return false;
            } else {   
            	//update progress bar
                $('#progress_text').html('100% Complete');
                $('#progress').css('width','339px');
                
              //prepare the fourth step
                var fields = new Array(
                	$('#txtcompid').val() + ' - ' + $('#txtcompname').val(),
                	$('#txtaddress').val(),
                	$('#txtproduct').val(),
                	$('#txtbranchid').val() + ' - ' + $('#txtbranchname').val(),
                	$('#txtbranchaddress').val(),
                	$('#txtuserid').val(),
                    $('#txtusername').val(),
                    $('#txtuseremail').val()                       
                );
                var tr = $('#fourth_step tr');
                tr.each(function(){
                    //alert( fields[$(this).index()] )
                    $(this).children('td:nth-child(3)').html(fields[$(this).index()]);
                });
                        
                //slide steps
                $('#third_step').slideUp();
                $('#fourth_step').slideDown();     
            }               
        } else return false;
    });


    $('#submit_fourth').click(function(){
        //send information to server
       // alert('Successfully Registered');
    	
    	document.getElementById("frmRegister").submit();
    	
    });

});