<%@page import="com.sun.istack.internal.Builder"%>
<%@page import="LES12018.core.aplicacao.Resultado"%>
<%@page import="les12018.dominio.EntidadeDominio"%>
<%@page import="les12018.dominio.*"%>
<%@page import="les12018.auxiliar.DadosParaCadastro"%>
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
			Cliente cliente = (Cliente)session.getAttribute("visualizar");
			Endereco end = cliente.getEnderecos().get(0);
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
                        <div>                                        
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
                    </div>
                    <a class="btn btn-success btn-sm ml-3" href="carrinho.html">
                    <i class="fa fa-shopping-cart"></i> Carrinho
                    <span class="badge badge-light">3</span></a>
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
                                <div class="card-header form-control text-white text-uppercase bg-orange"><i class="fa fa-map-marker"></i> Alterar Endereco</div>
                            </div>
                            <form action="SalvarCliente" method="post">
                            <div class="row">
                              <div class="col-md-12">
                              	<div class="row">
                              		<div class="col-md-6">
                              			<label>Nome Endereco</label>
                              			<%
                                             	sb = new StringBuilder();
                                               	sb.append("<input type='text' class='form-control' name='txtNomeEnd' value='");
                                               	sb.append(end.getNome());
                                               	sb.append("'>");
                                               	
                                               	out.print(sb.toString());
                                        %>
                              		</div>
                              	</div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <label>Pais</label>
                                                <select class="custom-select d-block w-100" name="txtpais">
                                                    <option>Selecione...</option>
                                                    <option value="BRASIL"selected>Brasil</option>
                                                </select>
                                            </div>
                                            <div class="col-md-4">
                                            	<label>CEP</label>
                                                <%
                                                    	sb = new StringBuilder();
                                                    	sb.append("<input type='text' class='form-control' name='txtcep' value='");
                                                    	sb.append(end.getCEP());
                                                    	sb.append("'>");
                                                    	
                                                    	out.print(sb.toString());
                                                %>
                                            </div>
                                            <div class="col-md-4">
                                            	<label>Tipo Res.</label>
                                                <%
                                                    	sb = new StringBuilder();
                                                    	sb.append("<input type='text' class='form-control' name='ddlTipoRes' value='");
                                                    	sb.append(end.getTipoResidencia());
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
                                                <label>Bairro</label>
                                                <%
                                                    	sb = new StringBuilder();
                                                    	sb.append("<input type='text' class='form-control' name='txtBairro' value='");
                                                    	sb.append(end.getBairro());
                                                    	sb.append("'>");
                                                    	
                                                    	out.print(sb.toString());
                                                %>
                                            </div>
                                            <div class="col-md-4">
                                                <label>Cidade</label>
                                                <%
                                                    	sb = new StringBuilder();
                                                    	sb.append("<input type='text' class='form-control' name='ddlcidade' value='");
                                                    	sb.append(end.getCidade());
                                                    	sb.append("'>");
                                                    	
                                                    	out.print(sb.toString());
                                                %>
                                            </div>
                                            <div class="col-md-4">
                                                <label>Estado</label>
                                                <select class="custom-select d-block w-100" name="ddlestado">
                                                    <option>Selecione...</option>
                                                    <option value="SP" selected>São Paulo</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-md-12">
                                            <div class="row">
                                            	<div class="col-sm-2">
                                                    <label>Tipo Log.</label>
                                                    <%
                                                    	sb = new StringBuilder();
                                                    	sb.append("<input type='text' class='form-control' name='ddlTipoLogr' value='");
                                                    	sb.append(end.getTipoLogradouro());
                                                    	sb.append("'>");
                                                    	
                                                    	out.print(sb.toString());
                                                    %>
                                                </div>
                                                <div class="col-md-4">
                                                    <label>Rua</label>
                                                    <%
                                                    	sb = new StringBuilder();
                                                    	sb.append("<input type='text' class='form-control' name='txtrua' value='");
                                                    	sb.append(end.getLogradouro());
                                                    	sb.append("'>");
                                                    	
                                                    	out.print(sb.toString());
                                                    %>
                                                </div>
                                                <div class="col-sm-2">
                                                    <label>Numero</label>
                                                    <%
                                                    	sb = new StringBuilder();
                                                    	sb.append("<input type='text' class='form-control' name='txtnum' value='");
                                                    	sb.append(end.getNumerologradouro());
                                                    	sb.append("'>");
                                                    	
                                                    	out.print(sb.toString());
                                                    %>
                                                </div>
                                                <div class="col-sm-2">
                                                    <label>Complemento</label>
                                                    <%
                                                    	sb = new StringBuilder();
                                                    	sb.append("<input type='text' class='form-control' name='txtcomp' value='");
                                                    	if(end.getComp()!=null)
                                                    		sb.append(end.getComp());
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
                                                    <div class="col-md-8">
                                                        <div class="custom-control custom-checkbox">
                                                        <%
                                                        	sb = new StringBuilder();
                                                        	
                                                        	sb.append("<input type='checkbox' class='custom-control-input' id='customCheck1' name='cbkCobranca' value='true'");
                                                        	if(end.getFlgCobranca())
                                                        		sb.append("checked");
                                                        	sb.append(">");
                                                        	sb.append("<label class='custom-control-label' for='customCheck1'>Marcar como endereco de cobranca</label>");
                                                        	
                                                        	out.println(sb.toString());
                                                        %>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
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
                                                <a href="perfil.html" class="btn btn-secondary btn-block">Voltar</a>
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
    </body>
</html>
