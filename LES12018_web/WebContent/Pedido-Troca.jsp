<%@page import="LES12018.core.aplicacao.Resultado"%>
<%@page import="les12018.dominio.EntidadeDominio"%>
<%@page import="les12018.dominio.*"%>
<%@page import="les12018.auxiliar.DadosParaCadastro"%>
<%@page import="les12018.dominio.Livro"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
	<%
			Resultado resultado = (Resultado) session.getAttribute("login");
			List<EntidadeDominio> Cli = resultado.getEntidades();
			Cliente cliente = (Cliente)Cli.get(0);
			
			Pedido pedido = (Pedido) session.getAttribute("pedido-troca");
			
			StringBuilder sb;
	%>
    <head>
        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">-->
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link rel="stylesheet" href="css/bootstrap.css">
        <meta charset="UTF-8">
        <link rel="shortcut icon" href="imagens/logo_6ce_icon.ico" type="image/x-icon">
        <title>TopBooks</title>
    </head>
    <header>
        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-orange">
            <div class="container">
                <a class="navbar-brand" href="ClienteLogado.jsp">
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
                    %></span>
                    </a>
                    <label>  </label>
                    <a class="nav-brand" href="SalvarCliente?operacao=LOGOUT">Sair</a>
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
                                <li class="list-group-item"><a href="Pedido?txtId=<%out.print(cliente.getId());%>&operacao=CONSULTAR">Todos os Pedidos</a></li>
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
									<li class="list-group-item"><a href="SalvarCliente?txtId=<%out.print(cliente.getId());%>&operacao=CONSULTAR-CUPOM">Cupons de Troca</a></li>
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
                                <div class="card-header form-control text-white text-uppercase bg-orange"><i class="fa fa-truck"></i> Pedido Nº<%out.print(pedido.getId());%></div>
                        </div>
                        <form action="Pedido">
	                        <div class="row">
	                            <div class="col-12">
	                                <ul class="list-group category_block">
	                                        <li class="list-group-item">
	                                            <label id="label-dtCompra"> <strong>Data da Compra</strong> </label><br> 
	                                            <label><%out.print(pedido.getDtCadastro()); %></label>
	                                        </li>
	                                        <li class="list-group-item">
	                                            <label id="label-vlrCompra"> <strong>Valor da Compra</strong> </label><br> 
	                                            <label>R$ <%out.print(pedido.getFrete()+pedido.getValorTotal()); %></label>
	                                        </li>
	                                        <li class="list-group-item">
	                                            <label id="label-statusPed"> <strong>Status do Pedido</strong> </label><br> 
	                                            <label><% out.print(pedido.getStatus()); %></label>
	                                        </li>
	                                        <li class="list-group-item">
	                                            <div class="row">
	                                                <div class="col-12">
	                                                    <div class="table-responsive">
	                                                        <label> <strong>Produtos</strong></label>
	                                                        <table class="table table-striped">
	                                                            <thead>
	                                                                <tr>
	                                                                	<th scope="col"> </th>
	                                                                    <th scope="col"> </th>
	                                                                    <th scope="col">ID</th>
	                                                                    <th scope="col">Produto</th>
	                                                                    <th scope="col" class="text-center">Quantidade</th>
	                                                                    <th scope="col" class="text-right">Preço</th>
	                                                                </tr>
	                                                            </thead>
	                                                            <tbody>
	                                                            <%
	                                                            	int i = 0;
	                                                            	for(Produto produto:pedido.getProdutos()){
	                                                            		i++;
	                                                            		sb = new StringBuilder();
	                                                            		sb.append("<tr>");
	                                                            		sb.append("<td><div class='custom-control custom-checkbox'>");
	                	                                                sb.append("<input type='checkbox' class='custom-control-input' id='customCheck1' value='true' name='ckbTrocar"+ i +"'>");
	        	                                                        sb.append("<label class='custom-control-label' for='customCheck1'></label>");
	        	                                                		sb.append("</div></td>");
	                                                            		sb.append("<td><img src='https://dummyimage.com/50x50/55595c/fff'/></td>");
	                                                            		sb.append("<td><input readonly='readonly' class='form-control' value='"+ produto.getLivro().getId() +"' name='Id"+ i +"'></td>");
	                                                            		sb.append("<td>"+ produto.getLivro().getTitulo() +"</td>");
	                                                            		sb.append("<td><input class='form-control' type='number' name='Num"+ i +"' min='1' max='"+ produto.getQuantidade() +"' value='"+ produto.getQuantidade() +"'></input></td>");
	                                                            		sb.append("<td class='text-right'>R$"+ produto.getSubtotal() +"</td>");
	                                                            		sb.append("</tr>");
	                                                            		
	                                                            		out.print(sb.toString());
	                                                            	}
	                                                            %>
	                                                            </tbody>
	                                                        </table>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </li>
	                                    </ul>
	                                </div>
	                            </div><br>
	                            <div class="row">
	                                    <div class="col-md-12">
	                                        <div class="row">
	                                            <div class="col-md-4">
	                                                <a class="btn btn-secondary btn-block" href="pedidos.jsp">Voltar</a>
	                                            </div>
	                                            <div class="col-md-4"></div>
	                                            <div class="col-md-4">
	                                           	<button class="btn btn-success btn-block" name="operacao" value="REALIZAR-TROCA">Trocar</button>
	                                            </div>
	                                        </div>
	                                    </div>
	                            </div><br>
                            </form>
                    </div><br><br>
                </div>
        </div>
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
    </body>
</html>
