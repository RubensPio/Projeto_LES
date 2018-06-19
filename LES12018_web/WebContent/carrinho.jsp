<%@page import="jdk.nashorn.internal.runtime.Undefined"%>
<%@page import="com.sun.xml.internal.txw2.Document"%>
<%@page import="LES12018.core.impl.dao.LivroDAO"%>
<%@page import="LES12018.core.aplicacao.Resultado"%>
<%@page import="LES12018.core.*"%>
<%@page import="les12018.dominio.EntidadeDominio"%>
<%@page import="les12018.dominio.*"%>
<%@page import="les12018.auxiliar.DadosParaCadastro"%>
<%@page import="les12018.dominio.Livro"%>
<%@page import="java.util.*"%>
<!DOCTYPE HTML>
<html>
    <head>
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
			
			Pedido carrinho = new Pedido();
			
			try{
				carrinho = (Pedido) session.getAttribute("carrinho");
			}catch(Exception e){
				
			}
			StringBuilder sb;
	%>
    <header>
        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-orange">
            <div class="container">
                <a class="navbar-brand" href="ClienteLogado.jsp">
                    <img src="imagens/logo.png" width="30" height="30" class="d-inline-block align-top" alt="">
                    TopBooks</a>
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
							sb.append("<a id='perfil' class='navbar-brand' href='SalvarCliente?txtId=");
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
                    <a class="nav-link" href="SalvarCliente?operacao=LOGOUT">Sair</a>
                </form>
            </div>
        </nav>
    </header>
    <br><br>
    <body style="background-color: #f4e8e3"><br>
            <div class="container mb-4">
            	<form action="Pedido">
                    <div class="row">
                        <div class="col-9">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th scope="col"> </th>
                                            <th scope="col">Livro</th>
                                            <th scope="col" class="text-center">Preço</th>
                                            <th scope="col" class="text-center">Quantidade</th>
                                            <th scope="col" class="text-right">SubTotal</th>
                                            <th> </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                    	sb = new StringBuilder();
                                    	
	                                    if(carrinho != null){
	                                    	int i = 0;
	                                    	for(Produto liv:carrinho.getProdutos()){
	                                    		i++;
		                                    	sb.append("<tr>");
		                                    	sb.append("<td><img src='https://dummyimage.com/50x50/55595c/fff/'></td>");
		                                    	sb.append("<td>"+liv.getLivro().getTitulo()+"</td>");
		                                    	sb.append("<td>"+liv.getLivro().getPrecoUnit()+"</td>");
		                                    	sb.append("<td><div class='input-group'>");
		                                    	sb.append("<div class='input-group-prepend'>");
		                                    	sb.append("<button class='btn btn-outline-secondary' type='button' onclick='DecrementValue(`Num" + i +"`,`"+ liv.getLivro().getPrecoUnit() +"`,`subtotal"+ i +"`)'><i class='fa fa-minus'></i></button>");
		                                    	sb.append("</div>");
		                                    	sb.append("<input type='number' class='form-control' min='1' max='100' name='Num"+ i +"' id='Num" + i +"' value='" + liv.getQuantidade() +"' aria-describedby='basic-addon2' onchange='UpdateSubTotal(`Num" + i +"`,`"+ liv.getLivro().getPrecoUnit() +"`,`subtotal"+ i +"`)'>");
		                                    	sb.append("<div class='input-group-append'>");
		                                    	sb.append("<button id='aumentar' class='btn btn-outline-secondary' type='button' onclick='incrementValue(`Num" + i +"`,`"+ liv.getLivro().getPrecoUnit() +"`,`subtotal"+ i +"`)'><i class='fa fa-plus'></i></button>");
		                                    	sb.append("</div>");
		                                    	sb.append("</div>");
		                                    	sb.append("</td>");
		                                    	sb.append("<td class='text-right'><input type='text' class='form-control' readonly='readonly' id='subtotal"+ i +"' value='"+ liv.getSubtotal() +"'></input></td>");
		                                    	sb.append("<td class='text-right'><a class='btn btn-sm btn-danger' href='Pedido?");
		                                    	sb.append("txtLivId=" + liv.getLivro().getId());
		                                    	sb.append("&operacao=REMOVECARRINHO");
		                                    	sb.append("'><i class='fa fa-trash'></i></a></td>");
		                                    	sb.append("</tr>");
	                                    	}
	                                    	System.out.println(sb.toString());
	                                    	out.print(sb.toString());
	                                    }
                                    %>  
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <th class="text-center">Frete</th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div class="input-group mb-3">
                                                    <input type="text" class="form-control" value="08547963" placeholder="CEP" aria-label="CEP" aria-describedby="basic-addon2">
                                                        <div class="input-group-append">
                                                            <button class="btn btn-outline-secondary" type="button">Consultar</button>
                                                        </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-center"><strong>Sub-Total</strong></td>
                                        </tr>
                                        <tr>
                                        	<% 	
                                        		sb = new StringBuilder();
                                        		sb.append("<td class='text-right'>Produto:<input readonly='readonly' id='total' class='form-control' name='total' value='");
                                        		if(carrinho != null)
                                        			sb.append(carrinho.getValorTotal());
                                        		else
                                        			sb.append("0");
                                        		sb.append("'></td>");
                                        		out.print(sb.toString());
                                        	%>
                                        </tr>
                                        <tr>
                                            <td class="text-right">Frete:     R$ 70,00</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Total:</strong>     R$ <%  %></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col mb-2">
                            <div class="row">
                                <div class="col-sm-12  col-md-6">
                                    <a href="ClienteLogado.jsp" class="btn btn-block btn-light">Continue a Comprar</a>
                                </div>
                                <div class="col-sm-12 col-md-6 text-uppercase text-right">
                                    <button id="comprar" class="btn btn-lg btn-block btn-success text-uppercase" name="operacao" value="REALIZAR-COMPRA">Comprar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    </form>
                </div>
        <script>
            function incrementValue(name, valor, nome2)
                {
                    var value = document.getElementById(name).value;
                    var value2;
                    value = isNaN(value) ? 0 : value;
                    value++;
                    document.getElementById(name).value = value;
                    value2 = (document.getElementById(name).value*1) * (valor*1);
                	document.getElementById(nome2).value = value2.toFixed(2);;
                }
        </script>
        <script>
            function DecrementValue(name, valor, nome2)
                {
                    var value = document.getElementById(name).value;
                    
                    if(value!= 0){
                    	value = isNaN(value) ? 0 : value;
                    	value--;
                    	document.getElementById(name).value = value;
                    	value2 = (document.getElementById(name).value*1) * (valor*1);
                    	document.getElementById(nome2).value = value2.toFixed(2);;
                    }
                } 
        </script>
        <script>
        	function UpdateSubTotal(name, valor, name2) {
        		alert("hsaushu");
    			var value = document.getElementById(name).value;
    			var value2;
    			value2 = (document.getElementById(name).value*1) * (valor*1);
        		document.getElementById(nome2).value = value2.toFixed(2);
			}
        </script>
        <script>
        	function UpdateTotal(){
        		var value = 0;
        		for(var i=1; document.getElementById("subtotal"+i) != null; i++){
        			value += document.getElementById("subtotal"+i);
        			alert("subtotal"+i);
        		}
        		document.getElementById(total).value = value;
        	}
        </script>
    </body>
</html>