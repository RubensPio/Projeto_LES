<%@page import="les12018.dominio.*"%>
<%@page import="java.util.*"%>
<%@page import="LES12018.core.aplicacao.Resultado"%>
<%@page import="les12018.dominio.EntidadeDominio"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
    	<!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">-->
    	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
		<link rel="stylesheet" href="css/bootstrap.css">
		<link rel="shortcut icon" href="imagens/logo_6ce_icon.ico" type="image/x-icon">
		<meta charset="UTF-8">
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
						sb.append("Gerenciar Livros");
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
		<div class="container"><BR>
			<div class="row justify-content-end">
                <div class="col-12">
                    <h4 class="d-flex justify-content-between align-items-center mb-3">
                        <span class="text-muted">Filtro</span><br>
                    </h4>
                    <form action="Pedido" method="post">
                        <div class="row">
                            <div class="col-md-3">
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
                        </div>
   						<input type="hidden" name="txtTroca" value="true">
                        <div class="row">
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
                            <th scope="col">Cliente</th>
                            <th scope="col"></th>
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
					    				
					    				sbRegistro.append("<td>");
					    				sbRegistro.append(ped.getId());
					    				sbRegistro.append("</td>");
					    				
					    				sbRegistro.append("<td>");
					    				sbRegistro.append(sbLink.toString());
					    				sbRegistro.append(ped.getDtCadastro());
					    				sbRegistro.append("</a>");
					    				sbRegistro.append("</td>");
					    				
					    				sbRegistro.append("<td>");
					    				sbRegistro.append(ped.getStatus());
					    				sbRegistro.append("</td>");
					    				
					    				sbRegistro.append("<td>");
					    				sbRegistro.append(ped.getCliente().getsNome());
					    				sbRegistro.append("</td>");
					    				
					    				if(ped.getStatus().equals("Em troca")){
					    					sbRegistro.append("<td>");
					    					sbRegistro.append("<a class='btn btn-success btn-sm'"); 
						    				sbRegistro.append("href='Pedido?txtId=");
						    				sbRegistro.append(ped.getId());
						    				sbRegistro.append("&");
						    				sbRegistro.append("txtStatus=Reprovada");
						    				sbRegistro.append("&");
						    				sbRegistro.append("operacao=ALTERAR'>");
						    				sbRegistro.append("Reprovar</a>");
						    				sbRegistro.append(" ");
						    				sbRegistro.append("<a class='btn btn-success btn-sm'"); 
						    				sbRegistro.append("href='Pedido?txtId=");
						    				sbRegistro.append(ped.getId());
						    				sbRegistro.append("&txtTroca=true");
						    				sbRegistro.append("&txtCliId="+ped.getCliente().getId());
						    				sbRegistro.append("&txtValorTotal="+ped.getValorTotal());
						    				sbRegistro.append("&txtStatus=Em processamento");
						    				sbRegistro.append("&");
						    				sbRegistro.append("operacao=ALTERAR-CUPOM'>");
						    				sbRegistro.append("Aprovar</a>");
						    				sbRegistro.append("</td>");
					    				}else if(ped.getStatus().equals("Em processamento")){
					    					sbRegistro.append("<td>");
					    					sbRegistro.append("<a class='btn btn-success btn-sm'"); 
						    				sbRegistro.append("href='Pedido?txtId=");
						    				sbRegistro.append(ped.getId());
						    				sbRegistro.append("&");
						    				sbRegistro.append("txtStatus=Entrega Cancelada");
						    				sbRegistro.append("&");
						    				sbRegistro.append("operacao=ALTERAR'>");
						    				sbRegistro.append("Reprovar</a>");
						    				sbRegistro.append(" ");
						    				sbRegistro.append("<a class='btn btn-success btn-sm'"); 
						    				sbRegistro.append("href='Pedido?txtId=");
						    				sbRegistro.append(ped.getId());
						    				sbRegistro.append("&");
						    				sbRegistro.append("txtStatus=Em transito");
						    				sbRegistro.append("&");
						    				sbRegistro.append("operacao=ALTERAR'>");
						    				sbRegistro.append("Entregar</a>");
						    				sbRegistro.append("</td>");
					    				}else if(ped.getStatus().equals("Em transito")){
					    					sbRegistro.append("<td>");
						    				sbRegistro.append("<a class='btn btn-success btn-sm'"); 
						    				sbRegistro.append("href='Pedido?txtId=");
						    				sbRegistro.append(ped.getId());
						    				sbRegistro.append("&");
						    				sbRegistro.append("txtStatus=Entregue");
						    				sbRegistro.append("&");
						    				sbRegistro.append("operacao=ALTERAR'>");
						    				sbRegistro.append("Entregue</a>");
						    				sbRegistro.append("</td>");
					    				}
					    				
					    				sbRegistro.append("</tr>");
					    				System.out.println(sbRegistro.toString());
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
	</body>
</html>