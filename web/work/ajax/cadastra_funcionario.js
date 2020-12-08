$(document).on('click','#btn-add',function(e) {
    var data = $("#user_form").serialize();
    $.ajax({
        data: data,
        type: "post",
        url: "../../model/cadastra_funcionario.php",
        success: function(dataResult){
                var dataResult = JSON.parse(dataResult);
                if(dataResult == 1){
                    $('#addEmployeeModal').modal('hide');
                    alert('Funcionário cadastrado com sucesso!'); 
                    location.reload();						
                }
                
        }
    });
});