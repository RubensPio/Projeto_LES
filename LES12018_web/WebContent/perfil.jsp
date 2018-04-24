<%@page import="LES12018.core.aplicacao.Resultado"%>
<%@page import="les12018.dominio.EntidadeDominio"%>
<%@page import="les12018.dominio.*"%>
<%@page import="les12018.auxiliar.DadosParaCadastro"%>
<%@page import="les12018.dominio.Livro"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
	<%
			Resultado resultado = (Resultado) session.getAttribute("resultado");
			List<EntidadeDominio> Cli = resultado.getEntidades();
			
			Cliente cliente = (Cliente)Cli.get(0);
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
                    <span class="badge badge-light">3</span></a>
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
                                <div class="card-header form-control text-white text-uppercase bg-orange"><i class="fa fa-male"></i> Dados</div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <th>
                                            	<%
                                            		sb = new StringBuilder();
                                            		sb.append("<h1><i class='fa fa-user'></i> ");
                                            		sb.append(cliente.getsNome());
                                            		sb.append("</h1>");
                                            		
                                            		out.print(sb.toString());
                                            	%>
                                            </th>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>
                                                	<%
	                                                	sb = new StringBuilder();
	                                                	sb.append("<h4>Email:</h4>");
	                                                	sb.append("<label>");
	                                                	sb.append(cliente.getsEmail());
	                                                	sb.append("</label>");
	                                                	
	                                                	out.print(sb.toString());
                                                	%>
                                                </td>
                                            </tr>
                                            <tr>
                                            	<td>
                                            		<%
	                                                	sb = new StringBuilder();
	                                                	sb.append("<h4>CPF:</h4>");
	                                                	sb.append("<label>");
	                                                	sb.append(cliente.getsCPF());
	                                                	sb.append("</label>");
	                                                	
	                                                	out.print(sb.toString());
                                                	%>
                                            	</td>
                                            </tr>
                                            <tr>
                                                <td>
													<%
	                                                	sb = new StringBuilder();
	                                                	sb.append("<h4>Data de Nascimento:</h4>");
	                                                	sb.append("<label>");
	                                                	sb.append(cliente.getDtDataNasc());
	                                                	sb.append("</label>");
	                                                	
	                                                	out.print(sb.toString());
                                                	%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                	<%
	                                                	sb = new StringBuilder();
	                                                	sb.append("<h4>Telefone:</h4>");
	                                                	sb.append("<label>");
	                                                	sb.append(cliente.getsTelefone());
	                                                	sb.append("</label>");
	                                                	
	                                                	out.print(sb.toString());
                                                	%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Rank: 01</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="row justify-content-between">
                                	<div class="col-md-3">
                           				<%
                           					sb = new StringBuilder();
                           					
                           					sb.append("<a class='btn btn-success' href='SalvarCliente?");
                           					sb.append("txtId=");
                           					sb.append(cliente.getId());
                           					sb.append("&");
                           					sb.append("operacao=VISUALIZAR");
                           					sb.append("&target=alterar-dados.jsp'>");
                           					sb.append("<i class='fa fa-pencil'></i>");
                           					sb.append("</a>");
                           					
                           					out.print(sb.toString());
                           				%>
                           			</div>
                           			<div class="col-md-3">
	                           			<%
	                           					sb = new StringBuilder();
	                           					
	                           					sb.append("<button type='button' class='btn btn-success' data-toggle='modal' data-target='#ModalDesativar'");
	                           					sb.append("onclick='idCliente(");
	                           					sb.append(cliente.getId());
	                           					sb.append(")'>Desativar Conta</button>");
	                           					
	                           					out.print(sb.toString());
	                           				%>
                           			</div>
                                </div><br>
                            </div>
                        </div>
                        <div class="row">
                            <div class="card-header form-control text-white text-uppercase bg-orange"><i class="fa fa-map-marker"></i> Enderecos</div>
                            <div class="col">
                                <div class="table-responsive">
                                        <table class="table">
                                                <thead>
                                                    <th><h4> Endereco de Cobranca</h4></th>
                                                </thead>
                                                <tbody>
                                                        <%
                                                        StringBuilder sbLink;
                                                        StringBuilder sbRegistro;
                                                        	for(Endereco end:cliente.getEnderecos()){
                                                        		sbLink = new StringBuilder();
                                                            	sbRegistro= new StringBuilder();
                                                        		if(end.getFlgCobranca()){
                                                        			sbRegistro.append("<tr>");
                                                        			sbLink.append("<a href='SalvarCliente?");
                                                        			sbLink.append("txtcep=");
                                                        			sbLink.append(end.getCEP());
                                                        			sbLink.append("&");
                                                        			sbLink.append("txtId=");
                                                        			sbLink.append(cliente.getId());
                                                        			sbLink.append("&");
                                                        			sbLink.append("txtnum=");
                                                        			sbLink.append(end.getNumerologradouro());
                                                        			sbLink.append("&");
                                                        			sbLink.append("operacao=VISUALIZAR'");
                                                        			sbLink.append(">");
                                                        			
                                                        			sbRegistro.append("<td>");
                                                        			sbRegistro.append(sbLink.toString());
                                                        			sbRegistro.append(end.getTipoLogradouro());
                                                        			sbRegistro.append(" ");
                                                        			sbRegistro.append(end.getLogradouro());
                                                        			sbRegistro.append(", ");
                                                        			sbRegistro.append(end.getNumerologradouro());
                                                        			sbRegistro.append(", ");
                                                        			sbRegistro.append(end.getEstado());
                                                        			sbRegistro.append(", ");
                                                        			sbRegistro.append(end.getPais());
                                                        			sbRegistro.append("</a>");
                                                        			sbRegistro.append("</td>");
                                                        			sbRegistro.append("</tr>");
                                                        		}
                                                        		
                                                        		out.print(sbRegistro.toString());
                                                        	}
                                                        %>
                                                </tbody>
                                        </table>
                                </div>
                                <div class="table-responsive">
                                        <table class="table">
                                                <thead>
                                                    <th><h4> Enderecos</h4></th>
                                                    <th> Excluir</th>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        	
                                       
                                                        	for(Endereco end:cliente.getEnderecos()){
                                                        		sbLink = new StringBuilder();
                                                            	sbRegistro= new StringBuilder();
                                                        		if(!end.getFlgCobranca()){
                                                        			sbRegistro.append("<tr>");
                                                        			sbLink.append("<a href='SalvarCliente?");
                                                        			sbLink.append("txtcep=");
                                                        			sbLink.append(end.getCEP());
                                                        			sbLink.append("&");
                                                        			sbLink.append("txtId=");
                                                        			sbLink.append(cliente.getId());
                                                        			sbLink.append("&");
                                                        			sbLink.append("txtnum=");
                                                        			sbLink.append(end.getNumerologradouro());
                                                        			sbLink.append("&");
                                                        			sbLink.append("operacao=VISUALIZAR'");
                                                        			sbLink.append(">");
                                                        			
                                                        			sbRegistro.append("<td>");
                                                        			sbRegistro.append(sbLink.toString());
                                                        			sbRegistro.append(end.getTipoLogradouro());
                                                        			sbRegistro.append(" ");
                                                        			sbRegistro.append(end.getLogradouro());
                                                        			sbRegistro.append(", ");
                                                        			sbRegistro.append(end.getNumerologradouro());
                                                        			sbRegistro.append(", ");
                                                        			sbRegistro.append(end.getEstado());
                                                        			sbRegistro.append(", ");
                                                        			sbRegistro.append(end.getPais());
                                                        			sbRegistro.append("</a>");
                                                        			sbRegistro.append("</td>");
                                                        			sbRegistro.append("<td><a class='btn btn-success' href='SalvarCliente?txtId=");
                                                        			sbRegistro.append(cliente.getId());
                                                        			sbRegistro.append("&");
                                                        			sbRegistro.append("txtcep=");
                                                        			sbRegistro.append(end.getCEP());
                                                        			sbRegistro.append("&");
                                                        			sbRegistro.append("txtnum=");
                                                        			sbRegistro.append(end.getNumerologradouro());
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
                        </div>
                        <div>
                            <div class="row">
                                <div class="col">
                                    <div></div>
                                    <form action="adicionar-endereco.jsp">
                                        <button class="btn btn-success" type="subimit"><i class="fa fa-plus"></i></a>
                                    </form><br>
                                </div>
                            </div>
                        </div>
                    </div><br><br>
                </div>
        </div>
        <form action='SalvarCliente' method="post">
		<div class="modal fade" id="ModalDesativar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Desativar Conta</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		      	<div class="Container">
		      		<div class="row">
			      		<div class="col-md-4 mb-6">
			      			<input class="form-control" type="hidden" id="txtId" name="txtId">
			      		</div>
			      	</div>
					<div class="row">
						<div class="col-md mb-6">
							<h1>VOCÊ REALMENTE QUER DESATIVAR SUA CONTA ?</h1>
						</div>
					</div>
					<div class="row">
						<div class="col-md mb-6">
							<h6>Caso Confirme a operação sua conta será inativada permanentemente</h6>
						</div>
					</div>
					<div class="row">
						<div class="col-md mb-6">
							<h6>Para ter sua conta reativada, será necessário entrar em contato com um administrador</h6>
						</div>
					</div>
				</div>		
		      </div>
		      <div class="modal-footer">
				<button type='submit' class='btn btn-secondary'value='EXCLUIR' name='operacao'>Confirmar</button>
				<input type="hidden" name="target" value="IndexCliente.jsp">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
		      </div>
		    </div>
		  </div>
		</div>
		</form>
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
		<script>
			function idCliente(id){
			    document.getElementById("txtId").value = id;
			}
		</script>
    </body>
</html>
