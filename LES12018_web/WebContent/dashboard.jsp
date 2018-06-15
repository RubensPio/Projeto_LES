<%@page import="les12018.auxiliar.ItemsGrafico"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="les12018.dominio.*"%>
<%@page import="LES12018.core.aplicacao.Resultado"%>
<%@page import="les12018.dominio.EntidadeDominio"%>

<html>
	<head>
    	<!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">-->
    	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="../../../../dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/bootstrap.css">
		<link rel="shortcut icon" href="file:\\\C:\Users\ruben\Documents\Fatec\LES\Projeto_LES\Projeto_LES\LES12018_web\WebContent\Paginas\imagens\logo_6ce_icon.ico" type="image/x-icon">
    	<meta charset="UTF-8">
    	<title>Análises</title>
    	<script src="https://code.highcharts.com/highcharts.src.js"></script>

	</head>
	<%
			//RequestDispatcher d = request.getRequestDispatcher("ClienteLogado.jsp");
			//Resultado resultado = (Resultado) session.getAttribute("login");
			//List<EntidadeDominio> Cli = resultado.getEntidades();
			
			DadosParaGrafico dadosParaGrafico = null;
			
			try{
				dadosParaGrafico = (DadosParaGrafico)session.getAttribute("grafico");
			}catch(Exception e){
				
			}
			
			//Cliente cliente = (Cliente)Cli.get(0);
			//if(!cliente.getIsAdmin()){
				//d.forward(request, response);
			//}
			StringBuilder sb;
	%>
	<header>
        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-orange">
            <div class="container">
				<a class="navbar-brand" href="gerenciar_pedido.html">
					<img src="imagens/logo.png" width="30" height="30" class="d-inline-block align-top" alt="">
					TOPBOOKS
				</a>
				<div class="collapse navbar-collapse justify-content-end" id="navbarNav">
					<ul class="navbar-nav m-auto">
						<li class="nav-item">
							<a class="nav-link" href="file:\\\C:\Users\ruben\Documents\Fatec\LES\Projeto_LES\Projeto_LES\LES12018_web\WebContent\Paginas\admin\gerenciar_pedido.html">Gerenciar Pedidos </a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="file:\\\C:\Users\ruben\Documents\Fatec\LES\Projeto_LES\Projeto_LES\LES12018_web\WebContent\Paginas\admin\gerenciarLivro.html">Gerenciar Livro</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="file:\\\C:\Users\ruben\Documents\Fatec\LES\Projeto_LES\Projeto_LES\LES12018_web\WebContent\Paginas\admin\gerenciarTroca.html">Gerenciar Trocas</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="graficos.html">Análises</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="file:\\\C:\Users\ruben\Documents\Fatec\LES\Projeto_LES\Projeto_LES\LES12018_web\WebContent\Paginas\admin\gerenciarEstoque.html">Gerenciar Estoque</a>
						</li>
					</ul>
				</div>
				</form>
			</div>
        </nav><br><br>
	</header>
	<body>
		<div class="container-fluid">
		<div class="row">
			<nav class="col-md-2 d-none d-md-block bg-light sidebar">
			<div class="sidebar-sticky">
				
			</nav>

			<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
			<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
				<h1 class="h2">Quantidade de vendas por categoria</h1>
				<form action="Grafico" method="post">
					<div class="btn-toolbar mb-2 mb-md-0">
					<input class="form-control" type="date" name="StartDate">
					</div>
					<div class="btn-toolbar mb-2 mb-md-0">
					<input class="form-control" type="date" name="FinalDate">
					</div>
					<div class="btn-toolbar mb-2 mb-md-0">
					<button class="btn btn-success" name="operacao" value="GRAFICO"><i class="fa fa-search"></i></button>
					</div>
				</form>
			</div>

			<div id="container"></div>


			<%
				sb = new StringBuilder();
			
				if(dadosParaGrafico != null){
					 String[] mes = new String[13];
					ArrayList<String[]> map = new ArrayList<String[]>();
					 
					sb.append("<script type='text/javascript'>");
					sb.append("Highcharts.chart('container', {");
					sb.append("chart: {");
					sb.append("type: 'line'");
					sb.append("},");
					sb.append("title: {");
					sb.append("text: 'Quantidade de vendas por categoria'");
					sb.append("},");
					sb.append("xAxis: {");
					sb.append("categories: ['Jan', 'Feb', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez']");
					sb.append("},");
					sb.append("yAxis: {");
					sb.append("title: {");
					sb.append("text: 'Quantidade de Vendas (und.)'");
					sb.append("}");
					sb.append("},");
					sb.append("plotOptions: {");
					sb.append("line: {");
					sb.append("dataLabels: {");
					sb.append("enabled: true");
					sb.append("},");
					sb.append("enableMouseTracking: false");
					sb.append("}");
					sb.append("},");
					sb.append("series: [");
					int totalcat ;
					for(ItemsGrafico item:dadosParaGrafico.getItems()){
						mes = new String[13];
						System.out.println(item.getNomeCategoria());
						if(!map.isEmpty()){
							for(int i = 0;i < map.size(); i++){
								
								String[] mes2 = map.get(i);
								System.out.println(Arrays.toString(mes2));
								if(mes2[12].equals(item.getNomeCategoria())){
									System.out.println(Arrays.toString(map.get(0)));
									mes = map.get(i);
									System.out.println("Indice do mÊs:" + (item.getMes()-1));
									mes[item.getMes()-1] = String.valueOf(item.getQtdTotal());
									System.out.println("Mes Atualizado" + Arrays.toString(mes));
									map.set(i, mes);
									break;
								}else if(i+1 == map.size()){
									System.out.println(item.getIdCategoria());
									mes[item.getMes()-1] = String.valueOf(item.getQtdTotal());
									System.out.println("Indice do mÊs:" + (item.getMes()-1));
									mes[12] = item.getNomeCategoria();
									System.out.println("Primeiro insert da categoria: "+Arrays.toString(mes));
									map.add(mes);
									item.setFlgUnico(true);
									break;
								}
							}
						}else {
							mes[item.getMes()-1] = String.valueOf(item.getQtdTotal());
							System.out.println("Indice do mÊs:" + (item.getMes()-1));
							mes[12] = item.getNomeCategoria();
							System.out.println("Primeiro insert da categoria: "+Arrays.toString(mes));
							map.add(mes);
						}
					}
					
					for(int i=0; i < map.size(); i++) {
						mes = map.get(i);
						System.out.println(Arrays.toString(map.get(i)));
						sb.append("{name: '" + mes[12]  + "',");
						sb.append("data: [");
						for(int z = 0; z < 12; z++){
							if(mes[z]!=null){
								sb.append(mes[z]+",");
							}else{
								sb.append("0, ");
							}
						}
						sb.append("]},");
					}
					sb.append("]");
					sb.append("});");
					sb.append("</script>");
					
					System.out.println(sb.toString());
					
					out.print(sb.toString());
				}
			%>
			
			
			</main>
		</div>
		</div>

		<!-- Bootstrap core JavaScript
		================================================== -->
		<!-- Placed at the end of the document so the pages load faster -->
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>

		<!-- Icons -->
		<script src="https://unpkg.com/feather-icons/dist/feather.min.js"></script>
		<script type="text/javascript" src="C:\Users\ruben\Downloads\fusioncharts-suite-xt\js\themes\fusioncharts.theme.ocean.js"></script>
        <script type="text/javascript" src="C:\Users\ruben\Downloads\fusioncharts-suite-xt\js\fusioncharts.js"></script>
		<script>
		feather.replace()
		</script>
	</body>
</html>