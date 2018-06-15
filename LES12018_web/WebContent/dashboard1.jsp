<%@page import="LES12018.core.aplicacao.* "%>
<%@page import="les12018.dominio.*"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="com.google.gson.*" %>
<%@page import="LES12018.controle.web.dashboard.*" %>

<html>
	<head>
    	<!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">-->
    	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="../../../../dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/bootstrap.css">
		<link rel="shortcut icon" href="file:\\\C:\Users\ruben\Documents\Fatec\LES\Projeto_LES\Projeto_LES\LES12018_web\WebContent\Paginas\imagens\logo_6ce_icon.ico" type="image/x-icon">
    	<meta charset="UTF-8">
    	<title>Análises</title>
	</head>
	
	<%
		//Resultado resultado = new Resultado();
		//try{
			
		//	resultado = (Resultado) session.getAttribute("grafico");
		//}catch(Exception e){
			
		//}
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
				<ul class="nav flex-column">
				<li class="nav-item">
					<a class="nav-link active" href="#">
					<span data-feather="home"></span>
					Grafico <span class="sr-only">(current)</span>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="Analises?operacao=GRAF-PEDIDO">
					<span data-feather="file"></span>
					Pedidos
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="Analises?operacao=GRAF-LIVRO">
					<span data-feather="shopping-cart"></span>
					Livros
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="Analises?operacao=GRAF-CLIENTE">
					<span data-feather="users"></span>
					Clientes
					</a>
				</li>
				</ul>
			</div>
			</nav>

			<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
			<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
				<h1 class="h2">Dashboard</h1>
				<div class="btn-toolbar mb-2 mb-md-0">
				<select class="btn btn-sm btn-outline-secondary dropdown-toggle" name="ddlFiltro">
					<option value="todos">Todos</option>
					<option value="hoje">Hoje</option>
					<option value="semana">Essa semana</option>
					<option value="mes">Esse mês</option>
					<option value="ano">Essa ano</option>
				</select>
				</div>
			</div>

			<div id="grafico"></div>
			<%
				Gson gson = new Gson();
				
				Map<String, String> chart = new HashMap<String, String>();
				Map<String, String> dataMap = new LinkedHashMap<String, String>(); 
				FusionCharts colunas = new FusionCharts(
						"",
	            		"",
	            		"", "",
	            		"",
	            		"",
	            		""
						);
				
				chart.put("caption", "TOP 10 ANIME FIGHTS");
				chart.put("showvalues", "0");
				chart.put("theme", "zune");
					
				ArrayList dados = new ArrayList();
				
				//try {
					//for(EntidadeDominio ent : resultado.getEntidades()) {
							
						//Cliente cli = (Cliente) ent;
						Map<String, String> lv = new HashMap<String, String>();
							
						lv.put("label", "oi");
						lv.put("value", "bunda");
						dados.add(lv);
					//}

						
					dataMap.put("chart", gson.toJson(chart));
					dataMap.put("data", gson.toJson(dados));
					            
					colunas = new FusionCharts(
		            		"msline",
		            		"chart",
		            		"900", "380",
		            		"grafico",
		            		"json",
		            		gson.toJson(dataMap)
		            );
				//} catch(Exception e) {
					
				//}
			%>
			<%=colunas.render()%>
			
			<h2>Rank de Cliente</h2>
			<div class="table-responsive">
				<table class="table table-striped table-sm">
				<thead>
					<tr>
					<th>Rank</th>
					<th>Nome</th>
					<th>Compras</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>01</td>
						<td>Souza</td>
						<td>2</td>
					</tr>
					<tr>
						<td>02</td>
						<td>Nelson</td>
						<td>1</td>
					</tr>
				</tbody>
				</table>
			</div>
			</main>
		</div>
		</div>

		<!-- Bootstrap core JavaScript
		================================================== -->
		<!-- Placed at the end of the document so the pages load faster -->
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>

		<!-- Icons -->
		<script src="https://unpkg.com/feather-icons/dist/feather.min.js"></script>
		<script>
		feather.replace()
		</script>
		<%=colunas.render() %>
	</body>
</html>