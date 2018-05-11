<%@page import="LES12018.core.aplicacao.Resultado"%>
<%@page import="les12018.dominio.EntidadeDominio"%>
<%@page import="les12018.dominio.*"%>
<%@page import="les12018.auxiliar.DadosParaCadastro"%>
<%@page import="les12018.dominio.Livro"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">-->
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="shortcut icon" href="imagens/logo_6ce_icon.ico" type="image/x-icon">
        <meta charset="UTF-8">
        <title>TopBooks</title>
    </head>
    <%		
			Cliente cliente = (Cliente)session.getAttribute("visualizar");
			Cartao cart = cliente.getCartoes().get(0);
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
                    <a class="btn btn-success btn-sm ml-3" href="carrinho.html">
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
                    <div class="col-12 col-sm-3">
                        <div class="card bg-light mb-3">
                            <div class="card-header bg-primary text-white text-uppercase bg-orange"><i class="fa fa-shopping-basket"></i> Pedidos</div>
                            <ul class="list-group category_block">
                                <li class="list-group-item"><a href="pedidos.html">Todos os Pedidos</a></li>
                                <li class="list-group-item"><a href="pedido-troca.html">Pedidos de Troca</a></li>
                            </ul>
                        </div>
                        <div class="card bg-light mb-3">
                                <div class="card-header bg-primary text-white text-uppercase bg-orange"><i class="fa fa-male"></i> Dados</div>
                                <ul class="list-group category_block">
                                    <li class="list-group-item">
                                    	<%
											sb = new StringBuilder();
											sb.append("<a href='SalvarCliente?txtId=");
											sb.append(cliente.getId());
											sb.append("&");
											sb.append("operacao=CONSULTAR'>");
											sb.append("Gerenciar Perfil");
											sb.append("</a>");
											
											out.print(sb.toString());
										%>
									</li>
									<li class="list-group-item"><a href="alterar-senha.jsp">Alterar Senha</a></li>
                                    <li class="list-group-item">
                                    	<%
											sb = new StringBuilder();
											sb.append("<a href='SalvarCliente?txtId=");
											sb.append(cliente.getId());
											sb.append("&");
											sb.append("operacao=CONSULTAR&target=cartoes.jsp'>");
											sb.append("Gerenciar Cartões");
											sb.append("</a>");
											
											out.print(sb.toString());
										%>
									</li>
                                </ul>
                        </div>
                        <div class="card bg-light mb-3">
                                <div class="card-header bg-primary text-white text-uppercase bg-orange"><i class="fa fa-bell"></i> Notificacoes</div>
                                <ul class="list-group category_block">
                                    <li class="list-group-item"><a href="notificacao.html">Ver Notificacao</a></li>
                                </ul>
                        </div>
                    </div>
                    <div class="col bg-light rounded box-shadow">
                            <div class="row">
                                    <div class="card-header form-control text-white text-uppercase bg-orange"><i class="fa fa-credit-card"></i> Cartao de Credito</div>
                            </div>
                            <form action="SalvarCliente" method="post">
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <label>Numero do Cartao</label>
                                                        <%
                                                        	sb = new StringBuilder();
                                                        	sb.append("<input type='text' name='txtNumCartao' value='");
                                                        	sb.append(cart.getsNumCartao());
                                                        	sb.append("'>");
                                                        	
                                                        	out.print(sb.toString());
                                                        %>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label>Cod. Seguranca</label>
                                                        <%
                                                        	sb = new StringBuilder();
                                                        	sb.append("<input type='text' name='txtCodSeg' value='");
                                                        	sb.append(cart.getsCodSeguranca());
                                                        	sb.append("'>");
                                                        	
                                                        	out.print(sb.toString());
                                                        %>
                                                    </div>
                                                </div>
                                            </div>
                                        </div><br>
                                        <div class="row">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col">
                                                        	<%
	                                                        	sb = new StringBuilder();
	                                                        	sb.append("<div class='btn-group btn-group-toggle' data-toggle='buttons'>");
	                                                        		if(cart.getsBandeira().equals("visa")){
	                                                        			sb.append("<label class='btn btn-secondary active bg-orange'>");
	                                                        			sb.append("<input type='radio' name='btnBandeira' id='btnBandeira' autocomplete='off' value='visa'checked><h1><i class='fa fa-cc-visa'></i></h1>");
	                                                        		}else{
	                                                        			sb.append("<label class='btn btn-secondary bg-orange'>");
	                                                        			sb.append("<input type='radio' name='btnBandeira' id='btnBandeira' autocomplete='off' value='visa'><h1><i class='fa fa-cc-visa'></i></h1>");
	                                                        		}
	                                                        	sb.append("</label>");
	                                                        		if(cart.getsBandeira().equals("mastercard")){
	                                                        			sb.append("<label class='btn btn-secondary active bg-orange'>");
	                                                        			sb.append("<input type='radio' name='btnBandeira' id='btnBandeira' autocomplete='off' value='mastercard' checked><h1><i class='fa fa-cc-mastercard'></i></h1>");
	                                                        		}else{
	                                                        			sb.append("<label class='btn btn-secondary bg-orange'>");
	                                                        			sb.append("<input type='radio' name='btnBandeira' id='btnBandeira' autocomplete='off' value='mastercard'><h1><i class='fa fa-cc-mastercard'></i></h1>");
	                                                        		}
	                                                        	sb.append("</label>");
		                                                    		if(cart.getsBandeira().equals("amex")){
		                                                    			sb.append("<label class='btn btn-secondary active bg-orange'>");
		                                                    			sb.append("<input type='radio' name='btnBandeira' id='btnBandeira' autocomplete='off' value='amex' checked><h1><i class='fa fa-cc-amex'></i></h1>");
		                                                    		}else{
		                                                    			sb.append("<label class='btn btn-secondary bg-orange'>");
		                                                    			sb.append("<input type='radio' name='btnBandeira' id='btnBandeira' autocomplete='off' value='amex'><h1><i class='fa fa-cc-amex'></i></h1>");
		                                                    		}
		                                                    	sb.append("</label>");
			                                                		if(cart.getsBandeira().equals("diners-club")){
			                                                			sb.append("<label class='btn btn-secondary active bg-orange'>");
			                                                			sb.append("<input type='radio' name='btnBandeira' id='btnBandeira' autocomplete='off' value='diners-club' checked><h1><i class='fa fa-cc-diners-club'></i></h1>");
			                                                		}else{
			                                                			sb.append("<label class='btn btn-secondary bg-orange'>");
			                                                			sb.append("<input type='radio' name='btnBandeira' id='btnBandeira' autocomplete='off' value='diners-club'><h1><i class='fa fa-cc-diners-club'></i></h1>");
			                                                		}
			                                                	sb.append("</label>");
			                                          
	                                                        	sb.append("</div>");
	                                                        	System.out.println(sb.toString());
	                                                        	out.print(sb.toString());
                                                        	%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div><br>
                                            <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <label>Nome do Titular</label>
                                                                <%
		                                                        	sb = new StringBuilder();
		                                                        	sb.append("<input type='text' name='txtTitular' value='");
		                                                        	sb.append(cart.getsNomeTitular());
		                                                        	sb.append("'>");
		                                                        	
		                                                        	out.print(sb.toString());
                                                       	 		%>
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <label>Mes</label>
                                                                <select class="custom-select d-block w-100" name="ddlMes">
                                                                        <option>Selecione...</option>
                                                                        <option selected>08</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <label>Ano</label>
                                                                <select class="custom-select d-block w-100" name="ddlAno">
                                                                        <option>Selecione...</option>
                                                                        <option selected>2019</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <%
                                                                	sb = new StringBuilder();
                                                                	sb.append("<input type='hidden' name='txtId' value='");
                                                                	sb.append(cliente.getId());
                                                                	sb.append("'>");
                                                                	out.print(sb.toString());
                                                                %>
                                                            </div>
                                                        </div>
                                                    </div>
                                            </div><br>
                                            <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="row">
                                                            <div class="col-md-4">
                                                                <a href="ClienteLogado.jsp" class="btn btn-secondary btn-block">Voltar</a>
                                                            </div>
                                                            <div class="col-md-4"></div>
                                                            <div class="col-md-4">
                                                                <button type="submit" class="btn btn-success btn-block" name="operacao" value="ALTERAR">Salvar</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                            </div>
                                    </div>
                                </div>
                            </form>
                    </div>
                </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
    </body>
</html>
