<%@page import="les12018.dominio.*"%>
<%@page import="java.util.*"%>
<%@page import="LES12018.core.aplicacao.Resultado"%>
<%@page import="les12018.dominio.EntidadeDominio"%>
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
			Resultado resultado = (Resultado) session.getAttribute("login");
			List<EntidadeDominio> Cli = resultado.getEntidades();
			
			Cliente cliente = (Cliente)Cli.get(0);
			
			Resultado resultado2 = (Resultado) session.getAttribute("pedidos");
			
			StringBuilder sb;
	%>
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
                                <li class="list-group-item"><a href="Pedido?txtId='<%out.print(cliente.getId());%>'">Todos os Pedidos</a></li>
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
                                    <div class="card-header form-control text-white text-uppercase bg-orange"><i class="fa fa-truck"></i> Trocas</div>
                            </div>
                            <div class="row justify-content-end">
				                <div class="col-12">
				                    <form action="Pedido" method="post">
				                        <div class="row">
				                            <div class="col-md-3">
				                            	<input type="hidden" name="txtId" value="<%out.print(cliente.getId());%>">
				                                <label id="label-categoria"> <strong>Status do Pedido</strong> </label> <br>
				                                <input type="text" class="form-control" name="txtStatusP" placeholder="Ex: Em transporte">
				                            </div>
				                            <div class="col-md-3">
				                                <label id="label-categoria"> <strong>Método de Pagamento</strong> </label> <br>
				                                <select id="options" class="custom-select d-block" name="txtFormPagamento" onchange="optionCheck()">
				                                     <option value="">Selecione</option>
				                                     <option value="CA">Cartão</option>
				                                     <option value="CP">Cupom</option>
				                                     <option value="CC">Cupom + Cartão</option>
				                                 </select>
				                            </div>
				                            <div class="col-md-3">
				                                <label id="label-categoria"> <strong>Valor</strong> </label> <br>
				                                <input id="txtCodBar" class="form-control" type="text" name="txtValorTotal" placeholder="Ex: 10">
				                            </div>
				                            <div class="col-md-3">
				                                <label id="label-categoria"> <strong>Num Cartão</strong> </label> <br>
				                                <input id="txtTelefone" class="form-control" type="text" name="txtNumCartao" placeholder="Ex: 47999320">
				                            </div>
				                        </div>
				
				                        <!-- Segunda linha de filtro-->
				                        <div class="row">
				                            <div class="col-md-3">
				                                <label id="dtCad"> <strong>Data do Pedido</strong></label>
				                                <input class="form-control" type="date" name="dtDataPedido">
				                            </div>
				                            <div class="col-md-3">
				                                <label><strong>CEP</strong></label>
				                                <input id="txtRanking" class="form-control" type="text" name="txtCEP" placeholder="Ex: 08743480">
				                            </div>
				                            <div class="col-md-3">
				                                <label id="label-categoria"> <strong>Num Logradouro</strong> </label> <br>
				                                <input id="txtRanking" class="form-control" type="text" name="txtNumLogradouro" placeholder="Ex: 487">   
				                            </div>
				                            <input type="hidden" name="txtTroca" value="true">
				                            <div class="col-md-3">
				                                <label></label><br>
				                                <button type='submit' class='btn btn-success btn-lg btn-block bg-orange' value="CONSULTAR-TROCA" name='operacao'>FILTRAR</button>
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
				                            <th scope="col">ID do Pedido</th>
				                            <th scope="col">Data</th>
				                            <th scope="col">Status</th>
				                            <th scope="col">Valor Total</th>
				                        </tr>
				                    </thead>
				                    <tbody>
				                    	<%
									    try{
									    	if(resultado2 != null) {
									    		List<EntidadeDominio> pedidos = resultado2.getEntidades();
									    		StringBuilder sbRegistro = new StringBuilder();
									    		StringBuilder sbLink = new StringBuilder();
									    		Pedido ped;
									    		
									    		if(pedidos != null) {
									    			for(EntidadeDominio ent: pedidos) {
									    				ped = (Pedido)ent;
									    				sbRegistro = new StringBuilder();
											    		sbLink = new StringBuilder();
									    				
									    				sbRegistro.append("<tr>");
									    				System.out.println(ped.getFormaDePagamento());
									    				sbLink.append("<a href=Pedido?");
										    				sbLink.append("txtId=");
										    				sbLink.append(ped.getId());
										    				sbLink.append("&");
										    				sbLink.append("operacao=VISUALIZAR");
									    				sbLink.append(">");
									    				
									    				sbRegistro.append("<td>");
									    				sbRegistro.append(sbLink.toString());
									    				sbRegistro.append(ped.getId());
									    				sbRegistro.append("<a/>");
									    				sbRegistro.append("</td>");
									    				
									    				sbRegistro.append("<td>");
									    				sbRegistro.append(sbLink.toString());
									    				sbRegistro.append(ped.getDtCadastro());
									    				sbRegistro.append("</a>");
									    				sbRegistro.append("</td>");
									    				
									    				sbRegistro.append("<td>");
									    				sbRegistro.append(ped.getStatus());
									    				sbRegistro.append("</td>");
									    				
									    				sbRegistro.append("<td>R$ ");
									    				sbRegistro.append(ped.getValorTotal());
									    				sbRegistro.append("</td>");
									    				
									    				sbRegistro.append("</tr>");
									    				
									    				out.print(sbRegistro.toString());
									    			}
									    		}
									    	}
									    } catch(Exception e){
									    	
									    }
									    %>	
				                        <!-- <td><button class="btn btn-success bg-orange">Inativar</button> </td> --> 
				                    </tbody>
				                </table>
				            </div>
                    </div>
                </div>
        </div>
    </body>
</html>
