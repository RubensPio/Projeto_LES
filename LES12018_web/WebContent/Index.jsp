<%@page import="LES12018.core.aplicacao.Resultado"%>
<%@page import="les12018.dominio.EntidadeDominio"%>
<%@page import="les12018.dominio.*"%>
<%@page import="les12018.auxiliar.DadosParaCadastro"%>
<%@page import="les12018.dominio.Livro"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="reset.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
		<link rel="stylesheet" href="css/bootstrap.css">
        <meta charset="UTF-8">
        <link rel="shortcut icon" href="imagens/logo_6ce_icon.ico" type="image/x-icon">
		<title>Index</title>
	</head>
	<%
			RequestDispatcher d = request.getRequestDispatcher("ClienteLogado.jsp");
			Resultado resultado = (Resultado) session.getAttribute("login");
			List<EntidadeDominio> Cli = resultado.getEntidades();
			
			Cliente cliente = (Cliente)Cli.get(0);
			if(!cliente.getIsAdmin()){
				d.forward(request, response);
			}
			StringBuilder sb;
	%>
	<header>
		<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-orange">
			  <a class="navbar-brand" href="Index.jsp">
			  	<img src="imagens/logo.png" width="30" height="30" class="d-inline-block align-top" alt="">
			  	ToopBooks
			  </a>
			  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
			    <span class="navbar-toggler-icon"></span>
			  </button>
			  <div class="collapse navbar-collapse" id="navbarNav">
			    <ul class="navbar-nav">
			      <li class="nav-item">
			       	<%
						sb = new StringBuilder();
						sb.append("<a class='nav-link' href='Pedido?");
						sb.append("operacao=CONSULTAR-ADMIN'>");
						sb.append("Gerenciar Pedidos");
						sb.append("</a>");
						
						out.print(sb.toString());
					%>
			      </li>
			      <li class="nav-item">
			        <%
						sb = new StringBuilder();
						sb.append("<a class='nav-link' href='DadosParaLivro?");
						sb.append("target=GerenciarLivro.jsp");
						sb.append("&");
						sb.append("operacao=CONSULTAR'>");
						sb.append("Gerenciar Livros");
						sb.append("</a>");
						
						out.print(sb.toString());
					%>
			      </li>
			      <li class="nav-item">
			        <%
						sb = new StringBuilder();
						sb.append("<a class='nav-link' href='DadosParaLivro?");
						sb.append("target=GerenciarEstoque.jsp");
						sb.append("&");
						sb.append("operacao=CONSULTAR'>");
						sb.append("Gerenciar Estoque");
						sb.append("</a>");
						
						out.print(sb.toString());
					%>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="Pedido?txtTroca=true&operacao=CONSULTAR-TROCAS-ADMIN">Gerenciar Trocas</a>
			      </li>
			      <li class="nav-item">
			      	<a class="nav-link" href="gerenciarCliente.jsp">Gerenciar Cliente</a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="#">Análises</a>
			      </li>
			      <li class="nav-item">
               		<a class="nav-link" href="SalvarCliente?operacao=LOGOUT">Sair</a>
                  </li>
			    </ul>
			  </div>
			</nav>
	</header>
	<body>
		<br>
		<div class="container"><br><br>
			<div>
				<form action="DadosParaLivro" method="post">
					<button type='submit' class='btn btn-success btn-block' value="CONSULTAR" name='operacao'>GERENCIAR LIVRO</button>
					<input type="hidden" name="target" value="GerenciarLivro.jsp">
				</form>
			</div>
		</div>
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
		<script type="text/javascript" src="https://gc.kis.v2.scr.kaspersky-labs.com/BE6FCF3F-98A6-144F-B09E-42F7CB26EEB9/main.js" charset="UTF-8"></script>
	</body>
</html>