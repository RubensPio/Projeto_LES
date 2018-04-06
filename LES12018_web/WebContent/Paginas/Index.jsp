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
		<meta charset="ISO-8859-1">
		<title>Index</title>
	</head>
	<header>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			  <a class="navbar-brand" href="Index.jsp">
			  	<img src="logo.png" width="30" height="30" class="d-inline-block align-top" alt="">
			  	ToopBooks
			  </a>
			  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
			    <span class="navbar-toggler-icon"></span>
			  </button>
			  <div class="collapse navbar-collapse" id="navbarNav">
			    <ul class="navbar-nav">
			      <li class="nav-item">
			        <a class="nav-link" href="../FormLivro">Ger�nciar Pedidos </a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="#">Gerenciar Livro</a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="#">Ger�nciar Trocas</a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="#">An�lises</a>
			      </li>
			    </ul>
			  </div>
			</nav>
	</header>
	<body>
	<%
		    Resultado resultado = (Resultado) session.getAttribute("resultado");
		    if(resultado !=null && resultado.getMsg() != null){
		        out.print(resultado.getMsg());
		    }
		
	%>
		<br>
		<div class="container">
			<div>
				<form action="DadosParaLivro" method="post">
					<button type='submit' class='btn btn-primary btn-lg btn-block' value="CONSULTAR" name='operacao'>GERENCIAR LIVRO</button>
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