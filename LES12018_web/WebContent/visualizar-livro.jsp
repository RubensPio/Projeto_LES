<%@page import="LES12018.core.aplicacao.Resultado"%>
<%@page import="les12018.dominio.EntidadeDominio"%>
<%@page import="les12018.dominio.*"%>
<%@page import="les12018.auxiliar.DadosParaCadastro"%>
<%@page import="les12018.dominio.Livro"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">-->
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/csslivro.css">
        <meta charset="UTF-8">
        <link rel="shortcut icon" href="imagens/logo_6ce_icon.ico" type="image/x-icon">
        <title>TopBooks</title>
    </head>
    <%
			Resultado resultado = (Resultado) session.getAttribute("login");
			List<EntidadeDominio> Cli = resultado.getEntidades();
			
			Cliente cliente = (Cliente)Cli.get(0);
			
			Livro livro = (Livro)session.getAttribute("visualizar");
			
			StringBuilder sb;
	%>
    <header>
        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-orange">
            <div class="container">
                <a class="navbar-brand" href="IndexCliente.html">
                <img src="imagens/logo.png" width="30" height="30" class="d-inline-block align-top" alt=""> TopBooks</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>    
                <form class="form-inline my-2 my-lg-0">
                    <div class="input-group input-group-sm">
                        <div class="navbar-brand">
                            <i class="fa fa-user"></i>
                        </div>                                        
                        <%
							sb = new StringBuilder();
							sb.append("<a class='navbar-brand' href='SalvarCliente?txtId=");
							sb.append(cliente.getId());
							sb.append("&");
							sb.append("operacao=CONSULTAR'>");
							sb.append("Bem Vindo, ");
							sb.append(cliente.getsNome());
							sb.append("</a>");
							
							out.print(sb.toString());
						%>
                    </div>
                    <a class="btn btn-success btn-sm ml-3" href="SalvarCliente?txtId=<%out.print(cliente.getId());%>&operacao=CONSULTAR-COMPRA">
                    <i class="fa fa-shopping-cart"></i> Carrinho
                    <span class="badge badge-light"><%
                    	if(session.getAttribute("carrinho") != null){
                    		Pedido ped = (Pedido)session.getAttribute("carrinho");
                    		int t = ped.getProdutos().size();
                    		out.print(t);
                    	}else{
                    		out.print(0);
                    	}
                    %></span></a>
                    <label>  </label>
                    <a class="nav-link" href="SalvarCliente?operacao=LOGOUT">Sair</a>
                </form>
            </div>
        </nav>
    </header>
    <br><br>
    <body style="background-color: #f4e8e3"><br>
        <div class="container">
            <div class="row">
                <!-- Image -->
                <div class="col-12 col-lg-6">
                    <div class="card bg-light mb-3">
                        <div class="card-body">
                            <a href="" data-toggle="modal" data-target="#productModal">
                                <img class="img-fluid" src="https://dummyimage.com/800x800/55595c/fff" />
                                <p class="text-center">Zoom</p>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Add to cart -->
                <div class="col-12 col-lg-6 add_to_cart_block">
                    <div class="card bg-light mb-3">
                        <div class="card-body">
                            <p class="text-center"><%out.print(livro.getTitulo());%></p>
                            <p>Editora: <%out.print(livro.getEditora().getNome());%></p>
                            <p>Autor: <%out.print(livro.getAutor().getNome());%></p>
                            <p>Edicao: <%out.print(livro.getEdicao());%></p>
                            <p>Ano: <%out.print(livro.getAnoPub());%></p>
                            <p class="price">R$ <%out.print(livro.getPrecoUnit());%></p>
                            <form method="get" action="Pedido">
                            	<input type="hidden" name="txtLivId" value="<%out.print(livro.getId());%>">
                            	<input type="hidden" name="txtTitulo" value="<%out.print(livro.getTitulo());%>">
                            	<input type="hidden" name="txtSubTotal" value="<%out.print(livro.getPrecoUnit());%>">
                                <div class="form-group">
                                    <label>Quantidade :</label>
                                        <%
                                        	sb = new StringBuilder();
	                                        sb.append("<div class='input-group'>");
	                                    	sb.append("<div class='input-group-prepend'>");
	                                    	sb.append("<button class='btn btn-outline-secondary' type='button' onclick='DecrementValue()'><i class='fa fa-minus'></i></button>");
	                                    	sb.append("</div>");
	                                    	sb.append("<input type='number' class='form-control' min='1' max='" + livro.getQtdEstoque() +"' name='txtQtd' id='quantity' value='1' aria-describedby='basic-addon2'>");
	                                    	sb.append("<div class='input-group-append'>");
	                                    	sb.append("<button class='btn btn-outline-secondary' type='button' onclick='incrementValue()'><i class='fa fa-plus'></i></button>");
	                                    	sb.append("</div>");
	                                    	sb.append("</div>");
	                                    	
	                                    	out.print(sb.toString());
                                        %>
                                </div>
                                <button class="btn btn-success btn-lg btn-block text-uppercase" name="operacao" value="ADDCARRINHO">
                                    <i class="fa fa-shopping-cart"></i> Adicionar ao carrinho
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Description -->
                <div class="col-12">
                    <div class="card border-light mb-3">
                        <div class="card-header bg-primary text-white text-uppercase bg-orange"><i class="fa fa-align-justify"></i> Descrição</div>
                        <div class="card-body">
                        	<%
                        		sb = new StringBuilder();
                        		sb.append("<p class='card-text'>");
                        		sb.append(livro.getSinopse());
                        		sb.append("</p>");
                        		out.print(sb.toString());
                        	%>
                        </div>
                    </div>
                </div>

                <!-- Reviews -->
                <div class="col-12" id="reviews">
                    <div class="card border-light mb-3">
                        <div class="card-header bg-primary text-white text-uppercase bg-orange"><i class="fa fa-tags"></i> Informações Físicas</div>
                        <div class="card-body">
                        	<table class="table">
                        		
                        		<tbody>
                        			<tr>
                        				<td>
                        					Peso:
                        				</td>
                        				<td>
                        					<%out.println(livro.getPeso() + " KG");%>
                        				</td>
                        			</tr>
                        			<tr>
                        				<td>
                        					Altura:
                        				</td>
                        				<td>
                        					<%out.println(livro.getAltura() + " cm");%>
                        				</td>
                        			</tr>
                        			<tr>
                        				<td>
                        					Largura:
                        				</td>
                        				<td>
                        					<%out.println(livro.getLargura() + " cm");%>
                        				</td>
                        			</tr>
                        			<tr>
                        				<td>
                        					Profundidade:
                        				</td>
                        				<td>
                        					<%out.println(livro.getProfundidade() + " cm");%>
                        				</td>
                        			</tr>
                        			<tr>
                        				<td>
                        					Número de Páginas:
                        				</td>
                        				<td>
                        					<%out.println(livro.getNumPaginas());%>
                        				</td>
                        			</tr>
                        		</tbody>
                        	</table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function incrementValue(){
                    var value = document.getElementById('quantity').value;
                    value = isNaN(value) ? 0 : value;
                    value++;
                    document.getElementById('quantity').value = value;
                }
        </script>
        <script>
            function DecrementValue(){
                    var value = document.getElementById('quantity').value;
                    
                    if(value!= 1){
                    	value = isNaN(value) ? 0 : value;
                    	value--;
                    	document.getElementById('quantity').value = value;
                    }
                } 
        </script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
    </body>

    <!-- Modal image -->
    <div class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="productModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="productModalLabel"><%livro.getTitulo();%></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">X—</span>
                    </button>
                </div>
                <div class="modal-body">
                    <img class="img-fluid" src="https://dummyimage.com/1200x1200/55595c/fff" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</html>