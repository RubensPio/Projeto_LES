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
		<!--<link rel="stylesheet" href="style-cadastro-livro.css">-->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
		<meta charset="ISO-8859-1">
	<title>Cadastrar Livro</title>
	</head>
	<header>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			  <a class="navbar-brand" href="#">
			  	<img src="logo.png" width="30" height="30" class="d-inline-block align-top" alt="">
			  	ToopBooks
			  </a>
			  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
			    <span class="navbar-toggler-icon"></span>
			  </button>
			  <div class="collapse navbar-collapse" id="navbarNav">
			    <ul class="navbar-nav">
			      <li class="nav-item">
			        <a class="nav-link" href="../FormLivro">Gerênciar Pedidos </a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="#">Gerenciar Livro</a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="#">Gerênciar Trocas</a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="#">Análises</a>
			      </li>
			    </ul>
			  </div>
			</nav>
			<div class="mx-auto" style="width: 300px;">
				<h1>Cadastrar Livro</h1>
			</div>   
	</header>
	<body>
	<%
		//Resultado resultado = (Resultado) session.getAttribute("resultado");
		//List<EntidadeDominio> entidade = resultado.getEntidades();
		
		//DadosParaCadastro dados = (DadosParaCadastro)entidade.get(0);
		//StringBuilder sb;
	%>
		<div class="container">
		<!--  -->
			<form action="SalvarLivro" method="post" id="frmSalvarLivro">
				<!-- Seção contendo as caracteristicas do painel de Dados Gerais -->
					<div class="row">
						<section>
							<fieldset id="fieldset-main">
								<legend>Dados Gerais</legend>
								<div class="row">
									<div class="col-md-6 mb-3">
										<label class="titulos-label"> <strong> Título do Livro </strong> </label> 
										<input id="txtTitulo" class="form-control" type="text" name="txtTitulo" placeholder="Ex: Vidas Secas" required>
									</div>
									<div class="col-md-6 mb-3" style="${empty livro ? 'display:none' : ''}">
										<label> <string> <strong>Id Livro</strong></label>
										<input class="form-control" type="text" name="txtID" disabled value="${empty livro ? '' : livro.getId()}">
									</div>
								</div>
								<div class="row">
									<div class="col-md-5 mb-3">
										<label class="titulos-label"> <strong> Autor </strong> </label><br>
										
										<select class="custom-select d-block w-100" id="ddlAutor" name="dllAutor" placeholder="Autor" required>
											<option value>Escolha...</option>
											<%
												//sb = new StringBuilder();
											//for(Autor aut : dados.getAutores())
											//{
												//sb.append("<option value='");
											//	sb.append(aut.getId()+ "'>");
										//		sb.append(aut.getNome());
										//		sb.append("</option");
										//	}
										//	out.print(sb.toString());
											%>
										</select>
										<div class="invalid-feedback">
							                  Escolha um Autor.
							            </div>
									</div>
									<div class="col-md-4 mb-3">
										<label class="titulos-label"> <strong> Editora </strong> </label><br>
										<select class="custom-select d-block w-100" id="ddlEditora" name="dllEditora" placeholder="Editora" required>
											<option value>Escolha...</option>
										</select>
										<div class="invalid-feedback">
							                  Escolha um Autor.
							            </div>
									</div>
								</div>
									<div class="row">
										<div class="col-md mb-3">
											<label id="txtISBN" class="titulos-label label-altern"> <strong>ISBN</strong></label><br>
											<input id="txtISBN" class="form-control" type="text" name="txtISBN" placeholder="Ex: 9780733426094">
										</div>
										
										<div>
											<label id="col-md mb-3" class="titulos-label label-altern"> <strong>Código de Barras</strong></label><br>
											<input id="txtCodBarras" class="form-control" type="text" name="txtCodBarras" placeholder="Ex: 7898357410015">
										</div>
										
										<div class="col-sm mb-3">
											<label id="label-edicao" class="titulos-label label-altern2 separador"> <strong>Edição</strong></label><br>
											<input id="txtEdicao" class="form-control" type="text" name="Edicao" placeholder="Ex: 1ª Edição">
										</div>
										
										<div>
											<label id="col-sm mb-3" class="titulos-label label-altern2"> <strong>Ano</strong></label><br>
											<input id="txtAno" class="form-control" type="text" name="txtAno" placeholder="Ex: 2018">
										</div>
										
										<div>
											<label id="col-sm mb-3" class="titulos-label label-altern2 no-space-break"> <strong>Número de Páginas</strong> </label> <br>
											<input id ="txtNumPaginas"class="form-control" type="text" name="txtNumPaginas" placeholder="Ex: 250">
										</div>				
									</div>
								<div>
									<div class="row">
										<div class="col-md-6 mb-3">
											<label id="label-sinopse" class=""> <strong>Sinopse</strong> </label>
											<textarea class="form-control" placeholder="Era uma vez..."></textarea>
										</div>
										
										<div class="col-md-6 mb-3">
											<label id="label-categoria" class="col-md-6 mb-3"> <strong>Categoria</strong> </label> <br>
											<select class="custom-select d-block w-100"> 
												<option>Categoria</option>
												
											</select>
										</div> 
									</div>
								</div>
							</fieldset>	
						</section>
					</div>
				<hr class="mb-4">
				<!-- Seção contendo as caracteristicas do painel de Informações Básicas -->
				<div class="row">
					<section>
						<fieldset id="fieldset-main">
							<legend>Informações Físicas</legend>
							<div class="row">
								<div class="col-md-3 mb-3">
									<label id="label-altura" class="titulos-label label-fisicas"> <strong> Altura </strong> </label>
									<input id="txtAltura" class="form-control" type="text" name="txtAltura" placeholder="Em cm">
								</div>
								
								<div class="col-md-3 mb-3">
									<label id="label-largura" class="titulos-label label-fisicas"> <strong> Largura </strong> </label>
									<input id="txtLargura" class="form-control" type="text" name="Largura" placeholder="Em cm">
								</div>
								
								<div class="col-md-3 mb-3">
									<label id="label-peso" class="titulos-label label-fisicas"> <strong> Peso </strong> </label>
									<input id="txtPeso" class="form-control" type="text" name="txtPeso" placeholder="Em g">
								</div>
								
								<div class="col-md-3 mb-3">
									<label id="label-profund" class="titulos-label label-fisicas"> <strong> Profundidade </strong> </label> <br>
									<input id="txtProfundidade" class="form-control" type="text" name="txtProfundidade" placeholder="Em cm">
								</div>
							</div>							
							<hr class="mb-4">
						<label class="custom-control custom-checkbox">
		       				 <input type="checkbox" id="save-info">
		     			 </label>
		     			 	<hr class="mb-4">
		     			 <button type="submit" class="btn btn-primary btn-lg btn-block" value="Salvar">Cadastrar</button>
					</section>
				</div>
			</form>
			</div>
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
		<script src="../../../../assets/js/vendor/holder.min.js"></script>
		<script src="../../../../assets/js/vendor/popper.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
		<script type="text/javascript" src="https://gc.kis.v2.scr.kaspersky-labs.com/BE6FCF3F-98A6-144F-B09E-42F7CB26EEB9/main.js" charset="UTF-8"></script>
		<script>
		      (function() {
		        'use strict';
		
		        window.addEventListener('load', function() {
		          // Fetch all the forms we want to apply custom Bootstrap validation styles to
		          var forms = document.getElementsByClassName('needs-validation');
		
		          // Loop over them and prevent submission
		          var validation = Array.prototype.filter.call(forms, function(form) {
		            form.addEventListener('submit', function(event) {
		              if (form.checkValidity() === false) {
		                event.preventDefault();
		                event.stopPropagation();
		              }
		              form.classList.add('was-validated');
		            }, false);
		          });
		        }, false);
		      })();
    </script>
	</body>
</html>