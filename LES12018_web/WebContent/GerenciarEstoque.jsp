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
		<title>Gerenciar Estoque</title>
	</head>
	<%
			Resultado resultado = (Resultado) session.getAttribute("livros");
			Resultado dados = (Resultado) session.getAttribute("dados");
			List<EntidadeDominio> TodosDados = dados.getEntidades();
			
			DadosParaCadastro DadosCad = (DadosParaCadastro)TodosDados.get(0);
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
		<BR>
		<div class="container">
			<div class="row justify-content-end">
				<div class="col-12">
					<h4 class="d-flex justify-content-between align-items-center mb-3">
						<span class="text-muted">Filtro</span><br></h4>
						<form action="SalvarLivro">
							<div class="row">
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>Titulo</strong> </label> <br>
                                <input type="text" class="form-control" name="txtTitulo" placeholder="Ex:Titulo">
                            </div>
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>ISBN</strong> </label> <br>
                                <input id="txISBN" class="form-control" type="text" name="txtISBN" placeholder="Ex: 9780733426094">
                            </div>
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>Código de Barras</strong> </label> <br>
                                <input id="txtCodBar" class="form-control" type="text" name="txtCodBar" placeholder="Ex: 9780733426094">
                            </div>
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>Editora</strong> </label> <br>
								<select class="custom-select d-block w-100" id="ddlEditora" name="ddlEditora" placeholder="Editora">
									<option value="0">Escolha...</option>
									<%
										sb = new StringBuilder();
										for(Editora edi : DadosCad.getEditora()){
											sb.append("<option value='");
											sb.append(edi.getId()+ "'>");
											sb.append(edi.getNome());
											sb.append("</option>");
										}					
										out.print(sb.toString());
									%>
								</select>
                            </div>
                        </div>

                        <!-- Segunda linha de filtro-->
                        <div class="row">
                            <div class="col-md-3">
                                <label id="dtCad"> <strong>Data de Cadastro</strong></label>
                                <input class="form-control" type="date">
                            </div>
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>Autor</strong> </label> <br>
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
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>Autor</strong> </label> <br>
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
                            <div class="col-md-3">
                                <label id="label-categoria"><strong>Grupo de Precificação</strong> </label>
                                <select class="custom-select d-block" id="ddlGrp" name="ddlGrp" placeholder="Autor">
                                        <option value="0" disabled selected>Escolha...</option>
                                        <option value>Ouro</option>
                                        <option value>Prata</option>
                                        <option value>Bronze</option>
                                </select>  
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                    <label id="label-categoria"> <strong>Número de Páginas</strong> </label> 
                                    <input id="txtNumPag" class="form-control" type="text" name="txtNumPag" placeholder="Ex: 400">
                            </div>
                            <div class="col-md-3">
                                <label id="label-categoria" ><strong>Status</strong></label>
                                <select class="custom-select d-block" name="ckbisAtivo">
                                    <option value="todos">Todos</option>
                                    <option value="true">Ativo</option>
                                    <option value="false">Inativo</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>Ano</strong> </label> 
                                <input id="txtAno" class="form-control" type="text" name="txtAno" placeholder="Ex: 2018">
                            </div>
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>Preço</strong> </label> 
                                <input id="txtPreco" class="form-control" type="text" name="txtPreco" placeholder="Ex: 39,99">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>Altura</strong> </label> <br>
                                <input id="txtAltura" class="form-control" type="text" name="txtAltura" placeholder="Em centímetros">
                            </div>
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>Largura</strong> </label> <br>
                                <input id="txtLargura" class="form-control" type="text" name="txtLargura" placeholder="Em centímetros">
                            </div>
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>Profundidade</strong> </label> <br>
                                <input id="txtProfun" class="form-control" type="text" name="txtProfun" placeholder="Em centímetros">
                            </div>
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>Peso</strong> </label> <br>
                                <input id="txtPeso" class="form-control" type="text" name="txtPeso" placeholder="Em gramas">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <label></label><br>
                                <button type='submit' class='btn btn-success btn-lg btn-block bg-orange' value="CONSULTAR-ESTOQUE" name='operacao'>FILTRAR</button>
                            </div> 
                        </div>
                        <br>
						</form>
				</div>
			</div>
			<div class="row">
				<table class="table">
				  <thead class="card-header bg-primary text-white bg-orange">
				    <tr>
				      <th scope="col">ID</th>
				      <th scope="col">Título</th>
				      <th scope="col">Autor</th>
				      <th scope="col">Editora</th>
				      <th scope="col">Estoque</th>
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
				    				
				    				sbRegistro.append("<td>");
				    				sbRegistro.append(livro.getId());
				    				sbRegistro.append("</td>");
				    				
				    				sbRegistro.append("<td>");
				    				sbRegistro.append(livro.getTitulo());
				    				sbRegistro.append("</td>");
				    				
				    				sbRegistro.append("<td>");
				    				sbRegistro.append(livro.getAutor().getNome());
				    				sbRegistro.append("</td>");
				    				
				    				sbRegistro.append("<td>");
				    				sbRegistro.append(livro.getEditora().getNome());
				    				sbRegistro.append("</td>");
				    				
				    				sbRegistro.append("<td>");
				    				sbRegistro.append(livro.getQtdEstoque());
				    				sbRegistro.append("</td>");
				    				
				    				if(livro.getQtdEstoque() > 0){
				    					sbRegistro.append("<td>");
				    					sbRegistro.append("<button class='btn btn-success btn-lg btn-block'"); 
					    				sbRegistro.append("data-toggle='modal' data-target='#ModalInativar' onclick='");
					    				sbRegistro.append("idLivro(");
					    				sbRegistro.append(livro.getId()+", ");
					    				sbRegistro.append(livro.getQtdEstoque());
					    				sbRegistro.append(")'>Remover do estoque</button>");
					    				sbRegistro.append("<button class='btn btn-primary btn-lg btn-block'"); 
					    				sbRegistro.append("data-toggle='modal' data-target='#ModalAtivar'onclick='");
					    				sbRegistro.append("idLivro(");
					    				sbRegistro.append(livro.getId()+", ");
					    				sbRegistro.append(livro.getQtdEstoque());
					    				sbRegistro.append(")'>Adicionar ao estoque</button>");
					    				sbRegistro.append("</td>");
				    				}else if(livro.getQtdEstoque() == 0){
				    					sbRegistro.append("<td>");
				    					sbRegistro.append("<button class='btn btn-primary btn-lg btn-block'"); 
					    				sbRegistro.append("data-toggle='modal' data-target='#ModalAtivar'onclick='");
					    				sbRegistro.append("idLivro(");
					    				sbRegistro.append(livro.getId()+", ");
					    				sbRegistro.append(livro.getQtdEstoque());
					    				sbRegistro.append(")'>Adicionar ao estoque</button>");
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
			function idLivro(id, estoque){
			    document.getElementById("txtId").value = id;
			    document.getElementById("qtdEsto").value = estoque;
			    document.getElementById("qtdEsto2").value = estoque;
			    alert(document.getElementById("qtdEsto").value);
			    document.getElementById("txtId2").value = id;
			}
		</script>

<form action='SalvarLivro' method="post">	
<div class="modal fade" id="ModalInativar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
 <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Inativação</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
	      <div class="container">
	      	<div class="row">
	      		<div class="col-md-4 mb-6">
	      			<input class="form-control" readonly="readonly" type="text" id="txtId" name="txtId">
	      			<input class="form-control" type="text" readonly="readonly" id="qtdEsto" name="qtdEsto">
	      		</div>
	      	</div>
			<div class="row">
				<div class="col-md mb-3">
					<label id="label-categoria" class="col-md-6 mb-3"> <strong>Retirar do estoque</strong> </label> <br>
					<input class="form-control" type="number" min="0" name="qtdRemover"></input>
				</div>
			</div>
			</div>	
      	</div>
      <div class="modal-footer">
		<button type='submit' class='btn btn-secondary'value='REMOVER-ESTOQUE' name='operacao'>Confirmar</button>
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
	      			<input class="form-control" type="text" readonly="readonly" id="qtdEsto2" name="qtdEsto"></input>
	      		</div>
	      	</div>
			<div class="row">
				<div class="col-md mb-6">
					<label id="label-categoria" class="col-md-6 mb-3"> <strong>Quantidade</strong> </label> <br>
						<input class="form-control" type="number" min="0" name="qtdEstoque"></input>
				</div>
				<div class="col-md mb-6">
				<label id="label-categoria" class="col-md-6 mb-3"> <strong>Preço de compra</strong> </label> <br>
					<input class="form-control" type="text" name="preco"></input>
				</div>
			</div>
		</div>		
      </div>
      <div class="modal-footer">
		<button type='submit' class='btn btn-secondary'value='ADICIONAR-AO-ESTOQUE' name='operacao'>Confirmar</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
      </div>
    </div>
  </div>
</div>
</form>
</body>	
</html>