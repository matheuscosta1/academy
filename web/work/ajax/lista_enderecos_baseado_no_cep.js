$(document).ready(function() {

    $('#cep').change(function()
    {
        var cep = $(this).val();
    $.ajax({
        data: { cep:cep },
        type: "post",
        url: "../../model/lista_enderecos_baseado_no_cep.php",
        dataType:'JSON',
        success: function(data){
            console.log(data.cep);
            $('#logradouro').val(data.logradouro);
            $('#bairro').val(data.bairro);
            $('#cidade').val(data.cidade);
            $('#estado').val(data.estado);
        }
    });
    });
});