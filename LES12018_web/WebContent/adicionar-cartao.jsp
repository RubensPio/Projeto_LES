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
        <meta charset="ISO-8859-1">
        <title>TopBooks</title>
    </head>
    <%
			Resultado resultado = (Resultado) session.getAttribute("login");
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
                                                        <input type="text" class="form-control" name="txtNumCartao">
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label>Cod. Seguranca</label>
                                                        <input type="text" class="form-control" name="txtCodSeg">
                                                    </div>
                                                </div>
                                            </div>
                                        </div><br>
                                        <div class="row">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                                                <label class="btn btn-secondary bg-orange">
                                                                    <input type="radio" name="btnBandeira" id="btnBandeira" autocomplete="off" value="visa" checked><h1><i class="fa fa-cc-visa"></i></h1>
                                                                </label>
                                                                <label class="btn btn-secondary bg-orange">
                                                                    <input type="radio" name="btnBandeira" id="btnBandeira" autocomplete="off" value="mastercard"><h1><i class="fa fa-cc-mastercard"></i></h1>
                                                                </label>
                                                                <label class="btn btn-secondary bg-orange">
                                                                    <input type="radio" name="btnBandeira" id="btnBandeira" autocomplete="off" value="amex"><h1><i class="fa fa-cc-amex"></i></h1>
                                                                </label>
                                                                <label class="btn btn-secondary bg-orange">
                                                                    <input type="radio" name="btnBandeira" id="btnBandeira" autocomplete="off" value="diners-club"><h1><i class="fa fa-cc-diners-club"></i></h1>
                                                                </label>
                                                                <!--<label class="btn btn-secondary bg-orange">
                                                                    <input type="radio" name="options" id="option5" autocomplete="off"><h1><i class="fa fa-cc-elo"></i></h1>
                                                                </label>-->
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div><br>
                                            <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <label>Nome do Titular</label>
                                                                <input type="text" class="form-control" name="txtTitular">
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <label>Mes</label>
                                                                <select class="custom-select d-block w-100" name="ddlMes">
                                                                        <option>Selecione...</option>
                                                                        <option value="01">1</option><option value="02">2</option><option value="03">3</option><option value="04">4</option><option value="05">5</option><option value="06">6</option><option value="07">7</option><option value="08">8</option><option value="09">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <label>Ano</label>
                                                                <select class="custom-select d-block w-100" name="ddlAno">
                                                                        <option>Selecione...</option>
                                                                        <option value="2018">2018</option><option value="2019">2019</option><option value="2020">2020</option><option value="2021">2021</option><option value="2022">2022</option><option value="2023">2023</option><option value="2024">2024</option><option value="2025">2025</option>
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
                                                                <a href="cartoes.jsp" class="btn btn-secondary btn-block">Voltar</a>
                                                            </div>
                                                            <div class="col-md-4"></div>
                                                            <div class="col-md-4">
                                                                <button type="submit" name="operacao" value="SALVAR" class="btn btn-success btn-block">Salvar</button>
                                                                <input type="hidden" name="target" value="ClienteLogado.jsp">
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
