$(document).ready(function() {


    $('#data-agendamento').change(function()
    {   
        var data_agendamento = $(this).val();
        var codigo_medico = document.getElementById('codigo_medico');
        console.log($(this).val());
    $.ajax({
        data: { 
            data_agendamento: data_agendamento,
            codigo_medico: codigo_medico.value
        },
        type: "post",
        url: "../../model/lista_horarios_disponiveis_para_consulta.php",
        success: function(data){
            $('#mostra_horarios').html(data);
        }
    });
    }); 
});