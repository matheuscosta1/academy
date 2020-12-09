$(document).ready(function() {

    $('#especialidade').change(function()
    {
        var especialidade_name = $(this).val();
        console.log($(this).val());
    $.ajax({
        data: { especialidade_name:especialidade_name },
        type: "post",
        url: "../../model/lista_medicos_por_especialidade.php",
        success: function(data){
            $('#mostra_medicos').html(data);
        }
    });
    });
});