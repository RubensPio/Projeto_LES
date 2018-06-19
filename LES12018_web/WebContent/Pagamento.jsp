<%@page import="LES12018.core.impl.dao.LivroDAO"%>
<%@page import="LES12018.core.aplicacao.Resultado"%>
<%@page import="LES12018.core.*"%>
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <link rel="shortcut icon" href="imagens/logo_6ce_icon.ico" type="image/x-icon">
        <meta charset="UTF-8">
        <title>TopBooks</title>
        <script>
			$(document).ready(function(){
			    $("#but").click(function(){
			        $(this).hide();
			    });
			});
		</script>
		<script>
			$(document).ready(function(){
			    $("#but").click(function(){
			        $("#cartolin").clone().appendTo("#cartoes");
			    });
			});
		</script>
    </head>
     <%
			Resultado resultado = (Resultado) session.getAttribute("login");
			List<EntidadeDominio> Cli = resultado.getEntidades();
			
			Cliente cliente = (Cliente)Cli.get(0);

			ArrayList<Cartao>Cartoes = new ArrayList<Cartao>();
			ArrayList<Endereco>Enderecos = new ArrayList<Endereco>();
			
			
			Resultado resultado2 = (Resultado) session.getAttribute("resultado");
			List<EntidadeDominio> Clien = resultado2.getEntidades();
			
			Cliente cliente2 = (Cliente)Clien.get(0);
			
			Pedido carrinho = new Pedido();
			
			try{
				carrinho = (Pedido) session.getAttribute("carrinho");
			}catch(Exception e){
				
			}
			
			if(Cartoes.size() == 0)
				Cartoes = cliente.getCartoes();
			 if(Enderecos.size() == 0)
				Enderecos = cliente.getEnderecos();
			
			StringBuilder sb;
	%>
    <header>
        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-orange">
            <div class="container">
                <a class="navbar-brand" href="IndexLogado.jsp">
                <img src="imagens/logo.png" width="30" height="30" class="d-inline-block align-top" alt=""> TopBooks</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>    
                <form class="form-inline my-2 my-lg-0">
                    
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
                    <a class="btn btn-success btn-sm ml-3" href="SalvarCliente?txtId=<%out.print(cliente.getId());%>&operacao=CONSULTAR-COMPRA">
                    <i class="fa fa-shopping-cart"></i> Carrinho
                    <span class="badge badge-light"><%
                    	if(session.getAttribute("carrinho") != null){
                    		Pedido ped = (Pedido)session.getAttribute("carrinho");
                    		int t = ped.getProdutos().size();
                    		out.print(t);
                    	}else{
                    		out.print(0);
                    	}%></span></a>
                </form>
            </div>
        </nav>
    </header>
    <br><br>
    <body style="background-color: #f4e8e3"><br>
    	<form action="Pedido">
	        <div class="container">
	            <div class="row">
	                <div class="col-6">
	                    <div class="card bg-light rounded box-shadow">
	                        <div class="card-header bg-primary text-white text-uppercase bg-orange"><i class="fa fa-map-marke"></i> Endereço de Entrega</div>
	                        <ul class="list-group category_block">
	                            <li class="list-group-item">
	                                <div class="row">
	                                    <div class="col-12">
	                                    <%
	                                    	sb = new StringBuilder();
	                                    	int i=0;
	                                    	
	                                    	sb.append("<select id='enderecoco' name='ddlEndereco' class='custom-select d-block' onchange='blockNewEndereco()'>");
	                                    	sb.append("<option value='0'>Selecione</option>");
	                                    	for(Endereco end:Enderecos){
	                                    		i++;
	                                    		sb.append("<option value='");
	                                    		sb.append(end.getCEP() + ";" + end.getNumerologradouro());
	                                    		sb.append("'>" + end.getLogradouro() + "," + end.getNumerologradouro());
	                                    		sb.append("," + end.getCidade() + "," + end.getPais() + "</option>");
	                                    	}
	                                    	sb.append("</select>");
	                                    	
	                                    	out.print(sb.toString());
	                                    %>
	                                    </div>
	                                </div>
	                            </li>
	                            <div id="newEndereco" style="display: inline;">
	                                <li class="list-group-item">
	                                	<div class="row">
	                                		<div class="col-md-6">
	                                			<input type="text" class="form-control" name="txtNomeEnd" placeholder="Nome do Endereço">
	                                		</div>
	                                	</div>
	                                	<div class="row">
			                        		<div class="col-md-6">
				                                <label for="cep"><span class="req"> </span> CEP *  </label> 
				                                    <input class="form-control" type="text" name="txtcep" id = "cep" maxlength="8"  placeholder="Ex: Digite apenas números" />  
				                                        <div id="errLast"></div>
			                                </div>
			                                <div class="col-md-6">
			                                	<label for="cep"><span class="req"> </span> Bairro *  </label> 
				                                    <input class="form-control" type="text" name="txtBairro"  placeholder="Ex: Jd Esperanca" />  
				                                        <div id="errLast"></div>
			                                </div>
			                            </div>
	                                    <div class="row">
			                        		<div class="col-md-3">
			                        			<label for="rua"><span class="req"> </span>Tipo Log*  </label>
					                        	<select class="form-control" type="text" name="ddlTipoLogr">
					                        		<option>Selecione</option>
					                        		<option value="Rua">Rua</option>
					                        		<option value="Avenida">Avenida</option>
					                        		<option value="Viela">Viela</option>
					                        		<option value="Estrada">Estrada</option>
					                        	</select>
				                        	</div>
				                        	<div class="col-md-3">
				                        		<label for="rua"><span class="req"> </span>Tipo Residencia*  </label>
					                        	<select class="form-control" type="text" name="ddlTipoRes">
					                        		<option>Selecione</option>
					                        		<option value="Rua">Casa</option>
					                        		<option value="Predio">Predio</option>
					                        		<option value="Condominio">Condominio</option>
					                        		<option value="Fazenda">Fazenda</option>
					                        	</select>
				                        	</div>
				                        	<div class="col-md-6">
					                            <label for="rua"><span class="req"> </span> Logradouro*  </label> 
					                                <input class="form-control" type="text" name="txtrua" id = "rua" maxlength="50"  placeholder="Ex: Rua Bonita"/>  
					                                    <div id="errLast"></div>
				                             </div>
			                            </div><br>
	                                    <div class="row">
			                                <div class="col-md-3">
			                                <label for="num"><span class="req"> </span> Número *  </label> 
			                                    <input class="form-control" type="text" name="txtnum" id = "num" maxlength="50"  placeholder="Ex: 267" />  
			                                        <div id="errLast"></div>
				                            </div>
				                            
				                            <div class="col-md-3">
				                                <label for="comp"><span class="req"> </span> Complemento *  </label> 
				                                    <input class="form-control" type="text" name="txtcomp" id = "comp" maxlength="50"  placeholder="Ex: 267" />  
				                                        <div id="errLast"></div>
				                            </div>
				                        
				                            <div class="col-md-3">
				                                <label for="estado"><span class="req"> </span> Estado *  </label> 
				                                    <select class="form-control" type="text" name="ddlestado" id = "estado">
				                                        <option value="SP">São Paulo</option> 
				                                    </select>
				                                        <div id="errLast"></div>
				                            </div>
				
				                            <div class="col-md-3">
				                                    <label for="cidade"><span class="req"> </span> Cidade *  </label> 
				                                        <select class="form-control" type="text" name="ddlcidade" id = "cidade">
				                                            <option value="São Paulo">São Paulo</option> 
				                                        </select>
				                                            <div id="errLast"></div>
				                            </div>
			                        	</div><br>
	                                    <div class="row">
	                                        <div class="col-md-12">
	                                                <div class="custom-control custom-checkbox">
	                                                        <input type="checkbox" class="custom-control-input" id="customCheck1" name="ckbSalvar">
	                                                        <label class="custom-control-label" for="customCheck1">Salvar como novo endereço</label>
	                                                </div>
	                                        </div>
	                                    </div><br>
	                                    <label><h6>OBS: Caso queira utilizar um endereço não cadastrado.</h6></label>
	                                </li>
	                            </div>
	                        </ul>
	                    </div>
	                </div>
	                <div class="col-6">
	                        <div class="card bg-light rounded box-shadow">
	                            <div class="card-header bg-primary text-white text-uppercase bg-orange"><i class="fa fa-credit-card"></i> Métodos de Pagamento</div>
	                            <ul class="list-group category_block">
	                                <li class="list-group-item">
	                                    <div class="row">
	                                        <div class="col-9">
	                                            <select id="options" class="custom-select d-block" name="ddlMetodoPagamento" onchange="optionCheck()">
	                                                <option>Selecione</option>
	                                                <option value="CA">Cartão</option>
	                                                <option value="CP">Cupom</option>
	                                                <option value="CC">Cupom + Cartão</option>
	                                            </select>
	                                        </div>
	                                    </div>
	                                </li>
	                                <div id="cartao" style="display: none;">
	                                    <div class="card-header bg-primary text-white text-uppercase bg-orange"><i class="fa fa-credit-card"></i> Cartão</div>
	                                    <li class="list-group-item">
	                                    	<div class="row">
	                                           <div class="col-md-12">
	                                               <div class="custom-control custom-checkbox">
	                                                   <input type="checkbox" class="custom-control-input" id="customCheck3" name="ckbCalcular" value="true">
	                                                   <label class="custom-control-label" for="customCheck3">Salvar como novo cartão ?</label>
	                                               </div>
	                                           </div>
	                                           <div class="col-sm-3">
	                                            	<a class="btn btn-success" id="but"><i class="fa fa-plus"></i></a>
	                                            </div>
	                                        </div>
	                                        <div class="row" id="cartolin">
	                                            <div class="col-6">
	                                            <%
			                                    	sb = new StringBuilder();
			                                    	i=0;
			                                    	
			                                    	sb.append("<select id='cartolin' name='ddlCartoes' class='custom-select d-block' onchange='blockNewEndereco()'>");
			                                    	sb.append("<option value='0'>Selecione</option>");
			                                    	for(Cartao cart:Cartoes){
			                                    		i++;
			                                    		sb.append("<option value='");
			                                    		sb.append(cart.getsNumCartao());
			                                    		sb.append("'>" + cart.getsNumCartao() + "</option>");
			                                    	}
			                                    	sb.append("</select>");
			                                    	
			                                    	out.print(sb.toString());
	                                    		%>
	                                            </div>
	                                            <div class="col-md-3">
	                                            	<input class="form-control" type="number" step="any" min="0" name="valorApagar" placeholder="valor a pagar">
	                                            </div>
	                                        </div>
	                                        <div class="row" id="cartoes"></div>
	                                    </li>
	                                    <div id="newCartao" style="display: inline;">
	                                        <li class="list-group-item">
	                                            <div class="row">
	                                                <div class="col-md-9">
	                                                    <label>Número do Cartão</label>
	                                                    <input class="form-control" type="text" name="txtNumCartao" placeholder="Número do cartão">
	                                                </div>
	                                                <div class="col-md-3">
	                                                    <label>CVV</label>
	                                                    <input class="form-control" type="text" name="txtCodSeg" placeholder="Cod.">
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
	                                                                    <input type="radio" name="btnBandeira" id="btnBandeira" autocomplete="off" value="mastercard"><h1><i id="iconMaster" class="fa fa-cc-mastercard"></i></h1>
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
	                                            </div><br>
	                                            <div class="row">
	                                                <div class="col-md-12">
	                                                    <div class="custom-control custom-checkbox">
	                                                        <input type="checkbox" class="custom-control-input" id="customCheck2" name="ckbSalvarCartao" value="true">
	                                                        <label id="checkbox-salvar" class="custom-control-label" for="customCheck2">Salvar como novo cartão ?</label>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </li>
	                                    </div>
	                                </div>
	                                <div id="cupom" style="display: none;">
	                                    <div class="card-header bg-primary text-white text-uppercase bg-orange"><i class="fa fa-money"></i> Cupom</div>
	                                    <li class="list-group-item">
	                                        <div class="row">
	                                            <div class="col-md-6">
	                                                <select id="cupompon" class="custom-select" onchange="optionCheckCupom()">
	                                                    <option>Selecione</option>
	                                                    <option value="CT">Cupom de Troca</option>
	                                                    <option value="CP">Cupom Promocional</option>
	                                                </select>
	                                            </div>
	                                        </div>
	                                    </li>
	                                    <div id="CupomPromocional" style="display: none;">
	                                        <li id="cupP" class="list-group-item">
	                                            <div class="row">
	                                                <div class="col-md-6">
	                                                    <input class="form-control" type="text" name="txtCupomPromocional">
	                                                </div>
	                                            </div><br>
	                                        </li>
	                                        <li class="list-group-item">
	                                            <div class="row">
	                                                <div class="col-md-3">
	                                                    <button class="btn btn-success bg-orange" onclick="addCupom()"><i class="fa fa-plus"></i></button>
	                                                </div>
	                                            </div>
	                                        </li>
	                                    </div>
	                                    <div id="CupomTroca" style="display: none;">
	                                        <div id="cupT" class="col-12">
	                                            <div class="row">
	                                                <div class="col-md-6">
	                                                    <select class="form-control" name="ddlCupons" multiple>
	                                                       	<%
	                                                       		for(CupomTroca cp:cliente2.getCupons()){
	                                                       			sb = new StringBuilder();
	                                                       			
	                                                       			sb.append("<option value='"+cp.getId()+";"+cp.getValor()+"'>");
	                                                       			sb.append("Cupom "+cp.getId()+": R$ "+cp.getValor());
	                                                       			sb.append("</option>");
	                                                       			System.out.print(sb.toString());
	                                                       			out.print(sb.toString());
	                                                       		}
	                                                       	%>
	                                                    </select>
	                                                </div>
	                                            </div><br>
	                                        </div>
	                                    </div>
	                                </div>
	                            </ul>
	                        </div>
	                </div>
	            </div><br>
	            <div class="row">
	                <div class="col-6">
	                    <div class="card bg-light rounded box-shadow">
	                        <ul class="list-group category_block">
	                            <li class="list-group-item">
	                                <div class="row">
	                                    <div class="col-md-3">
	                                        <h1>Total:</h1>
	                                    </div>
	                                    <div class="col-md-9">
	                                        <h5 class="text-right">Compra: <label><%out.print(carrinho.getValorTotal()); %></label></h5>
	                                    </div>
	                                </div>
	                            </li>
	                            <li class="list-group-item">
	                                <div class="row">
	                                    <div class="col-md-12">
	                                        <h5 class="text-right">R$ <%out.print(carrinho.getFrete()+carrinho.getValorTotal()); %></h5>
	                                    </div>
	                                </div>
	                            </li>
	                        </ul>
	                    </div>
	                </div>
	            </div><br>
	            <div class="row">
	                    <div class="col-md-12">
	                        <div class="row">
	                            <div class="col-md-4">
	                                <a href="ClienteLogado.jsp" class="btn btn-block">Cancelar</a>
	                            </div>
	                            <div class="col-md-4"></div>
	                            <div class="col-md-4">
	                                <button id="finalizar-compra" name="operacao" value="FINALIZARCOMPRA" class="btn btn-success btn-block">Comprar</button>
	                            </div>
	                        </div>
	                    </div>
	            </div><br>
	        </div>
        </form>
        <script>
            function optionCheck(){
                document.getElementById("cupom").style.display ="none";
                document.getElementById("cartao").style.display ="none";
                var option = document.getElementById("options").value;
                if(option == "CA"){
                    document.getElementById("cartao").style.display ="inline";
                }else if(option == "CP"){
                    document.getElementById("cupom").style.display ="inline";
                }else if(option == "CC"){
                    document.getElementById("cupom").style.display ="inline";
                    document.getElementById("cartao").style.display ="inline";
                }
            }
        </script>
        <script>
            function optionCheckCupom(){
                document.getElementById("CupomTroca").style.display ="none";
                document.getElementById("CupomPromocional").style.display ="none";
                var option = document.getElementById("cupompon").value;
                if(option == "CT"){
                    document.getElementById("CupomTroca").style.display ="inline";
                }else if(option == "CP"){
                    document.getElementById("CupomPromocional").style.display ="inline";
                }
            }
        </script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
    </body>
</html>