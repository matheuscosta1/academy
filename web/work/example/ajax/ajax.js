$(document).on('click','#btn-add',function(e) {
    var data = $("#user_form").serialize();
    $.ajax({
        data: data,
        type: "post",
        url: "model/save.php",
        success: function(dataResult){
                var dataResult = JSON.parse(dataResult);
                if(dataResult.statusCode==200){
                    $('#addEmployeeModal').modal('hide');
                    alert('Data added successfully !'); 
                    location.reload();						
                }
                else if(dataResult.statusCode==201){
                   alert(dataResult);
                }
        }
    });
});
$(document).on('click','.update',function(e) {
    var codigo=$(this).attr("data-codigo");
    var nome=$(this).attr("data-nome");
    var email=$(this).attr("data-email");
    var telefone=$(this).attr("data-telefone");
    var cep=$(this).attr("data-cep");
    var logradouro=$(this).attr("data-logradouro");
    var bairro=$(this).attr("data-bairro");
    var cidade=$(this).attr("data-cidade");
    var estado=$(this).attr("data-estado");
    $('#codigo_u').val(codigo);
    $('#nome_u').val(nome);
    $('#email_u').val(email);
    $('#telefone_u').val(telefone);
    $('#cep_u').val(cep);
    $('#logradouro_u').val(logradouro);
    $('#bairro_u').val(bairro);
    $('#cidade_u').val(cidade);
    $('#estado_u').val(estado);
});


$(document).on('click','#update',function(e) {
    var data = $("#update_form").serialize();
    $.ajax({
        data: data,
        type: "post",
        url: "model/save.php",
        success: function(dataResult){
                var dataResult = JSON.parse(dataResult);
                if(dataResult.statusCode==200){
                    $('#editEmployeeModal').modal('hide');
                    alert('Data updated successfully !'); 
                    location.reload();						
                }
                else if(dataResult.statusCode==201){
                   alert(dataResult);
                }
        }
    });
});
$(document).on("click", ".delete", function() { 
    var codigo=$(this).attr("data-codigo");
    $('#codigo_d').val(codigo);
    
});
$(document).on("click", "#delete", function() { 
    $.ajax({
        url: "model/save.php",
        type: "POST",
        cache: false,
        data:{
            type:3,
            codigo: $("#codigo_d").val()
        },
        success: function(dataResult){
                $('#deleteEmployeeModal').modal('hide');
                $("#"+dataResult).remove();
        
        }
    });
});
$(document).on("click", "#delete_multiple", function() {
    var user = [];
    $(".user_checkbox:checked").each(function() {
        user.push($(this).data('user-id'));
    });
    if(user.length <=0) {
        alert("Please select records."); 
    } 
    else { 
        WRN_PROFILE_DELETE = "Are you sure you want to delete "+(user.length>1?"these":"this")+" row?";
        var checked = confirm(WRN_PROFILE_DELETE);
        if(checked == true) {
            var selected_values = user.join(",");
            console.log(selected_values);
            $.ajax({
                type: "POST",
                url: "model/save.php",
                cache:false,
                data:{
                    type: 4,						
                    codigo : selected_values
                },
                success: function(response) {
                    var ids = response.split(",");
                    for (var i=0; i < ids.length; i++ ) {	
                        $("#"+ids[i]).remove(); 
                    }	
                } 
            }); 
        }  
    } 
});
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
    var checkbox = $('table tbody input[type="checkbox"]');
    $("#selectAll").click(function(){
        if(this.checked){
            checkbox.each(function(){
                this.checked = true;                        
            });
        } else{
            checkbox.each(function(){
                this.checked = false;                        
            });
        } 
    });
    checkbox.click(function(){
        if(!this.checked){
            $("#selectAll").prop("checked", false);
        }
    });
});