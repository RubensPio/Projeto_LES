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
		<title>Gerenciar Livro</title>
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
				        <a class="nav-link" href="/FormLivro">Ger�nciar Pedidos </a>
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
			Resultado dados = (Resultado) session.getAttribute("dados");
			List<EntidadeDominio> TodosDados = dados.getEntidades();
			
			DadosParaCadastro DadosCad = (DadosParaCadastro)TodosDados.get(0);
			StringBuilder sb;
		%>
		
		<BR>
		<div class="container">
			<div class="row justify-content-end">
				<div class="col-md-4 order-md-2 mb-4">
					<h4 class="d-flex justify-content-between align-items-center mb-3">
						<span class="text-muted">Filtro</span><br></h4>
						<form action="SalvarLivro">
							<div class="row">
								<div class="col-md mb-3">
									<label id="label-categoria" class="col-md-6 mb-3"> <strong>T�tulo</strong> </label> <br>
									<input type="text" class="form-control" name="txtTitulo" placeholder="Ex:Titulo">
								</div>
								<div class="col-md mb-3">
									<label id="label-categoria" class="col-md-6 mb-3"> <strong>Ano</strong> </label> <br>
									<input id="txtAno" class="form-control" type="text" name="txtAno" placeholder="Ex: 2018">
								</div>
								<div class="col-md md-3">
									<label id="label-categoria" class="col-md-6 mb-3"> <strong>ISBN</strong> </label> <br>
									<input id="txISBN" class="form-control" type="text" name="txtISBN" placeholder="Ex: 9780733426094">
								</div>
							</div>
							<div class="row">
								<div class="col-md mb-4">
									<label id="label-categoria" class="col-md-6 mb-3"> <strong>Editora</strong> </label> <br>
											<select class="custom-select d-block w-100" id="ddlEditora" name="ddlEditora" placeholder="Editora">
											<option value="0">Escolha...</option>
												<%
													sb = new StringBuilder();
													for(Editora edi : DadosCad.getEditora())
												{
													sb.append("<option value='");
													sb.append(edi.getId()+ "'>");
													sb.append(edi.getNome());
													sb.append("</option>");
												}
													
												out.print(sb.toString());
											%>
										</select>
								</div>
								<div>
									<label id="label-categoria" class="col-md-6 mb-3"> <strong>Autor</strong> </label> <br>
											<select class="custom-select d-block" id="ddlAutor" name="ddlAutor" placeholder="Autor">
											<option value="0">Escolha...</option>
												<%
													sb = new StringBuilder();
													for(Autor aut : DadosCad.getAutores())
												{
													sb.append("<option value='");
													sb.append(aut.getId()+ "'>");
													sb.append(aut.getNome());
													sb.append("</option>");
												}
													
												out.print(sb.toString());
											%>
										</select>
								</div>
								<div>
									<label class="col-md-6 mb-3"><strong>Status</strong></label>
									<select class="custom-select d-block" name="ckbisAtivo">
										<option value="todos">Todos</option>
										<option value="true">Ativo</option>
										<option value="false">Inativo</option>
									</select>
								</div>
							</div>
							<div class="row">
							<div class="col-md mb-3">
								<label"><strong>Categoria</strong></label>
								<select class="custom-select d-block" id="ddlCategoria" name="ddlCategorias">
											<option value="0">Escolha...</option>
												<%
													sb = new StringBuilder();
													for(Categoria cat:DadosCad.getCategoria())
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
								<div class="col-md mb-3">
									<button type='submit' class='btn btn-primary btn-lg btn-block' value="CONSULTAR" name='operacao'>FILTRAR</button>
								</div>
							</div>
						</form>
				</div>
			</div>
			<div class="row">
				<table class="table">
				  <thead class="thead-dark">
				    <tr>
				      <th scope="col">ID</th>
				      <th scope="col">T�tulo</th>
				      <th scope="col">Autor</th>
				      <th scope="col">Editora</th>
				      <th scope="col">ISBN</th>
				      <th scope="col">Ano</th>
				      <th scope="col">Status</th>
				      <th scope="col"></th>
				    </tr>
				    </thead>
				    <tbody>
				    <%
				    try{
				    	if(resultado != null) {
				    		List<EntidadeDominio> entidades = resultado.getEntidades();
				    		StringBuilder sbRegistro = new StringBuilder();
				    		StringBuilder sbLink = new StringBuilder();
				    		
				    		if(entidades != null) {
				    			for(int i=0; i < entidades.size(); i++) {
				    				Livro livro = (Livro) entidades.get(i);
				    				sbRegistro.setLength(0);
				    				sbLink.setLength(0);
				    				
				    				sbRegistro.append("<tr>");
				    				
				    				sbLink.append("<a href=SalvarLivro?");
					    				sbLink.append("txtId=");
					    				sbLink.append(livro.getId());
					    				sbLink.append("&");
					    				sbLink.append("operacao=");
					    				sbLink.append("VISUALIZAR");
				    				sbLink.append(">");
				    				
				    				sbRegistro.append("<td>");
				    				sbRegistro.append(sbLink.toString());
				    				sbRegistro.append(livro.getId());
				    				sbRegistro.append("<a/>");
				    				sbRegistro.append("</td>");
				    				
				    				sbRegistro.append("<td>");
				    				sbRegistro.append(sbLink.toString());
				    				sbRegistro.append(livro.getTitulo());
				    				sbRegistro.append("</a>");
				    				sbRegistro.append("</td>");
				    				
				    				sbRegistro.append("<td>");
				    				sbRegistro.append(livro.getAutor().getNome());
				    				sbRegistro.append("</td>");
				    				
				    				sbRegistro.append("<td>");
				    				sbRegistro.append(livro.getEditora().getNome());
				    				sbRegistro.append("</td>");
				    				
				    				sbRegistro.append("<td>");
				    				sbRegistro.append(livro.getISBN());
				    				sbRegistro.append("</td>");
				    				
				    				sbRegistro.append("<td>");
				    				sbRegistro.append(livro.getAnoPub());
				    				sbRegistro.append("</td>");
				    				
				    				sbRegistro.append("<td>");
				    				if(livro.isAtivo() == false){
				    					sbRegistro.append("Inativo");
				    					sbRegistro.append("<td>");
					    				sbRegistro.append("<button class='btn btn-primary btn-lg btn-block'"); 
					    				sbRegistro.append("data-toggle='modal' data-target='#ModalAtivar'onclick='");
					    				sbRegistro.append("idLivro(");
					    				sbRegistro.append(livro.getId());
					    				sbRegistro.append(")'>Ativar Livro</button>");
					    				sbRegistro.append("</td>");
				    				}else if(livro.isAtivo() == true){
				    					sbRegistro.append("Ativo");
				    					sbRegistro.append("<td>");
					    				sbRegistro.append("<button class='btn btn-primary btn-lg btn-block'"); 
					    				sbRegistro.append("data-toggle='modal' data-target='#ModalInativar' onclick='");
					    				sbRegistro.append("idLivro(");
					    				sbRegistro.append(livro.getId());
					    				sbRegistro.append(")'>Desativar Livro</button>");
					    				sbRegistro.append("</td>");
				    				}
				    				
				    				
				    				sbRegistro.append("</tr>");
				    				
				    				out.print(sbRegistro.toString());
				    			}
				    		}
				    	}
				    } catch(Exception e){
				    	
				    }
				    %>
				    </tbody>
				  </table>
			</div>
			<div>
				<form action="DadosParaLivro" method="post">
					<button type='submit' class='btn btn-primary btn-lg btn-block' value="CONSULTAR" name='operacao'>CADASTRAR LIVRO</button>
					<input type="hidden" name="target" value="FormLivro.jsp">
				</form>
			</div>
			<%
			    resultado = (Resultado) session.getAttribute("resultado");
			    if(resultado !=null && resultado.getMsg() != null){
			        out.print(resultado.getMsg());}
			%>
		</div>
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
		<script type="text/javascript" src="https://gc.kis.v2.scr.kaspersky-labs.com/BE6FCF3F-98A6-144F-B09E-42F7CB26EEB9/main.js" charset="UTF-8"></script>
		<script>
			function idLivro(id){
			    document.getElementById("txtId").value = id;
			    document.getElementById("txtId2").value = id;
			}
		</script>

<form action='SalvarLivro' method="post">	
<div class="modal fade" id="ModalInativar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
 <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Inativa��o</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
	      <div class="container">
	      	<div class="row">
	      		<div class="col-md-4 mb-6">
	      			<input class="form-control" readonly="readonly" type="text" id="txtId" name="txtId">
	      		</div>
	      	</div>
			<div class="row">
				<div class="col-md mb-3">
					<label id="label-sinopse" class=""> <strong>Motivo de Inativa��o</strong> </label>
					<textarea name="txtMotivoInativ" class="form-control"></textarea>
				</div>
				<div class="col-md mb-3">
					<label id="label-categoria" class="col-md-6 mb-3"> <strong>Categoria de Inativa��o</strong> </label> <br>
						<select class="custom-select d-block" id="ddlCatInativ" name="ddlCatInativ" placeholder="Autor">
							<option value="0">Escolha...</option>
								<%
									sb = new StringBuilder();
									for(CatInativacao ina : DadosCad.getCategoriasDeInativacao())
									{
										sb.append("<option value='");
										sb.append(ina.getId()+ "'>");
										sb.append(ina.getNome());
										sb.append("</option>");
									}
													
									out.print(sb.toString());
								%>
						</select>
				</div>
			</div>
			</div>	
      	</div>
      <div class="modal-footer">
		<button type='submit' class='btn btn-secondary'value='EXCLUIR' name='operacao'>Confirmar</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
      </div>
    </div>
  </div>
</div>
</form>

<form action='SalvarLivro' method="post">
<div class="modal fade" id="ModalAtivar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Ativar</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<div class="Container">
      	<div class="row">
	      		<div class="col-md-4 mb-6">
	      			<input class="form-control" type="text" readonly="readonly" id="txtId2" name="txtId">
	      		</div>
	      	</div>
			<div class="row">
				<div class="col-md mb-6">
					<label id="label-sinopse" class=""> <strong>Motivo de Ativa��o</strong> </label>
					<textarea name="txtMotivoAti" class="form-control"></textarea>
				</div>
				<div class="col-md mb-6">
					<label id="label-categoria" class="col-md-6 mb-3"> <strong>Categoria de Ativa��o</strong> </label> <br>
						<select class="custom-select d-block" id="ddlCatAtiv" name="ddlCatAtiv">
							<option value="0">Escolha...</option>
								<%
									sb = new StringBuilder();
									for(CatAtivacao ati : DadosCad.getCategoriasDeAtivacao())
									{
										sb.append("<option value='");
										sb.append(ati.getId()+ "'>");
										sb.append(ati.getNome());
										sb.append("</option>");
									}
													
									out.print(sb.toString());
								%>
						</select>
				</div>
			</div>
		</div>		
      </div>
      <div class="modal-footer">
		<button type='submit' class='btn btn-secondary'value='ATIVAR' name='operacao'>Confirmar</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
      </div>
    </div>
  </div>
</div>
</form>
</body>	
</html>