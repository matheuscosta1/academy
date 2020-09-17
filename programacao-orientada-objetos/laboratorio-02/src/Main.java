package br.ufu.facom.lsa.GeradorDeCookbooks;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.time.FastDateFormat;

import br.facom.ufu.lsa.GeradorDeCookbooks.FiltrosParaCookbook.Filtros;
import br.ufu.facom.RanqueamentoDePares.ProduzArquivosParaParaLearningToRank;
import br.ufu.facom.lsa.BD.ConexaoDB;
import br.ufu.facom.lsa.BD.ConsultasBD;
import br.ufu.facom.lsa.ExtratorDeCaracteristicasDosPosts.DadosRatingCategoria;
import br.ufu.facom.lsa.Lda.DocTopicPair;
import br.ufu.facom.lsa.Lda.GerenciadorDeLDA;

public class Main {

    public final static void main(String[] args) {
        graphicDataGenerate();
        geraCookbook();
    }

    public final static void graphicDataGenerate() {
        try {

            List<String[]> apiNameList = new ArrayList<String[]>();
            List<Integer> listaNroDeParesPorApi = new ArrayList<Integer>();
            List<Integer> listaCodigoDasRodadas = new ArrayList<Integer>();

            List<Integer> listaKLda = new ArrayList<Integer>();
            List<Integer> listaThresholdParaRanqueamentoApi = new ArrayList<Integer>();

//			inicializaDadosApis(apiNameList, listaNroDeParesPorApi, listaCodigoDasRodadas, listaKLda,
//					listaThresholdParaRanqueamentoApi);
            inicializaDadosApisManual(apiNameList, listaNroDeParesPorApi, listaCodigoDasRodadas, listaKLda,
                    listaThresholdParaRanqueamentoApi);

            String strParametros = "";

            // Variavel que indica como aplicaremos o LDA
            // tipoDeAplicacaoDoLDA = 1 -> todas as threads how-to da api entrarao no LDA
            // tipoDeAplicacaoDoLDA = 2 -> apenas threads que possuem pares no top 30%
            // entrarao no LDA
            // tipoDeAplicacaoDoLDA = 3 -> apenas threads que possuem pares no top
            // menor(0.1*nroDeParesDaApi, 300)
            int tipoDeAplicacaoDoLDA = 1;

            /// Variaveis referentes aos filtros
            FilterUsage filterUsage = new FilterUsage(strParametros).invoke();
            strParametros = filterUsage.getStrParametros();
            boolean usaFiltroDeCodigoNaResposta = filterUsage.isUsaFiltroDeCodigoNaResposta();
            boolean usaFiltroDeTamanhoDaPergunta = filterUsage.isUsaFiltroDeTamanhoDaPergunta();
            boolean usaFiltroDeLinkMortos = filterUsage.isUsaFiltroDeLinkMortos();

            // Variavel que indica o tipo de ranqueamento que utilizaremos para selecionar
            // os pares para o cookbooks
            // tipoDeRanqueamento = 1 -> ranqueamento feito pelo ranklib
            // tipoDeRanqueamento = 2 -> ranqueamento original (groud through)
            int tipoDeRanqueamento = 2;
            strParametros += "tipoDeRanqueamento: " + tipoDeRanqueamento + "\n";

            // Variavel que indica:
            // os top-k pares do ranquemanto que serao considerados para o cookbook
            // (tipoDeSelecaoDePares=1)
            // ou os x% melhores (tipoDeSelecaoDePares=2)
            // ou o threshold para selecao de pares (tipoDeSelecaoDePares=3)
            // double topParesInfo = 10;
            // strParametros += "topParesInfo: " + topParesInfo + "\n";
            int posicaoMaximaASerConsiderada = 0;

            // Variavel que indica o nroMaximo de pares de uma mesma thread que poderao ser
            // considerados para serem incluidos no cookbook (Integer.maxvalue = sem limite)
            // TODO mudando isso para 1
            int limiteDeParesPorThread = 1;
            strParametros += "limiteDeParesPorThread: " + limiteDeParesPorThread + "\n";

            // Variaveis referentes ao LDA
            // Caminho do sistema de arquivos onde iremos armazenar os arquivos gerados a
            // partir dos posts
            String caminho = "/Users/marcmaia/workspaces/data/cookbooks/lda_data";
            strParametros += "caminho: " + caminho + "\n";
            // Variavel booleana para indicar se os trechos de codigo-fonte serao
            // considerados na construcao dos arquivos
            Boolean consideraCodigo = false;
            strParametros += "consideraCodigo: " + consideraCodigo + "\n";
            // Variavel booleana para indicar se serao consideradas apenas as threads com
            // resposta aceita
            Boolean consideraApenasComRespostaAceita = false;
            strParametros += "consideraApenasComRespostaAceita: " + consideraApenasComRespostaAceita + "\n";
            // Variavel para indicar a estrategia que adotaremos para construcao dos
            // arquivos (possui um dos valores de constantes definidas na classe)
            int tipoArquivo = GerenciadorDeLDA.COMPLETE_THREAD;
            strParametros += "tipoArquivo: " + tipoArquivo + "\n";
            // Variavel booleana para indicar se o titulo da pergunta sera considerado na
            // construcao dos arquivos
            Boolean consideraTitulo = true;
            strParametros += "consideraTitulo: " + consideraTitulo + "\n";
            // Variavel booleana para indicar se serao considerados bi-grans
            // se for true, os tokens finais produzidos serao tanto bigrans como unigrans
            Boolean usaBigrans = true;
            strParametros += "usaBigrans: " + usaBigrans + "\n";
            // Variavel inteira que indica se iremos aplicar o LDA usando o
            // pre-processamento convensional(1), usando chuncking(2) ou pegando apenas os
            // nouns(3)
            // se for true, usaremos o pre-processamento convensional de texto
            int tipoDeProcessamento = 1;
            strParametros += "tipoDeProcessamento: " + tipoDeProcessamento + "\n";
            // Variavel boolena que indica se serao consideradas apeans threads do tipo HOW
            // no LDA
            // se for true, usaremos apenas threads cujo tipo da pergunta eh HOW
            Boolean usaApenasHOw = true;
            strParametros += "usaApenasHOw: " + usaApenasHOw + "\n";
            // Variavel que indica quantas vezes os tokens do titulo serao repetidos no
            // momento de produzir os arquivos para o LDA
            int nroDeRepeticoesDOTitulo = 1;
            strParametros += "nroDeRepeticoesDOTitulo: " + nroDeRepeticoesDOTitulo + "\n";
            // Variavel que contem o caminho do arquivo contendo o resultado da checkagem de
            // links feita no windows
//			String caminhoDoArquivoComLinkTestados = "/home/lucas/Dropbox/dados_dead_links/SO_links_linq_qt_awt_testados.txt";
            String caminhoDoArquivoComLinkTestados = "";
            strParametros += "caminhoDoArquivoComLinkTestados: " + caminhoDoArquivoComLinkTestados + "\n";
            // Variavel que indica o nro de topicos para o LDA (potencial nro de capitulos
            // do cookbook)
            // int nroDeCapitulos = 20;
            // int nroDeCapitulos = 20;
            // strParametros += "nroDeCapitulos: " + nroDeCapitulos + "\n";

            Filtros filtros = new Filtros(caminhoDoArquivoComLinkTestados);
            // map que guardara os scores de todos os posts do SO
            Map<String, Integer> mapScores = new HashMap<String, Integer>();
            ;
            // Inicializa o map com o score de todos os posts do SO. Esse score sera usado
            // para calcular o valor da metrica groud through (media ponderada) para o caso
            // de tipoDeRanqueamento=2
            inicializaMapScores(mapScores, apiNameList); // modificado para buscar apenas 1 API
            System.out.println(mapScores.size());

            // Vamos criar o objeto para conexao com o banco, que sera usado para recuperar
            // o corpo da resposta
            ConexaoDB cbd = new ConexaoDB();
            cbd.conectaAoBD();

            for (int i = 0; i < apiNameList.size(); i++) {

                if (i != 2 /* i!=1 && i!=2 */)
                    continue;

                String srtDaTimeTime = FastDateFormat.getInstance("yyyy-MM-dd HH:mm")
                        .format(System.currentTimeMillis());

                String strParametrosApi = "**************************************\n" + strParametros;

                /*
                 * if(tipoDeSelecaoDePares == 3 && tipoDeRanqueamento != 2){
                 * System.out.println("Configuracao invalida."); System.exit(0); }
                 */

                // calcula a posicao maxima que poderá ser considerada no ranqueamento da api
                /*
                 * if(tipoDeSelecaoDePares == 1) posicaoMaximaASerConsiderada =
                 * (int)topParesInfo; else if(tipoDeSelecaoDePares == 2)
                 * posicaoMaximaASerConsiderada =
                 * (int)(listaNroDeParesPorApi.get(i)*(topParesInfo/(double)100));
                 */

                // Sobre estabelecer a posição maxima do par no ranking para o mesmo ser
                // considerado, seria:
                // Menor entre 300 e 10% do nro de pares da API
                posicaoMaximaASerConsiderada = 100;
                // TODO comentando isso por enquanto
                // if(0.1*listaNroDeParesPorApi.get(i) < posicaoMaximaASerConsiderada)
                // posicaoMaximaASerConsiderada = (int)(0.1*listaNroDeParesPorApi.get(i));

                strParametrosApi += "posicaoMaximaASerConsiderada: " + posicaoMaximaASerConsiderada + "\n";

                // Sobre estabelecer o nro de capitulos, seria
                // Menor entre 20 e 15% da posicao maxima a ser considerada
                // TODO descomentar isso
                /*
                 * int nroDeCapitulos = 20; if(0.15*posicaoMaximaASerConsiderada < 20)
                 * nroDeCapitulos = (int)(0.15*posicaoMaximaASerConsiderada); strParametrosApi
                 * += "nroDeCapitulos: " + nroDeCapitulos + "\n";
                 */
                // int vetNumTopicos[] = {10, 15, 20, 25, 30, 35, 40, 45, 50};
                int vetNumTopicos[] = { 20 };
                for (int y = 0; y < vetNumTopicos.length; y++) {
                    // Lista com todos os pares de how-tos da api, para fazer o ranking pelo score
                    // combinado (media do par E percentual do topico dominante da thread)
                    List<Receita> listaPares = new ArrayList<Receita>();

                    // variaveis para aba "nro de threads >= X"
                    int countNroDeThreadsBemDefinida50 = 0;
                    int countNroDeThreadsBemDefinida60 = 0;
                    int countNroDeThreadsBemDefinida70 = 0;
                    int countNroDeThreadsBemDefinida80 = 0;
                    int countNroDeThreadsBemDefinida90 = 0;
                    int nroDeCapitulos = vetNumTopicos[y];
                    String nroDeCapStr = "nroDeCapitulos: " + nroDeCapitulos + "\n";

                    String nomeAPIs = "";
                    String vetAPIs[] = apiNameList.get(i);
                    for (int j = 0; j < vetAPIs.length; j++) {
                        nomeAPIs += vetAPIs[j];
                        if (j != vetAPIs.length - 1) {
                            nomeAPIs += "_";
                        }
                    }

                    // Cria a pasta onde serao armazenadas os arquivos que participarao do LDA
                    // String nomePasta = caminho + "/" + nomeAPIs + "_" + (consideraCodigo ? "1":
                    // "0") + "_" + tipoArquivo + "_" + (consideraApenasComRespostaAceita ? "1":
                    // "0") + "_" + (usaPreProcessamentoConvensional ? "1": "0");
                    String nomePasta = caminho + "/" + nomeAPIs;
                    File f = new File(nomePasta);
                    f.mkdir();

                    f = new File(nomePasta + "/" + srtDaTimeTime);
                    f.mkdir();

                    // Cria um arquivo que contem os valores dos varios parametros
                    PrintWriter outFileParametros = new PrintWriter(new BufferedWriter(
                            new FileWriter(nomePasta + "/" + srtDaTimeTime + "/parametros.txt", true)));
                    outFileParametros.print(strParametrosApi);
                    outFileParametros.print(nroDeCapStr);
                    outFileParametros.flush();

                    // Vamos montar o map com as informacoes da posicao dos pares no ranqueamento
                    // feito usando a RankLib ou o ranqueamento pelo score (ground through)
                    // <idPergunta, <dadoRanquemanto d melhor par que passou nos filtros de tamanho,
                    // dead links and code>>
                    Map<String, DadoRanqueamento> mapDadosRanking = new HashMap<String, DadoRanqueamento>();
                    // Monta o map com as informacoes de ranqueamento de cada um dos pares (ate o
                    // momento este map tem todos os pares how-to da API)
                    montaMapComDadosDoRanqueamento(mapDadosRanking, nomeAPIs, listaCodigoDasRodadas.get(i), mapScores,
                            tipoDeRanqueamento, cbd, usaFiltroDeCodigoNaResposta, usaFiltroDeTamanhoDaPergunta,
                            usaFiltroDeLinkMortos, filtros, outFileParametros);
                    // Vamos preencher a lista listaDadosRanqueamento com os pares do map
                    // mapDadosRanking (o melhor par da thread que passou nos filtros)
                    List<DadoRanqueamento> listaDadosRanqueamento = new ArrayList<DadoRanqueamento>(
                            mapDadosRanking.values());

                    System.out.println("listaDadosRanqueamento.size(): " + listaDadosRanqueamento.size());
                    outFileParametros.print("listaDadosRanqueamento.size(): " + listaDadosRanqueamento.size());
                    outFileParametros.flush();

                    // Vamos criar o camparator de acordo com o tipo de ranqueametno considerado
                    // (1:score produzido pelo ranklib; 2:score ground through)
                    Comparator comp = null;
                    if (tipoDeRanqueamento == 1)
                        comp = new ComparatorScoreDoRanqueamento();
                    else if (tipoDeRanqueamento == 2)
                        comp = new ComparatorScoreGroundThrough();

                    Collections.sort(listaDadosRanqueamento, comp);
                    determinaPosticoesNoRank(listaDadosRanqueamento);

                    // *******************************************************************************/
                    // aba "ranqueamento score do par"
                    // Agora vamos ordenar a lista ade pares em ordem descrecent do valor do score
                    // do par

                    String ranqueamentoPorScoreDoParStr = "Ranqueamento por Score do Par\n";

                    for (int q = 0; q < listaDadosRanqueamento.size(); q++) {
                        DadoRanqueamento dr = listaDadosRanqueamento.get(q);
                        ranqueamentoPorScoreDoParStr += dr.getScoreGoundThrough() + ",";
                    }

                    outFileParametros.println(ranqueamentoPorScoreDoParStr);
                    outFileParametros.flush();

                    // *******************************************************************************/

                    f = new File(nomePasta + "/" + srtDaTimeTime);
                    f.mkdir();

                    // metodo responsavel por produzir os arquivos referentes aos posts
                    // Verifica os pares que estão aptos a participarem do lda.
                    // Ex.: se tipoDeAplicacaoDoLDA = 1, todas as threads entrarao no lda
                    // Ex.: se tipoDeAplicacaoDoLDA = 2, verifica os pares que estão no top 30% do
                    // ranking e as threads desses pares entrarao no lda

                    //modificado
                    //GerenciadorDeLDA.produzArquivosPosts(vetAPIs, tipoArquivo, consideraTitulo, consideraCodigo,
                    //					nomePasta, consideraApenasComRespostaAceita, tipoDeProcessamento, usaApenasHOw,
                    //					tipoDeAplicacaoDoLDA, listaDadosRanqueamento, listaNroDeParesPorApi.get(i),
                    //					outFileParametros, nroDeRepeticoesDOTitulo);

                    // outFileLinksTestados.close();

                    // Depois de gerados os arquivos, iremos aplicar o LDA
                    // alpha: um bom valor heuristicamente conhecido eh 50/numTopicos, por isso
                    // passa 50 como alpha
                    // beta: um bom valor utilizado eh 0.01
                    // iteracoes: geralmente utilizadas de 1000-2000
                    // <idDaThread, idDoTopicoDominanteNaThread>
                    Map<String, List<DocTopicPair>> mapDocumentoTopicos = new HashMap<String, List<DocTopicPair>>();
                    // <idDoTopico, topTermsDoTopico>
                    Map<String, String> mapTopicoTopTerms = new HashMap<String, String>();

                    // Map que guarda para cada topico, a lista de documentos, ordenados de forma
                    // decrescente pelo percentual
                    Map<String, List<DocTopicPair>> mapTopicoDocumentos = new HashMap<String, List<DocTopicPair>>();

                    // Tirado por ser incompativel com nova versao
                    // GerenciadorDeLDA.aplicaLDA(ldaConfig, nroDeCapitulos, 50.0, 0.01, 2000, usaBigrans,
                    // mapDocumentoTopicos, mapTopicoDocumentos, mapTopicoTopTerms, srtDaTimeTime);

                    // Vamos imprimir para o percentual medio dentre os topicos, das threads que
                    // estao nas varias posicoes (aba "threshold para nro de capitulos")
                    String mediasDosPercentuaiPorPosicaoStr = "Media Dos Percentuais Por Posicao\n";

                    int posicaoMaximaAVerificar = 200;
                    for (int posicaoAVerificar = 0; posicaoAVerificar < posicaoMaximaAVerificar; posicaoAVerificar++) {
                        double somaPercentuaisDaPosicao = 0;

                        for (int s = 0; s < nroDeCapitulos; s++) {
                            List<DocTopicPair> listaDeDocumentos = mapTopicoDocumentos.get(s + "");
                            somaPercentuaisDaPosicao += listaDeDocumentos.get(posicaoAVerificar).getPercent();
                        }

                        double mediaPercentuaisDaPosicao = somaPercentuaisDaPosicao / nroDeCapitulos;
                        mediasDosPercentuaiPorPosicaoStr += "posicaoAVerificar = " + posicaoAVerificar + " "
                                + mediaPercentuaisDaPosicao + "\n";
                    }

                    outFileParametros.println(mediasDosPercentuaiPorPosicaoStr);

                    // Map que ira guardar para cada capitulo, as receitas selecionadas para
                    // constituirem o cookbook;
                    // <idDoCapitulo, List<Receita>>
                    Map<String, List<Receita>> cookbook = new HashMap<String, List<Receita>>();
                    inicializaCookbook(cookbook, nroDeCapitulos);

                    int nroDeParesDescartadosPorNaoTeremRankSuficiente = 0;

                    int nroTotalDeParesVerificados = 0;
                    // Vamos verificar para cada thread, se existem alguns pares bem colocados no
                    // ranking e ao mesmo tempo ir montando o cookbook
                    outFileParametros.println("Nro de threads participantes do LDA = mapDocumentoTopicos.size() "
                            + mapDocumentoTopicos.size());
                    Iterator it = mapDocumentoTopicos.entrySet().iterator();
                    while (it.hasNext()) {
                        Map.Entry pairs = (Map.Entry) it.next();
                        String idDaThread = (String) pairs.getKey();
                        // System.out.println(idDaThread);

                        // String idDoTopicoDominante = (String)pairs.getValue();
                        String idDoTopicoDominante = ((DocTopicPair) (((List<DocTopicPair>) pairs.getValue()).get(0)))
                                .getTopicId() + "";
                        double percentDoTopicoDominante = ((DocTopicPair) (((List<DocTopicPair>) pairs.getValue())
                                .get(0))).getPercent();

                        if (percentDoTopicoDominante >= 0.5)
                            countNroDeThreadsBemDefinida50++;
                        if (percentDoTopicoDominante >= 0.6)
                            countNroDeThreadsBemDefinida60++;
                        if (percentDoTopicoDominante >= 0.7)
                            countNroDeThreadsBemDefinida70++;
                        if (percentDoTopicoDominante >= 0.8)
                            countNroDeThreadsBemDefinida80++;
                        if (percentDoTopicoDominante >= 0.9)
                            countNroDeThreadsBemDefinida90++;

                        if (mapDadosRanking.containsKey(idDaThread)) {
                            DadoRanqueamento dr = mapDadosRanking.get(idDaThread);
                            String idDaResposta = dr.getIdResposta();
                            int posicaoNoRanking = dr.getPosicaoNoRank();

                            if (posicaoNoRanking <= posicaoMaximaASerConsiderada) {
                                List<Receita> listaDeReceitas = cookbook.get(idDoTopicoDominante);
                                Receita receita = constroiReceita(Integer.parseInt(idDaThread),
                                        Integer.parseInt(idDaResposta), posicaoNoRanking, dr.getScoreGoundThrough(),
                                        percentDoTopicoDominante);
                                listaDeReceitas.add(receita);
                            }
                        }
                    }

                    printPares(outFileParametros, nroTotalDeParesVerificados, countNroDeThreadsBemDefinida50, countNroDeThreadsBemDefinida60, countNroDeThreadsBemDefinida70, countNroDeThreadsBemDefinida80, nroDeParesDescartadosPorNaoTeremRankSuficiente, "nroDeParesDescartadosPorNaoTeremRankSuficiente: ", "nroTotalDeParesVerificados: ", "countNroDeThreadsBemDefinida50: ", "countNroDeThreadsBemDefinida60: ", "countNroDeThreadsBemDefinida70: ", "countNroDeThreadsBemDefinida80: ");
                    outFileParametros.println("countNroDeThreadsBemDefinida90: " + countNroDeThreadsBemDefinida90);

                    System.out.println("countNroDeThreadsBemDefinida50: " + countNroDeThreadsBemDefinida50);
                    System.out.println("countNroDeThreadsBemDefinida60: " + countNroDeThreadsBemDefinida60);
                    System.out.println("countNroDeThreadsBemDefinida70: " + countNroDeThreadsBemDefinida70);
                    System.out.println("countNroDeThreadsBemDefinida80: " + countNroDeThreadsBemDefinida80);
                    System.out.println("countNroDeThreadsBemDefinida90: " + countNroDeThreadsBemDefinida90);

                    // Depois de construido o cookbook vamos verificar qual eh a aderencia
                    // (percentual) das receitas com seus respectivos capitulos
                    int nroTotalDeReceitas = 0;
                    it = cookbook.entrySet().iterator();
                    while (it.hasNext()) {
                        Map.Entry pairs = (Map.Entry) it.next();
                        List<Receita> listaReceitas = (List<Receita>) pairs.getValue();
                        String topicoId = (String) pairs.getKey();

                        outFileParametros.println("topicId = " + topicoId);
                        for (int j = 0; j < listaReceitas.size(); j++) {
                            nroTotalDeReceitas++;
                            Receita r = listaReceitas.get(j);
                            // System.out.println(r.getIdPergunta() + "-" + r.getIdResposta() + "-pos " +
                            // r.getPosicaoNoRank());
                            outFileParametros.println(r.getIdPergunta() + "-" + r.getIdResposta() + "\t"
                                    + r.getPercentDoTopicoDominanteDaThread() + "\t" + r.getScoreDoPar());
                            outFileParametros.flush();
                        }
                    }
                    System.out.println(
                            "Nro total de receitas (pares selecionados para o cookbook): " + nroTotalDeReceitas);
                    outFileParametros.println("Nro total de receitas: " + nroTotalDeReceitas);
                    outFileParametros.flush();

                    System.out.println("Nro de pares por capitulo");
                    outFileParametros.println("Nro de pares por capitulo");
                    outFileParametros.flush();
                    for (int j = 0; j < nroDeCapitulos; j++) {
                        List<Receita> listaReceitas = cookbook.get(j + "");
                        System.out.println(j + "\t" + listaReceitas.size());
                        outFileParametros.println(j + "\t" + listaReceitas.size());
                        outFileParametros.flush();
                    }

                    System.out.println("Nro de Links por capitulo");
                    outFileParametros.println("Nro de Links por capitulo");
                    outFileParametros.flush();
                    for (int j = 0; j < nroDeCapitulos; j++) {
                        List<Receita> listaReceitas = cookbook.get(j + "");
                        // System.out.println(j + "\t" + listaReceitas.size());
                        List<String> listaIdDePerguntas = new ArrayList<String>();
                        for (int k = 0; k < listaReceitas.size(); k++) {
                            Receita r = listaReceitas.get(k);

                            if (!listaIdDePerguntas.contains(r.getIdPergunta() + "")) {
                                listaIdDePerguntas.add(r.getIdPergunta() + "");
                            }
                        }
                        System.out.println(j + "\t" + listaIdDePerguntas.size());
                        outFileParametros.println(j + "\t" + listaIdDePerguntas.size());
                        outFileParametros.flush();
                    }

                    // Agora vamos inserir as receitas no banco
                    ConexaoDB cbdStackCookbooks = new ConexaoDB();
                    // Conecta ao banco stack_research
                    cbdStackCookbooks.conectaAoBD("stackOfCookBooks");
                    PreparedStatement ps = cbdStackCookbooks.criaPreparedStatement(
                            "insert into recipes(NameApis, NameTopic, TopicId, QuestionId, AnswerId, TitleQuestion, TagsQuestion, BodyQuestion, BodyAnswer, RankingPosition) values(?,?,?,?,?,?,?,?,?,?)");

                    int contadorCapitulo = 0;
                    it = mapTopicoTopTerms.entrySet().iterator();
                    while (it.hasNext()) {
                        contadorCapitulo++;
                        Map.Entry pairs = (Map.Entry) it.next();
                        String idDoTopico = (String) pairs.getKey();
                        String topTermosDoTopico = (String) pairs.getValue();

                        List<Receita> receitas = cookbook.get(idDoTopico);

                        for (int j = 0; j < receitas.size(); j++) {
                            Receita r = receitas.get(j);

                            ps.setString(1, nomeAPIs);
                            ps.setString(2, topTermosDoTopico);
                            ps.setInt(3, Integer.parseInt(idDoTopico));
                            ps.setInt(4, r.getIdPergunta());
                            ps.setInt(5, r.getIdResposta());
                            ps.setString(6, r.getTitulo());
                            ps.setString(7, r.getTags());
                            ps.setString(8, r.getCorpoPergunta().replace("<a href=", "<a target=newtab href="));
                            ps.setString(9, r.getCorpoResposta().replace("<a href=", "<a target=newtab href="));
                            ps.setInt(10, r.getPosicaoNoRank());

                            // TODO descomentar
                            // ps.executeUpdate();
                        }
                        // System.out.println(idDaThread);
                    }
                    cbdStackCookbooks.close();
                    outFileParametros.close();
                }
            }
            cbd.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public final static void geraCookbook() {
        try {

            List<String[]> listaNomeApis = new ArrayList<String[]>();
            List<Integer> listaNroDeParesPorApi = new ArrayList<Integer>();
            List<Integer> listaCodigoDasRodadas = new ArrayList<Integer>();
            List<Integer> listaKLda = new ArrayList<Integer>();
            List<Integer> listaThresholdParaRanqueamentoApi = new ArrayList<Integer>();

//			inicializaDadosApis(listaNomeApis, listaNroDeParesPorApi, listaCodigoDasRodadas, listaKLda,
//					listaThresholdParaRanqueamentoApi);
            inicializaDadosApisManual(listaNomeApis, listaNroDeParesPorApi, listaCodigoDasRodadas, listaKLda,
                    listaThresholdParaRanqueamentoApi);

            String strParametros = "";

            // Variavel que indica como aplicaremos o LDA
            // tipoDeAplicacaoDoLDA = 1 -> todas as threads how-to da api entrarao no LDA
            // tipoDeAplicacaoDoLDA = 2 -> apenas threads que possuem pares no top 30%
            // entrarao no LDA
            // tipoDeAplicacaoDoLDA = 3 -> apenas threads que possuem pares no top
            // menor(0.1*nroDeParesDaApi, 300)
            int tipoDeAplicacaoDoLDA = 1;

            /// Variaveis referentes aos filtros
            boolean usaFiltroDeCodigoNaResposta = true;
            strParametros += "usaFiltroDeCodigoNaResposta: " + usaFiltroDeCodigoNaResposta + "\n";
            boolean usaFiltroDeTamanhoDaPergunta = true;
            strParametros += "usaFiltroDeTamanhoDaPergunta: " + usaFiltroDeTamanhoDaPergunta + "\n";
            boolean usaFiltroDeLinkMortos = true;
            strParametros += "usaFiltroDeLinkMortos: " + usaFiltroDeLinkMortos + "\n";

            // Variavel que indica se serão considerados para cada API a
            // 1 -> valor absoluto, se posicaoMaximaDoParNoRanking = 100, so vai considerar
            // os 100 pares mais bem colocados no ranquamento de cada api
            // 2 -> valor relativo, se posicaoMaximaDoParNoRanking = 10, so vai considerar
            // os 10% pares mais bem colocados no ranquamento de cada api
            // 3 -> o usuario informa um threshold que sera um valor minimo da media
            // ponderada para o par ser considerada para o cookbook. So pode ser usado
            // quando tipoDeRanqueamento=2
            // int tipoDeSelecaoDePares = 2;
            // strParametros += "tipoDeSelecaoDePares: " + tipoDeSelecaoDePares + "\n";

            // Variavel que indica o tipo de ranqueamento que utilizaremos para selecionar
            // os pares para o cookbooks
            // tipoDeRanqueamento = 1 -> ranqueamento feito pelo ranklib
            // tipoDeRanqueamento = 2 -> ranqueamento original (gronud through)
            int tipoDeRanqueamento = 2;
            strParametros += "tipoDeRanqueamento: " + tipoDeRanqueamento + "\n";

            // Variavel que indica:
            // os top-k pares do ranquemanto que serao considerados para o cookbook
            // (tipoDeSelecaoDePares=1)
            // ou os x% melhores (tipoDeSelecaoDePares=2)
            // ou o threshold para selecao de pares (tipoDeSelecaoDePares=3)
            // double topParesInfo = 10;
            // strParametros += "topParesInfo: " + topParesInfo + "\n";
            int posicaoMaximaASerConsiderada = 0;

            // Variavel que indica o nroMaximo de pares de uma mesma thread que poderao ser
            // considerados para serem incluidos no cookbook (Integer.maxvalue = sem limite)
            int limiteDeParesPorThread = 1;
            strParametros += "limiteDeParesPorThread: " + limiteDeParesPorThread + "\n";

            // Variaveis referentes ao LDA
            // Caminho do sistema de arquivos onde iremos armazenar os arquivos gerados a
            // partir dos posts
            String caminho = "/Users/marcmaia/workspaces/data/cookbooks/lda_data";
            strParametros += "caminho: " + caminho + "\n";
            // Variavel booleana para indicar se os trechos de codigo-fonte serao
            // considerados na construcao dos arquivos
            Boolean consideraCodigo = false;
            strParametros += "consideraCodigo: " + consideraCodigo + "\n";
            // Variavel booleana para indicar se serao consideradas apenas as threads com
            // resposta aceita
            Boolean consideraApenasComRespostaAceita = false;
            strParametros += "consideraApenasComRespostaAceita: " + consideraApenasComRespostaAceita + "\n";
            // Variavel para indicar a estrategia que adotaremos para construcao dos
            // arquivos (possui um dos valores de constantes definidas na classe)
            int tipoArquivo = GerenciadorDeLDA.COMPLETE_THREAD;
            strParametros += "tipoArquivo: " + tipoArquivo + "\n";
            // Variavel booleana para indicar se o titulo da pergunta sera considerado na
            // construcao dos arquivos
            Boolean consideraTitulo = true;
            strParametros += "consideraTitulo: " + consideraTitulo + "\n";
            // Variavel booleana para indicar se serao considerados bi-grans
            // se for true, os tokens finais produzidos serao tanto bigrans como unigrans
            Boolean usaBigrans = true;
            strParametros += "usaBigrans: " + usaBigrans + "\n";
            // Variavel inteira que indica se iremos aplicar o LDA usando o
            // pre-processamento convensional(1), usando chuncking(2) ou pegando apenas os
            // nouns(3)
            // se for true, usaremos o pre-processamento convensional de texto
            int tipoDeProcessamento = 1;
            strParametros += "tipoDeProcessamento: " + tipoDeProcessamento + "\n";
            // Variavel boolena que indica se serao consideradas apeans threads do tipo HOW
            // no LDA
            // se for true, usaremos apenas threads cujo tipo da pergunta eh HOW
            Boolean usaApenasHOw = true;
            strParametros += "usaApenasHOw: " + usaApenasHOw + "\n";
            // Variavel que indica quantas vezes os tokens do titulo serao repetidos no
            // momento de produzir os arquivos para o LDA
            int nroDeRepeticoesDOTitulo = 1;
            strParametros += "nroDeRepeticoesDOTitulo: " + nroDeRepeticoesDOTitulo + "\n";
            // Variavel que contem o caminho do arquivo contendo o resultado da checkagem de
            // links feita no windows
//			String caminhoDoArquivoComLinkTestados = "/home/lucas/Dropbox/dados_dead_links/SO_links_linq_qt_awt_testados.txt";
            String caminhoDoArquivoComLinkTestados = "";
            strParametros += "caminhoDoArquivoComLinkTestados: " + caminhoDoArquivoComLinkTestados + "\n";
            // Variavel que indica o percentual (aderencia) minimo que a thread do par deve
            // ter para o mesmo poder ser considerado
            double percentualMinimoLda = 0.51;
            // Variavel que indica o numero de pares minimo requeido para estar num
            // cookbooks
            int numMinimoDePares = 64;
            // Variavel usada para guardar o numero de pares do cookbook atual
            int nroTotalDeReceitas = 0;

            // map que guardara os scores de todos os posts do SO
            Map<String, Integer> mapScores = new HashMap<String, Integer>();
            ;
            // Inicializa o map com o score de todos os posts do SO. Esse score sera usado
            // para calcular o valor da metrica groud through (media ponderada) para o caso
            // de tipoDeRanqueamento=2
            inicializaMapScores(mapScores, listaNomeApis);
            System.out.println(mapScores.size());

            // Vamos criar o objeto para conexao com o banco, que sera usado para recuperar
            // o corpo da resposta
            ConexaoDB cbd = new ConexaoDB();
            cbd.conectaAoBD();

            Filtros filtros = new Filtros(caminhoDoArquivoComLinkTestados);

            Map<String, String> mapTopicoTopTerms = null;
            Map<String, List<Receita>> cookbook = null;
            String nomeAPIs = "";

            for (int i = 0; i < listaNomeApis.size(); i++) {

                if (i != 3)
                    continue;
                nroTotalDeReceitas = 0;
                String srtDaTimeTime = FastDateFormat.getInstance("yyyy-MM-dd HH:mm")
                        .format(System.currentTimeMillis());

                String strParametrosApi = "**************************************\n" + strParametros;

                int nroDeCapitulos = listaKLda.get(i);
                String nroDeCapStr = "nroDeCapitulos: " + nroDeCapitulos + "\n";

                nomeAPIs = "";
                String vetAPIs[] = listaNomeApis.get(i);
                for (int j = 0; j < vetAPIs.length; j++) {
                    nomeAPIs += vetAPIs[j];
                    if (j != vetAPIs.length - 1) {
                        nomeAPIs += "_";
                    }
                }

                // Cria a pasta onde serao armazenadas os arquivos que participarao do LDA
                // String nomePasta = caminho + "/" + nomeAPIs + "_" + (consideraCodigo ? "1":
                // "0") + "_" + tipoArquivo + "_" + (consideraApenasComRespostaAceita ? "1":
                // "0") + "_" + (usaPreProcessamentoConvensional ? "1": "0");
                String nomePasta = caminho + "/" + nomeAPIs;
                File f = new File(nomePasta);
                f.mkdir();

                f = new File(nomePasta + "/" + srtDaTimeTime);
                f.mkdir();

                // Cria um arquivo que contem os valores dos varios parametros
                PrintWriter outFileParametros = new PrintWriter(
                        new BufferedWriter(new FileWriter(nomePasta + "/" + srtDaTimeTime + "/parametros.txt", true)));
                outFileParametros.print(strParametrosApi);
                outFileParametros.print(nroDeCapStr);
                outFileParametros.flush();

                posicaoMaximaASerConsiderada = listaThresholdParaRanqueamentoApi.get(i);

                // Vamos montar o map com as informacoes da posicao dos pares no ranqueamento
                // feito usando a RankLib ou o ranqueamento pelo score (ground through)
                // <idPergunta, <dadoRanquemanto d melhor par que passou nos filtros de tamanho,
                // dead links and code>>
                Map<String, DadoRanqueamento> mapDadosRanking = new HashMap<String, DadoRanqueamento>();
                // Monta o map com as informacoes de ranqueamento de cada um dos pares (ate o
                // momento este map tem todos os pares how-to da API)
                montaMapComDadosDoRanqueamento(mapDadosRanking, nomeAPIs, listaCodigoDasRodadas.get(i), mapScores,
                        tipoDeRanqueamento, cbd, usaFiltroDeCodigoNaResposta, usaFiltroDeTamanhoDaPergunta,
                        usaFiltroDeLinkMortos, filtros, outFileParametros);
                // Vamos preencher a lista listaDadosRanqueamento com os pares do map
                // mapDadosRanking (o melhor par da thread que passou nos filtros)
                List<DadoRanqueamento> listaDadosRanqueamento = new ArrayList<DadoRanqueamento>(
                        mapDadosRanking.values());

                System.out.println("listaDadosRanqueamento.size(): " + listaDadosRanqueamento.size());
                outFileParametros.print("listaDadosRanqueamento.size(): " + listaDadosRanqueamento.size());
                outFileParametros.flush();

                // Criar o camparator de acordo com o tipo de ranqueametno considerado (1:score
                // produzido pelo ranklib; 2:score ground through)
                Comparator comp = null;
                if (tipoDeRanqueamento == 1)
                    comp = new ComparatorScoreDoRanqueamento();
                else if (tipoDeRanqueamento == 2)
                    comp = new ComparatorScoreGroundThrough();

                Collections.sort(listaDadosRanqueamento, comp);
                determinaPosticoesNoRank(listaDadosRanqueamento);

                // metodo responsavel por produzir os arquivos referentes aos posts
                // Verifica os pares que estão aptos a participarem do lda.
                // Ex.: se tipoDeAplicacaoDoLDA = 1, todas as threads entrarao no lda
                // Ex.: se tipoDeAplicacaoDoLDA = 2, verifica os pares que estão no top 30% do
                // ranking e as threads desses pares entrarao no lda

                //modificado
                //GerenciadorDeLDA.produzArquivosPosts(vetAPIs, tipoArquivo, consideraTitulo, consideraCodigo, nomePasta,
                //					consideraApenasComRespostaAceita, tipoDeProcessamento, usaApenasHOw, tipoDeAplicacaoDoLDA,
                //					listaDadosRanqueamento, listaNroDeParesPorApi.get(i), outFileParametros,
                //					nroDeRepeticoesDOTitulo);

                // outFileLinksTestados.close();

                // Depois de gerados os arquivos, iremos aplicar o LDA
                // alpha: um bom valor heuristicamente conhecido eh 50/numTopicos, por isso
                // passa 50 como alpha
                // beta: um bom valor utilizado eh 0.01
                // iteracoes: geralmente utilizadas de 1000-2000
                // <idDaThread, idDoTopicoDominanteNaThread>
                Map<String, List<DocTopicPair>> mapDocumentoTopicos = new HashMap<String, List<DocTopicPair>>();
                // <idDoTopico, topTermsDoTopico>
                mapTopicoTopTerms = new HashMap<String, String>();

                // Map que guarda para cada topico, a lista de documentos, ordenados de forma
                // decrescente pelo percentual
                Map<String, List<DocTopicPair>> mapTopicoDocumentos = new HashMap<String, List<DocTopicPair>>();

                // Tirado por ser incompativel com nova versao
                //			GerenciadorDeLDA.aplicaLDA(nomePasta, nroDeCapitulos, 50.0, 0.01, 2000, usaBigrans, mapDocumentoTopicos,
                //					mapTopicoDocumentos, mapTopicoTopTerms, srtDaTimeTime);

                do {

                    outFileParametros.println("######################### Tentativa posicaoMaximaASerConsiderada = "
                            + posicaoMaximaASerConsiderada + " ####################################");
                    outFileParametros.flush();

                    // Map que ira guardar para cada capitulo, as receitas selecionadas para
                    // constituirem o cookbook;
                    // <idDoCapitulo, List<Receita>>
                    cookbook = new HashMap<String, List<Receita>>();
                    inicializaCookbook(cookbook, nroDeCapitulos);

                    int nroDeParesDescartadosPorNaoTeremRankSuficiente = 0;
                    int nroDeParesDescartadosPorNaoTeremPercentSusficente = 0;

                    int nroTotalDeParesVerificados = 0;
                    // Vamos verificar para cada thread, se existem alguns pares bem colocados no
                    // ranking e ao mesmo tempo ir montando o cookbook
                    outFileParametros.println("Nro de threads participantes do LDA = mapDocumentoTopicos.size() "
                            + mapDocumentoTopicos.size());
                    Iterator it = mapDocumentoTopicos.entrySet().iterator();
                    while (it.hasNext()) {
                        Map.Entry pairs = (Map.Entry) it.next();
                        String idDaThread = (String) pairs.getKey();
                        // System.out.println(idDaThread);

                        // String idDoTopicoDominante = (String)pairs.getValue();
                        String idDoTopicoDominante = ((DocTopicPair) (((List<DocTopicPair>) pairs.getValue()).get(0)))
                                .getTopicId() + "";
                        double percentDoTopicoDominante = ((DocTopicPair) (((List<DocTopicPair>) pairs.getValue())
                                .get(0))).getPercent();

                        // int count = 0;
                        if (mapDadosRanking.containsKey(idDaThread)) {

                            DadoRanqueamento dr = mapDadosRanking.get(idDaThread);
                            String idDaResposta = dr.getIdResposta();
                            int posicaoNoRanking = dr.getPosicaoNoRank();
                            double mediaDoPar = dr.getScoreGoundThrough();

                            if (percentDoTopicoDominante < percentualMinimoLda) {
                                nroDeParesDescartadosPorNaoTeremPercentSusficente++;
                                continue;
                            }

                            if (posicaoNoRanking <= posicaoMaximaASerConsiderada) {
                                List<Receita> listaDeReceitas = cookbook.get(idDoTopicoDominante);
                                Receita receita = constroiReceita(Integer.parseInt(idDaThread),
                                        Integer.parseInt(idDaResposta), posicaoNoRanking, dr.getScoreGoundThrough(),
                                        percentDoTopicoDominante);
                                listaDeReceitas.add(receita);
                            } else
                                nroDeParesDescartadosPorNaoTeremRankSuficiente++;

                        }
                    }

                    // ajustaCookbook(cookbook, mapDocumentoTopicos, mapTopicoTopTerms,
                    // outFileParametros);
                    // Metodo chamado pra excluir os capitulos que ficaram muito pequenos (menos de
                    // 3 receitas)
                    removeCapitulosPequenos(cookbook, outFileParametros);

                    outFileParametros.println("nroDeParesDescartadosPorNaoTeremRankSuficiente: "
                            + nroDeParesDescartadosPorNaoTeremRankSuficiente);
                    outFileParametros.println("nroDeParesDescartadosPorNaoTeremPercentSusficente: "
                            + nroDeParesDescartadosPorNaoTeremPercentSusficente);

                    outFileParametros.println("nroTotalDeParesVerificados: " + nroTotalDeParesVerificados);

                    Map<String, Integer> mapCountReceitasPorCapitulo = new HashMap<String, Integer>();

                    // Depois de construido o cookbook vamos verificar qual eh a similaridade
                    // (percentual) das receitas com seus respectivos capitulos
                    nroTotalDeReceitas = 0;
                    it = cookbook.entrySet().iterator();
                    while (it.hasNext()) {
                        Map.Entry pairs = (Map.Entry) it.next();
                        List<Receita> listaReceitas = (List<Receita>) pairs.getValue();
                        String topicoId = (String) pairs.getKey();

                        outFileParametros.println("topicId = " + topicoId);
                        for (int j = 0; j < listaReceitas.size(); j++) {
                            nroTotalDeReceitas++;
                            Receita r = listaReceitas.get(j);
                            // System.out.println(r.getIdPergunta() + "-" + r.getIdResposta() + "-pos " +
                            // r.getPosicaoNoRank());
                            outFileParametros.println(r.getIdPergunta() + "-" + r.getIdResposta() + "\t"
                                    + r.getPercentDoTopicoDominanteDaThread() + "\t" + r.getScoreDoPar());
                            outFileParametros.flush();
                        }
                    }
                    System.out.println(
                            "Nro total de receitas (pares selecionados para o cookbook): " + nroTotalDeReceitas);
                    outFileParametros.println(
                            "Nro total de receitas (pares selecionados para o cookbook): " + nroTotalDeReceitas);
                    outFileParametros.flush();

                    System.out.println("Nro de pares por capitulo");
                    outFileParametros.println("Nro de pares por capitulo");
                    outFileParametros.flush();
                    for (int j = 0; j < nroDeCapitulos; j++) {
                        if (cookbook.containsKey(j + "")) {
                            List<Receita> listaReceitas = cookbook.get(j + "");
                            System.out.println(j + "\t" + listaReceitas.size());
                            outFileParametros.println(j + "\t" + listaReceitas.size());
                            outFileParametros.flush();
                        }
                    }

                    System.out.println("Nro de Links por capitulo");
                    outFileParametros.println("Nro de Links por capitulo");
                    outFileParametros.flush();
                    for (int j = 0; j < nroDeCapitulos; j++) {
                        if (cookbook.containsKey(j + "")) {
                            List<Receita> listaReceitas = cookbook.get(j + "");
                            // System.out.println(j + "\t" + listaReceitas.size());
                            List<String> listaIdDePerguntas = new ArrayList<String>();

                            for (int k = 0; k < listaReceitas.size(); k++) {
                                Receita r = listaReceitas.get(k);

                                if (!listaIdDePerguntas.contains(r.getIdPergunta() + "")) {
                                    listaIdDePerguntas.add(r.getIdPergunta() + "");
                                }
                            }
                            System.out.println(j + "\t" + listaIdDePerguntas.size());
                            outFileParametros.println(j + "\t" + listaIdDePerguntas.size());
                            outFileParametros.flush();
                        }
                    }
                    // incrementa a posicao maxima a ser considerada
                    posicaoMaximaASerConsiderada += 10;
                } while (nroTotalDeReceitas < numMinimoDePares);

                outFileParametros.close();

                ConexaoDB cbdStackCookbooks = new ConexaoDB();
                // Conecta ao banco stack_research
                cbdStackCookbooks.conectaAoBD("stackOfCookBooks");
                PreparedStatement ps = cbdStackCookbooks.criaPreparedStatement(
                        "insert into recipes(NameApis, NameTopic, TopicId, QuestionId, AnswerId, TitleQuestion, TagsQuestion, BodyQuestion, BodyAnswer, RankingPosition) values(?,?,?,?,?,?,?,?,?,?)");

                int contadorCapitulo = 0;
                Iterator it = mapTopicoTopTerms.entrySet().iterator();
                while (it.hasNext()) {
                    contadorCapitulo++;
                    Map.Entry pairs = (Map.Entry) it.next();
                    String idDoTopico = (String) pairs.getKey();
                    String topTermosDoTopico = (String) pairs.getValue();

                    if (cookbook.containsKey(idDoTopico)) {
                        List<Receita> receitas = cookbook.get(idDoTopico);

                        for (int j = 0; j < receitas.size(); j++) {
                            Receita r = receitas.get(j);

                            ps.setString(1, nomeAPIs);
                            ps.setString(2, topTermosDoTopico);
                            ps.setInt(3, Integer.parseInt(idDoTopico));
                            ps.setInt(4, r.getIdPergunta());
                            ps.setInt(5, r.getIdResposta());
                            ps.setString(6, r.getTitulo());
                            ps.setString(7, r.getTags());
                            ps.setString(8, r.getCorpoPergunta().replace("<a href=", "<a target=newtab href="));
                            ps.setString(9, r.getCorpoResposta().replace("<a href=", "<a target=newtab href="));
                            ps.setInt(10, r.getPosicaoNoRank());

                            ps.executeUpdate();
                        }
                    }
                    // System.out.println(idDaThread);
                }
                cbdStackCookbooks.close();

                // }
            }
            cbd.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void removeCapitulosPequenos(Map<String, List<Receita>> cookbook, PrintWriter outFileParametros) {

        int nroDeCapitulosRemovidos = 0;
        int nroDeReceitasDosCapitulosRemovidos = 0;

        Set<String> setIdCapitulos = cookbook.keySet();
        Object[] idCapVet = setIdCapitulos.toArray();
        for (int j = 0; j < idCapVet.length; j++) {
            String idCap = (String) idCapVet[j];

            List<Receita> cap = cookbook.get(idCap);
            if (cap.size() < 3) {
                nroDeCapitulosRemovidos++;
                nroDeReceitasDosCapitulosRemovidos += cap.size();
                cookbook.remove(idCap);
            }
        }

        outFileParametros.println("nroDeCapitulosRemovidos: " + nroDeCapitulosRemovidos);
        outFileParametros.println("nroDeReceitasDosCapitulosRemovidos: " + nroDeReceitasDosCapitulosRemovidos);
    }

    private static void ajustaCookbook(Map<String, List<Receita>> cookbook,
                                       Map<String, List<String>> mapDocumentoTopicos, Map<String, String> mapTopicoTopTerms,
                                       PrintWriter outFileParametros) {
        // Nesse ponto o cookbook ja esta construido mas vamos fazer alguns ajustes para
        // evitar capitulos com apenas 1 link
        Set<String> setIdCapitulos = cookbook.keySet();
        Object[] idCapVet = setIdCapitulos.toArray();
        List<Integer> listIdCap = new ArrayList<Integer>();
        for (int j = 0; j < idCapVet.length; j++) {
            String idCap = (String) idCapVet[j];
            listIdCap.add(Integer.parseInt(idCap));
        }

        for (int j = 0; j < listIdCap.size(); j++) {
            String topicoIdOriginal = listIdCap.get(j) + "";
            List<Receita> listaReceitas = cookbook.get(topicoIdOriginal);
            // Verifica se todas as receitas que estao no topico possuem o mesmo id de
            // pergunta, o que significa que nro de links = 1
            List<String> listaIdDePerguntas = new ArrayList<String>();
            for (int k = 0; k < listaReceitas.size(); k++) {
                Receita r = listaReceitas.get(k);
                if (!listaIdDePerguntas.contains(r.getIdPergunta() + "")) {
                    listaIdDePerguntas.add(r.getIdPergunta() + "");
                }
            }

            if (listaIdDePerguntas.size() == 1) {
                int idDaPergunta = listaReceitas.get(0).getIdPergunta();
                List<String> listaDeTopicosDaThread = mapDocumentoTopicos.get(idDaPergunta + "");

                for (int k = 1; k < listaDeTopicosDaThread.size(); k++) {
                    // Pega a partir do segundo topico predominante na thread para tentar transferir
                    // o link pra la
                    String idDoTopico = listaDeTopicosDaThread.get(k);
                    List<Receita> listaReceitasDoNovoTopico = cookbook.get(idDoTopico);
                    // Nao vamos mover o link para um capitulo vazio para nao correr o risco de
                    // deixar esse capitulo so com 1 link
                    if (listaReceitasDoNovoTopico.size() == 0)
                        continue;
                    // adiciona a receita em outro topico
                    listaReceitasDoNovoTopico.addAll(listaReceitas);
                    // Zera o topico que tinha apenas 1 receitas
                    cookbook.put(topicoIdOriginal, new ArrayList<Receita>());
                    outFileParametros.println("link " + listaReceitas.get(0).getIdPergunta() + " - topicId: "
                            + topicoIdOriginal + " (" + mapTopicoTopTerms.get(topicoIdOriginal) + ") - movido para "
                            + idDoTopico + " (" + mapTopicoTopTerms.get(idDoTopico) + ")");
                    break;
                }
            }
        }
    }

    private static void inicializaDadosApisManual(List<String[]> listaNomeApis, List<Integer> listaNroDeParesPorApi,
                                                  List<Integer> listaCodigoDasRodadas, List<Integer> listaKLda,
                                                  List<Integer> listaThresholdParaRanqueamentoApi) {
        String nameApis[] = { "android" };

        listaNomeApis.add(nameApis);
        listaNroDeParesPorApi.add(30000);
        listaCodigoDasRodadas.add(0);
        listaKLda.add(15);
        listaThresholdParaRanqueamentoApi.add(300);

    }

    private static void inicializaDadosApis(List<String[]> listaNomeApis, List<Integer> listaNroDeParesPorApi,
                                            List<Integer> listaCodigoDasRodadas, List<Integer> listaKLda,
                                            List<Integer> listaThresholdParaRanqueamentoApi) {
        try {
            ConexaoDB cbd = new ConexaoDB();
            // Conecta ao banco
            cbd.conectaAoBD("stackOfCookBooks");

            String query = ConsultasBD.consultaQAPairsTable();
            ResultSet rs = cbd.executaQuery(query);
            while (rs.next()) {
                String nameApis[] = rs.getString("NameApis").split("_");
                int qtde = rs.getInt("Qtde");
                int codigoDaRodada = rs.getInt("TestRunCode");
                int k_lda = rs.getInt("lda_k");
                int threshold_for_ranking = rs.getInt("threshold_for_ranking");

                listaNomeApis.add(nameApis);
                listaNroDeParesPorApi.add(qtde);
                listaCodigoDasRodadas.add(codigoDaRodada);
                listaKLda.add(k_lda);
                listaThresholdParaRanqueamentoApi.add(threshold_for_ranking);
            }
            cbd.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void inicializaMapScores(Map<String, Integer> mapScores, List<String[]> APIs) {
        try {
            ConexaoDB cbd = new ConexaoDB();
            // Conecta ao banco
            cbd.conectaAoBD();

//			String query = ConsultasBD.consultaScoreDePosts();
            // Mudança para otimizar por API
            String query = ConsultasBD.consultaScoreDePostsAPI(APIs.get(0)[0]);
            ResultSet rs = cbd.executaQuery(query);
            while (rs.next()) {
                String idPost = rs.getString("id");
                int score = rs.getInt("score");

                mapScores.put(idPost, score);
            }
            cbd.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void inicializaCookbook(Map<String, List<Receita>> cookbook, int nroDeCapitulos) {

        for (int i = 0; i < nroDeCapitulos; i++) {
            List<Receita> listaDeReceitas = new ArrayList<Receita>();
            cookbook.put(i + "", listaDeReceitas);
        }

    }

    private static Receita constroiReceita(int idPergunta, int idResposta, int posicaoNoRank, double scoreDoPar,
                                           double percentDoTopicoDominante) {
        Receita r = null;
        try {
            ConexaoDB cbd = new ConexaoDB();
            cbd.conectaAoBD();

            String q1 = ConsultasBD.consultaTitulo(idPergunta);
            ResultSet r1 = cbd.executaQuery(q1);
            r1.next();
            String tituloPergunta = r1.getString("title");

            q1 = ConsultasBD.consultaTags(idPergunta);
            r1 = cbd.executaQuery(q1);
            r1.next();
            String strTags = r1.getString("tags").replace("<", " ").replace(">", " ");

            q1 = ConsultasBD.consultaCorpo(idPergunta);
            r1 = cbd.executaQuery(q1);
            r1.next();
            String corpoPergunta = r1.getString("body");

            q1 = ConsultasBD.consultaCorpo(idResposta);
            r1 = cbd.executaQuery(q1);
            r1.next();
            String corpoResposta = r1.getString("body");

            cbd.close();

            r = new Receita(tituloPergunta, strTags, corpoPergunta, corpoResposta, idPergunta, idResposta,
                    posicaoNoRank, scoreDoPar, percentDoTopicoDominante);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return r;
    }

    private static void determinaPosticoesNoRank(List<DadoRanqueamento> listaDadosRanqueamento) {
        for (int i = 0; i < listaDadosRanqueamento.size(); i++) {
            listaDadosRanqueamento.get(i).setPosicaoNoRank(i + 1);
        }

    }

    private static void montaMapComDadosDoRanqueamento(Map<String, DadoRanqueamento> mapDadosRanking, String nomeAPIs,
                                                       int codidoDaRodada, Map<String, Integer> mapScores, int tipoDeRanqueamento, ConexaoDB cbd,
                                                       boolean usaFiltroDeCodigoNaResposta, boolean usaFiltroDeTamanhoDaPergunta, boolean usaFiltroDeLinkMortos,
                                                       Filtros filtros, PrintWriter outFileParametros) {
        try {

            int nroDeParesDescartadosPorFiltroDeCodigoNaResposta = 0;
            int nroDeParesDescartadosPorFiltroDeLinksNaResposta = 0;
            int nroDeParesDescartadosPorFiltroDeLinksNaPergunta = 0;
            int nroDeParesDescartadosPorFiltroDeTamanhoDaPergunta = 0;
            int nroDeParesDescartadosPorLimiteDaThread = 0;
            int nroTotalDeParesHowTODaAPI = 0;

            if (tipoDeRanqueamento == 1) {
                /*
                 * String caminhoArquivoRanqueamento =
                 * "/media/HDii-2x3Tb/Lucas/lucas2/drop box/Folhas Experimentos/Experimento 1 - score/Variacao 6/Rodada "
                 * + codidoDaRodada + "/ranqueamento_"+ nomeAPIs+ ".txt"; String
                 * caminhoArquivoFeatures =
                 * "/media/HDii-2x3Tb/Lucas/lucas2/drop box/Dropbox/resultadosFeatures/" +
                 * nomeAPIs + ".txt";
                 *
                 * BufferedReader bufferedReaderArquivoRanqueamento = new BufferedReader(new
                 * InputStreamReader(new FileInputStream(caminhoArquivoRanqueamento)));
                 * BufferedReader bufferedReaderArquivoFeatures = new BufferedReader(new
                 * InputStreamReader(new FileInputStream(caminhoArquivoFeatures)));
                 *
                 * String lineRanquemanto = ""; String lineFeatures = ""; while
                 * ((lineRanquemanto = bufferedReaderArquivoRanqueamento.readLine()) != null) {
                 * lineFeatures = bufferedReaderArquivoFeatures.readLine(); //Nao vamos filtrar,
                 * pois depois sera feita uma analise dos cookbooks para definirmos todos os
                 * filtros, ex: codigo na resposta, nao ter codigo na pergunta, etc //174
                 * ts-coda n. of code snippets (on answer)
                 * //if(consideraApenasRespostaComCodigoFonte){ // double ts_coda =
                 * Double.parseDouble(lineFeatures.split(" 174:")[1].split(" ")[0]); //
                 * if(ts_coda == 0) // continue; //}
                 *
                 * String idPergunta = lineFeatures.split("#")[1].split("-")[0]; String
                 * idResposta = lineFeatures.split("#")[1].split("-")[1];
                 *
                 * int scoreDaPergunta = mapScores.get(idPergunta); int scoreDaResposta =
                 * mapScores.get(idResposta);
                 *
                 * double mediaPonderada =
                 * ProduzArquivosParaParaLearningToRank.calculaMetricaAlvo(scoreDaPergunta,
                 * scoreDaResposta); Double scoreDoRank =
                 * Double.parseDouble(lineRanquemanto.split("\t")[2]);
                 *
                 * DadoRanqueamento dr = new DadoRanqueamento(idResposta, idPergunta,
                 * scoreDoRank, mediaPonderada);
                 *
                 * if(!mapDadosRanking.containsKey(idPergunta)) mapDadosRanking.put(idPergunta,
                 * new HashMap<String, DadoRanqueamento>());
                 *
                 * mapDadosRanking.get(idPergunta).put(idResposta, dr);
                 * listaDadosRanqueamento.add(dr); }
                 */
            } else if (tipoDeRanqueamento == 2) {
                ConexaoDB cbdStackCookbooks = new ConexaoDB();
                // Conecta ao banco stack_research
                cbdStackCookbooks.conectaAoBD("stackOfCookBooks");
                String query = ConsultasBD.consultaPerguntasHowTo(nomeAPIs);
                ResultSet rs = cbdStackCookbooks.executaQuery(query);
                while (rs.next()) {
                    nroTotalDeParesHowTODaAPI++;

                    String idPergunta = rs.getInt("ht.QuestionId") + "";
                    String idResposta = rs.getInt("ht.AnswerId") + "";

                    int scoreDaPergunta = mapScores.get(idPergunta);
                    int scoreDaResposta = mapScores.get(idResposta);

                    double mediaPonderada = ProduzArquivosParaParaLearningToRank.calculaMetricaAlvo(scoreDaPergunta,
                            scoreDaResposta);

                    // antes de incluir o objeto no ranking, vamos verificar se o mesmo passa nos
                    // filtros de codigo-fonte, tamanho pergunta e dead-links
                    String queryCorpo = ConsultasBD.consultaCorpo(Integer.parseInt(idResposta));
                    ResultSet rsInt = cbd.executaQuery(queryCorpo);
                    rsInt.next();
                    String corpoDaResposta = rsInt.getString("body");

                    queryCorpo = ConsultasBD.consultaCorpo(Integer.parseInt(idPergunta));
                    rsInt = cbd.executaQuery(queryCorpo);
                    rsInt.next();
                    String corpoDaPergunta = rsInt.getString("body");

                    if (usaFiltroDeCodigoNaResposta && !filtros.possuiCodigoFonte(corpoDaResposta)) {
                        nroDeParesDescartadosPorFiltroDeCodigoNaResposta++;
                        continue;
                    }

                    // Se estiver usando o filtro para verificar a presenca de dead links e a
                    // resposta possui dead links, desconsidera o par
                    if (usaFiltroDeLinkMortos && filtros.possuiLinksMortos(corpoDaResposta)) {
                        nroDeParesDescartadosPorFiltroDeLinksNaResposta++;
                        continue;
                    }

                    // Se estiver usando o filtro para verificar a presenca de dead links e a
                    // pergunta possui dead links, desconsidera o par
                    if (usaFiltroDeLinkMortos && filtros.possuiLinksMortos(corpoDaPergunta)) {
                        nroDeParesDescartadosPorFiltroDeLinksNaPergunta++;
                        continue;
                    }

                    // Se estiver usando o filtro para verificar a presenca de pergutas mto grandes
                    // e a pergunta eh mto grande, desconsidera o par
                    if (usaFiltroDeTamanhoDaPergunta && filtros.possuiPerguntaGrande(corpoDaPergunta, true)) {
                        nroDeParesDescartadosPorFiltroDeTamanhoDaPergunta++;
                        continue;
                    }

                    // caso tenha passado nos filtros, vamos verificar se aquele par eh o melhor ate
                    // o momento para a thread
                    // Se for e nao tiver nenhum par para a thread, simplesmente coloca o par la
                    // Se for e tiver pares para a thread, tem que deixar soh o par com maior score
                    DadoRanqueamento dr = new DadoRanqueamento(idResposta, idPergunta, 0, mediaPonderada);

                    if (!mapDadosRanking.containsKey(idPergunta)) {
                        mapDadosRanking.put(idPergunta, dr);
                    } else {
                        DadoRanqueamento drOld = mapDadosRanking.get(idPergunta);
                        if (mediaPonderada > drOld.getScoreGoundThrough()) {
                            // substituimos um par pelo atual pois ele possui score maior
                            mapDadosRanking.put(idPergunta, dr);
                        }
                        // caso ja tenha algum par no map para a thread, ou o par antigo vai sair ou o
                        // novo nao vai entrar, por isso incrementa
                        nroDeParesDescartadosPorLimiteDaThread++;
                    }
                }
            }

            printPares(outFileParametros, nroDeParesDescartadosPorFiltroDeCodigoNaResposta, nroDeParesDescartadosPorFiltroDeLinksNaResposta, nroDeParesDescartadosPorFiltroDeLinksNaPergunta, nroDeParesDescartadosPorFiltroDeTamanhoDaPergunta, nroDeParesDescartadosPorLimiteDaThread, nroTotalDeParesHowTODaAPI, "nroTotalDeParesHowTODaAPI: ", "nroDeParesDescartadosPorFiltroDeCodigoNaResposta: ", "nroDeParesDescartadosPorFiltroDeLinksNaResposta: ", "nroDeParesDescartadosPorFiltroDeLinksNaPergunta: ", "nroDeParesDescartadosPorFiltroDeTamanhoDaPergunta: ", "nroDeParesDescartadosPorLimiteDaThread: ");
            outFileParametros.flush();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void printPares(PrintWriter outFileParametros, int nroDeParesDescartadosPorFiltroDeCodigoNaResposta, int nroDeParesDescartadosPorFiltroDeLinksNaResposta, int nroDeParesDescartadosPorFiltroDeLinksNaPergunta, int nroDeParesDescartadosPorFiltroDeTamanhoDaPergunta, int nroDeParesDescartadosPorLimiteDaThread, int nroTotalDeParesHowTODaAPI, String s, String s2, String s3, String s4, String s5, String s6) {
        outFileParametros.println(s + nroTotalDeParesHowTODaAPI);
        outFileParametros.println(s2
                + nroDeParesDescartadosPorFiltroDeCodigoNaResposta);
        outFileParametros.println(s3
                + nroDeParesDescartadosPorFiltroDeLinksNaResposta);
        outFileParametros.println(s4
                + nroDeParesDescartadosPorFiltroDeLinksNaPergunta);
        outFileParametros.println(s5
                + nroDeParesDescartadosPorFiltroDeTamanhoDaPergunta);
        outFileParametros
                .println(s6 + nroDeParesDescartadosPorLimiteDaThread);
    }

    private static class FilterUsage {
        private String strParametros;
        private boolean usaFiltroDeCodigoNaResposta;
        private boolean usaFiltroDeTamanhoDaPergunta;
        private boolean usaFiltroDeLinkMortos;

        public FilterUsage(String strParametros) {
            this.strParametros = strParametros;
        }

        public String getStrParametros() {
            return strParametros;
        }

        public boolean isUsaFiltroDeCodigoNaResposta() {
            return usaFiltroDeCodigoNaResposta;
        }

        public boolean isUsaFiltroDeTamanhoDaPergunta() {
            return usaFiltroDeTamanhoDaPergunta;
        }

        public boolean isUsaFiltroDeLinkMortos() {
            return usaFiltroDeLinkMortos;
        }

        public FilterUsage invoke() {
            usaFiltroDeCodigoNaResposta = true;
            strParametros += "usaFiltroDeCodigoNaResposta: " + usaFiltroDeCodigoNaResposta + "\n";
            usaFiltroDeTamanhoDaPergunta = true;
            strParametros += "usaFiltroDeTamanhoDaPergunta: " + usaFiltroDeTamanhoDaPergunta + "\n";
            usaFiltroDeLinkMortos = true;
            strParametros += "usaFiltroDeLinkMortos: " + usaFiltroDeLinkMortos + "\n";
            return this;
        }
    }
}
