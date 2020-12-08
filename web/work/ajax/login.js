$(document).on('click','#btn-add',function(e) {
    var data = $("#user_form").serialize();
    $.ajax({
        data: data,
        type: "post",
        url: "../../model/login.php",
        success: function(data){
            if(data == 1){
                $('#login').modal('hide');
                window.location.href='../private/index.php';					
            }
            else if (data == 0){
                $('#login').modal('hide');
                alert('Error!'); 
                location.reload();						
            }
                
        }
    });
});