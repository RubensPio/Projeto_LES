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
        <link rel="stylesheet" href="css/bootstrap.css">
        <meta charset="UTF-8">
        <link rel="shortcut icon" href="imagens/logo_6ce_icon.ico" type="image/x-icon">
        <title>TopBooks</title>
    </head>
    <%
			Resultado resultado = (Resultado) session.getAttribute("resultado");
			List<EntidadeDominio> Cli = resultado.getEntidades();
			
			Cliente cliente = (Cliente)Cli.get(0);
			
			System.out.println(cliente.getId());
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
                    <div class="col-12 col-sm-3">
                        <div class="card bg-light mb-3">
                            <div class="card-header bg-primary text-white text-uppercase bg-orange"><i class="fa fa-shopping-basket"></i> Pedidos</div>
                            <ul class="list-group category_block">
                                <li class="list-group-item"><a href="Pedido?txtId='<%out.print(cliente.getId());%>'&operacao='CONSULTAR'">Todos os Pedidos</a></li>
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
                                    <li class="list-group-item"><%
											sb = new StringBuilder();
											sb.append("<a href='SalvarCliente?txtId=");
											sb.append(cliente.getId());
											sb.append("&");
											sb.append("operacao=CONSULTAR&target=cartoes.html'>");
											sb.append("Gerenciar Perfil");
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
                                    <div class="card-header form-control text-white text-uppercase bg-orange"><i class="fa fa-c"></i> Cartoes de Credito</div>
                            </div>
                            <div class="row">
                                    <div class="table-responsive">
                                            <table class="table">
                                                <thead>
													<th>Numero do Cartao<th>
													<th><th>
                                                </thead>
                                                    <tbody>
                                                      	<%
                                                      	StringBuilder sbLink = new StringBuilder();
                                                    	StringBuilder sbRegistro= new StringBuilder();
                                   
                                                    	for(Cartao cart:cliente.getCartoes()){
                                                    		if(cart.getsNumCartao() != null){
                                                    			sbLink = new StringBuilder();
                                                            	sbRegistro= new StringBuilder();
                                                    			sbRegistro.append("<tr>");
                                                    			sbLink.append("<a href='SalvarCliente?");
                                                    			sbLink.append("txtNumCartao=");
                                                    			sbLink.append(cart.getsNumCartao());
                                                    			sbLink.append("&");
                                                    			sbLink.append("txtId=");
                                                    			sbLink.append(cliente.getId());
                                                    			sbLink.append("&");
                                                    			sbLink.append("operacao=VISUALIZAR&target=alterar-cartao.jsp'");
                                                    			sbLink.append(">");
                                                    			
                                                    			sbRegistro.append("<td>");
                                                    			sbRegistro.append("<h1><i class='fa fa-cc-");
                                                    			sbRegistro.append(cart.getsBandeira());
                                                    			sbRegistro.append("'></i>");
                                                    			sbRegistro.append(sbLink.toString());
                                                    			sbRegistro.append(cart.getsNumCartao());
                                                    			sbRegistro.append("</a>");
                                                    			sbRegistro.append("</h1>");
                                                    			sbRegistro.append("</td>");
                                                    			sbRegistro.append("<td><a class='btn btn-success' href='SalvarCliente?txtId=");
                                                    			sbRegistro.append(cliente.getId());
                                                    			sbRegistro.append("&");
                                                    			sbRegistro.append("txtNumCartao=");
                                                    			sbRegistro.append(cart.getsNumCartao());
                                                    			sbRegistro.append("&operacao=EXCLUIR");
                                                    			sbRegistro.append("'><i class='fa fa-minus'></i></a></td></tr>");
                                                    			
                                                    			out.print(sbRegistro.toString());
                                                    		}
                                                    	}
                                                      	%>
                                                    </tbody>
                                            </table>
                                    </div>
                            </div>
                                    <div class="row">
                                        <div class="col">
                                            <div></div>
                                            <form action="adicionar-cartao.jsp">
                                                <button type="submit" class="btn btn-success"><i class="fa fa-plus"></i></button>
                                            </form><br>
                                        </div>
                                    </div>
                    </div>
                </div>
        </div>
    </body>
</html>
