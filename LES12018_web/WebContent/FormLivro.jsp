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
	<title>Livros</title>
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
			        <a class="nav-link" href="#">Gerenciar Pedidos </a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="Index.jsp">Gerenciar Livro</a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="#">Geránciar Trocas</a>
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
	<%
		Resultado resultado = (Resultado) session.getAttribute("dados");
		List<EntidadeDominio> dados = resultado.getEntidades();
		
		Livro liv = null;
		try{
			liv = (Livro) session.getAttribute("livro");
		}catch(Exception e){
			
		}
		
		DadosParaCadastro dado = (DadosParaCadastro)dados.get(0);
		StringBuilder sb;
	%>		
		<div class="container">
		<div class="mx-auto" style="width: 500px;">
			<div class="col-xl" style="${empty livro ? '' : 'display:none'}">
				<h4>Cadastrar Livro</h4>
			</div>
			<div class="col-xl" style="${empty livro ? 'display:none' : ''}">
				<h4>Alterar Livro</h4>
			</div>
		</div><br>
			<form action="SalvarLivro" method="post" id="frmSalvarLivro">
				<!-- Seï¿½ï¿½o contendo as caracteristicas do painel de Dados Gerais -->
					<div class="row">
						<section>
							<fieldset id="fieldset-main">
								<legend>Dados Gerais</legend>
								<div class="row">
									<div class="col-md-6 mb-3">
										<label class="titulos-label"> <strong> Título do Livro </strong> </label> 
										<input id="txtTitulo" class="form-control" value="${empty livro ? '' : livro.getTitulo()}" type="text" name="txtTitulo" placeholder="Ex: Vidas Secas" required>
									</div>
									<div class="col-md-6 mb-3" style="${empty livro ? 'display:none' : ''}">
										<label> <strong>Id Livro</strong></label>
										<input class="form-control" type="text" name="txtId" readonly="readonly" value="${empty livro ? '' : livro.getId()}">
									</div>
								</div>
								<div class="row">
									<div class="col-md-5 mb-3">
										<label class="titulos-label"> <strong> Autor </strong> </label><br>
										
										<select class="custom-select d-block w-100" id="ddlAutor" name="ddlAutor">
											<option value>Escolha...</option>
											<%
													sb = new StringBuilder();
													for(Autor aut : dado.getAutores())
												{
													if(liv != null){
														sb.append("<option selected value='");
														sb.append(aut.getId()+ "'>");
														sb.append(aut.getNome());
														sb.append("</option>");
													}else{
														sb.append("<option value='");
														sb.append(aut.getId()+ "'>");
														sb.append(aut.getNome());
														sb.append("</option>");
													}
																						
												}
												out.print(sb.toString());
											%>
										</select>
										<div class="invalid-feedback">
							                  Escolha um Autor.
							            </div>
									</div>
									<div class="col-md-4 mb-3">
										<label class="titulos-label"> <strong> Editora </strong> </label><br>
										<select class="custom-select d-block w-100" id="ddlEditora" name="ddlEditora">
											<option value>Escolha...</option>
												<%
													sb = new StringBuilder();
													for(Editora edi : dado.getEditora())
												{
													if(liv != null){
														sb.append("<option selected value='");
														sb.append(edi.getId()+ "'>");
														sb.append(edi.getNome());
														sb.append("</option>");
													}else{
														sb.append("<option value='");
														sb.append(edi.getId()+ "'>");
														sb.append(edi.getNome());
														sb.append("</option>");
													}
												}
													
												out.print(sb.toString());
											%>
										</select>
										<div class="invalid-feedback">
							                  Escolha uma Editora.
							            </div>
									</div>
									<div class="col-md-4 mb-3">
										<label class="titulos-label"> <strong> Grupo de PrecificaÃ§Ã£o </strong> </label><br>
										<select class="custom-select d-block w-100" id="ddlGrupoPre" name="ddlGrupoPre">
											<option value>Escolha...</option>
												<%
													sb = new StringBuilder();
													for(GrupoPrecificacao grp : dado.getPrecificacoes())
												{
													if(liv != null){
														sb.append("<option selected value='");
														sb.append(grp.getId()+ "'>");
														sb.append(grp.getNome());
														sb.append("</option>");
													}else{
														sb.append("<option value='");
														sb.append(grp.getId()+ "'>");
														sb.append(grp.getNome());
														sb.append("</option>");
													}
												}
													
												out.print(sb.toString());
											%>
										</select>
										<div class="invalid-feedback">
							                  Escolha um Grupo de Previficaï¿½ï¿½o.
							            </div>
									</div>
								</div>
									<div class="row">
										<div class="col-md mb-3">
											<label id="txtISBN" class="titulos-label label-altern"> <strong>ISBN</strong></label><br>
											<input id="txtISBN" class="form-control" type="text" name="txtISBN" value="${empty livro ? '' : livro.getISBN()}" placeholder="Ex: 9780733426094" required>
										</div>
										
										<div>
											<label id="col-md mb-3" class="titulos-label label-altern"> <strong>Cï¿½digo de Barras</strong></label><br>
											<input id="txtCodBarras" class="form-control" type="text" name="txtCodBarras" value="${empty livro ? '' : livro.getCodBarras()}" placeholder="Ex: 7898357410015" required>
										</div>
										
										<div class="col-sm mb-3">
											<label id="label-edicao" class="titulos-label label-altern2 separador"> <strong>Ediï¿½ï¿½o</strong></label><br>
											<input id="txtEdicao" class="form-control" type="text" name="txtEdicao" value="${empty livro ? '' : livro.getEdicao()}" placeholder="Ex: 1ï¿½ Ediï¿½ï¿½o" required>
										</div>
										
										<div>
											<label id="col-sm mb-3" class="titulos-label label-altern2"> <strong>Ano</strong></label><br>
											<input id="txtAno" class="form-control" type="text" name="txtAno" value="${empty livro ? '' : livro.getAnoPub()}" placeholder="Ex: 2018" required>
										</div>
										
										<div>
											<label id="col-sm mb-3" class="titulos-label label-altern2 no-space-break"> <strong>Nï¿½mero de Pï¿½ginas</strong> </label> <br>
											<input id ="txtNumPaginas"class="form-control" type="text" name="txtNumPaginas" value="${empty livro ? '' : livro.getNumPaginas()}" required></input>
										</div>				
									</div>
								<div>
									<div class="row">
										<div class="col-md-6 mb-3">
											<label id="label-sinopse"> <strong>Sinopse</strong> </label>
											<input type="text" id="txtSinopse" name="txtSinopse" class="form-control" value="${empty livro ? '' : livro.getSinopse()}" required></input>
										</div>
										<div class="col-md-6 mb-3">
										<label id="label-categoria" class="col-md-6 mb-3"> <strong>Categoria</strong> </label> <br>
											<select class="mdb-select" multiple name="ddlCategorias">
											<option value="" disabled selected>Escolha as categorias</option>
												<%
													sb = new StringBuilder();
													for(Categoria cat : dado.getCategoria())
												{
													sb.append("<option value='");
													sb.append(cat.getId()+ "'>");
													sb.append(cat.getNome());
													sb.append("</option>");
												}
													
												out.print(sb.toString());
											%>
											</select>
										</div> 
									</div>
								</div>
							</fieldset>	
						</section>
					</div>
				<hr class="mb-4">
				<!-- Seï¿½ï¿½o contendo as caracteristicas do painel de Informaï¿½ï¿½es Bï¿½sicas -->
				<div class="row">
					<section>
						<fieldset id="fieldset-main">
							<legend>Informaï¿½ï¿½es Fï¿½sicas</legend>
							<div class="row">
								<div class="col-md-3 mb-3">
									<label id="label-altura" class="titulos-label label-fisicas" > <strong> Altura </strong> </label>
									<input id="txtAltura" class="form-control" type="text" value="${empty livro ? '' : livro.getAltura()}" name="txtAltura" placeholder="Em cm" required>
								</div>
								
								<div class="col-md-3 mb-3">
									<label id="label-largura" class="titulos-label label-fisicas"> <strong> Largura </strong> </label>
									<input id="txtLargura" class="form-control" type="text" value="${empty livro ? '' : livro.getLargura()}" name="txtLargura" placeholder="Em cm" required>
								</div>
								
								<div class="col-md-3 mb-3">
									<label id="label-peso" class="titulos-label label-fisicas"> <strong> Peso </strong> </label>
									<input id="txtPeso" class="form-control" type="text" name="txtPeso" value="${empty livro ? '' : livro.getPeso()}" placeholder="Em g" required>
								</div>
								
								<div class="col-md-3 mb-3">
									<label id="label-profund" class="titulos-label label-fisicas"> <strong> Profundidade </strong> </label> <br>
									<input id="txtProfundidade" class="form-control" type="text" name="txtProfundidade" value="${empty livro ? '' : livro.getProfundidade()}" placeholder="Em cm" required>
								</div>
							</div>							
							<hr class="mb-4">
							 <div class="row" style="${empty livro ? 'display.none' : ''}">
								<div class="col-md mb-6">
									<div class="col-md mb-6">
										<label><strong>Motivo de Inativaï¿½ï¿½o</strong></label>
										<input type="text" class="form-control" value="${empty livro ? '':livro.getInativacao().getMotivo()}" readonly></input>
									</div>
									<div class="col-md mb-6">
										<input type="text" class="form-control" value="${empty livro ? '' : livro.getInativacao().getCategoria().getNome()}"></input>
									</div>
								</div>
								<div class="row" style="${empty livro ? 'display.none' : ''}">
									<div class="col-md mb-6">
										<div class="col-md mb-6">
											<label><strong>Motivo de Ativaï¿½ï¿½o</strong></label>
											<input class="form-control" value="${empty livro ? '':livro.getAtivacao().getMotivo()}" readonly></input>
										</div>
										<div class="col-mb mb-6">
										<input type="text" class="form-control"value="${empty livro ? '' : livro.getAtivacao().getCategoria().getNome() }"></input>
										</div>
									</div>
								</div>
								</div>
								</fieldset>
								</section>
							</div>
						<label class="custom-control custom-checkbox" style="${empty livro ? '' : 'display:none'}">
		       				 <select class="custom-select d-block w-100" name="ckbisAtivo">
		       				 	<option value="true">Inativado</option>
		       				 	<option value="false">Ativaï¿½ï¿½o</option>
		       				 </select>
		     			 </label>
		     			 	<hr class="mb-4">
		     			 	<div>
								<button type='submit' class='btn btn-primary btn-lg btn-block' value="${empty livro ? 'SALVAR':'ALTERAR'}" name='operacao'>SALVAR</button>
							</div>
					</form>
				</div>
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
		<script>
		function getCategoria(){
			document.getElementById("txtCategorias").value += ", " + nome;
		}
		</script>
		<script>
			function getSinopse(Sinopse){
				document.getElementById("txtSinopse").value = Sinopse;
			}
		</script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
		<script type="text/javascript" src="https://gc.kis.v2.scr.kaspersky-labs.com/BE6FCF3F-98A6-144F-B09E-42F7CB26EEB9/main.js" charset="UTF-8"></script>
	</body>
</html>