<%@page import="les12018.dominio.*"%>
<%@page import="java.util.*"%>
<%@page import="LES12018.core.aplicacao.Resultado"%>
<%@page import="les12018.dominio.EntidadeDominio"%>

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
			Resultado resultado = (Resultado) session.getAttribute("resultado");
			List<EntidadeDominio> Cli = resultado.getEntidades();
			
			Cliente cliente = (Cliente)Cli.get(0);
			StringBuilder sb;
	%>
	<header>
        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-orange">
            <div class="container">
				<a class="navbar-brand" href="gerenciar_pedido.html">
					<img src="imagens/logo.png" width="30" height="30" class="d-inline-block align-top" alt="">
					TOPBOOKS
				</a>
				<div class="collapse navbar-collapse justify-content-end" id="navbarNav">
					<ul class="navbar-nav m-auto">
						<li class="nav-item">
							<a class="nav-link" href="gerenciar_pedido.html">Gerenciar Pedidos </a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="GerenciarLivro.jsp">Gerenciar Livro</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="gerenciarTroca.html">Gerenciar Trocas</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="..\admin\bootstrap-4.0.0\docs\4.0\examples\dashboard\graficos.html">An�lises</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="gerenciarEstoque.html">Gerenciar Estoque</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="gerenciarCliente.jsp">Gerenciar Cliente</a>
                        </li>
                        <li class="nav-item">
                    		<a class="nav-link" href="SalvarCliente?operacao=LOGOUT">Sair</a>
                        </li>
					</ul>
				</div>
			</div>
        </nav>
	</header>
	<body>
        <BR>
        <div class="container">
            <div class="row justify-content-end">
                <div class="col-12">
                    <h4 class="d-flex justify-content-between align-items-center mb-3">
                        <span class="text-muted">Filtro</span><br>
                    </h4>
                    <form action="SalvarCliente" method="post">
                        <div class="row">
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>Nome do Cliente</strong> </label> <br>
                                <input type="text" class="form-control" name="txtnome" placeholder="Ex: Manoel da Silva">
                            </div>
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>CPF</strong> </label> <br>
                                <input id="txISBN" class="form-control" type="text" name="txtcpf" placeholder="Ex: 470640752/43">
                            </div>
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>Email</strong> </label> <br>
                                <input id="txtCodBar" class="form-control" type="text" name="txtemail" placeholder="Ex: exemplo@email.com">
                            </div>
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>Telefone</strong> </label> <br>
                                <input id="txtTelefone" class="form-control" type="text" name="txttelefone" placeholder="Ex: 47999320">
                            </div>
                        </div>

                        <!-- Segunda linha de filtro-->
                        <div class="row">
                            <div class="col-md-3">
                                <label id="dtCad"> <strong>Data de Nascimento</strong></label>
                                <input class="form-control" type="date" name="clDataNasc">
                            </div>
                            <div class="col-md-3">
                                <label><strong>Ranking</strong></label>
                                <input id="txtRanking" class="form-control" type="text" name="txtRanking" placeholder="Ex: 1...2....3">
                            </div>
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>G�nero</strong> </label> <br>
                                <select class="custom-select d-block" id="ddlGenero" name="ddlGenero">
                                    <option value="0" selected>Escolha...</option>
                                    <option value="M">Masculino</option>
                                    <option value="F">Feminino</option>
                                </select>   
                            </div>
                            <div class="col-md-3">
                                <label id="dtCad"> <strong>Data de Cadastro</strong></label>
                                <input class="form-control" type="date" name="dtDataCad">
                            </div>
                        </div>
                        
                        <!-- Terceira linha de filtro -->
                        <div class="row">
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>Estado</strong> </label> 
                                <select class="custom-select d-block" name="ddlestado">
                                	<option value='0' selected>Selecione...</option>
									<option value="AC">Acre</option>
									<option value="AL">Alagoas</option>
									<option value="AP">Amap�</option>
									<option value="AM">Amazonas</option>
									<option value="BA">Bahia</option>
									<option value="CE">Cear�</option>
									<option value="DF">Distrito Federal</option>
									<option value="ES">Esp�rito Santo</option>
									<option value="GO">Goi�s</option>
									<option value="MA">Maranh�o</option>
									<option value="MT">Mato Grosso</option>
									<option value="MS">Mato Grosso do Sul</option>
									<option value="MG">Minas Gerais</option>
									<option value="PA">Par�</option>
									<option value="PB">Para�ba</option>
									<option value="PR">Paran�</option>
									<option value="PE">Pernambuco</option>
									<option value="PI">Piau�</option>
									<option value="RJ">Rio de Janeiro</option>
									<option value="RN">Rio Grande do Norte</option>
									<option value="RS">Rio Grande do Sul</option>
									<option value="RO">Rond�nia</option>
									<option value="RR">Roraima</option>
									<option value="SC">Santa Catarina</option>
									<option value="SP">S�o Paulo</option>
									<option value="SE">Sergipe</option>
									<option value="TO">Tocantins</option>
								</select>    
                            </div>
                            <div class="col-md-3">
                                <label id="label-categoria"> <strong>Cidade</strong> </label> 
                                <input id="txtCidade" class="form-control" type="text" name="ddlcidade" placeholder="Ex: S�o Paulo">
                            </div>
                            <!-- 
                            <div class="col-md-3">
                            	<label id="label-categoria"><strong>País</strong> </label>
                            	<select class="custom-select d-block" name="ddlEstado">
                            		<option value='0' selected>Selecione...</option><option value='AF' >Afeganistão</option><option value='ZA' >África do Sul</option><option value='AL' >Albânia</option><option value='DE' >Alemanha</option><option value='AD' >Andorra</option><option value='AO' >Angola</option><option value='AI' >Anguilla</option><option value='AQ' >Antártida</option><option value='AG' >Antígua e Barbuda</option><option value='AN' >Antilhas Holandesas</option><option value='SA' >Arábia Saudita</option><option value='DZ' >Argélia</option><option value='AR' >Argentina</option><option value='AM' >Armênia</option><option value='AW' >Aruba</option><option value='AU' >Austrália</option><option value='AT' >Áustria</option><option value='AZ' >Azerbaijão</option><option value='BS' >Bahamas</option><option value='BH' >Bahrein</option><option value='BD' >Bangladesh</option><option value='BB' >Barbados</option><option value='BE' >Bélgica</option><option value='BZ' >Belize</option><option value='BJ' >Benin</option><option value='BM' >Bermudas</option><option value='BY' >Bielorrússia</option><option value='BO' >Bolívia</option><option value='BA' >Bósnia e Herzegovina</option><option value='BW' >Botsuana</option><option value='BR'>Brasil</option><option value='BN' >Brunei</option><option value='BG' >Bulgária</option><option value='BF' >Burquina Faso</option><option value='BI' >Burundi</option><option value='BT' >Butão</option><option value='CV' >Cabo Verde</option><option value='KH' >Camboja</option><option value='CA' >Canadá</option><option value='QA' >Catar</option><option value='KZ' >Cazaquistão</option><option value='TD' >Chade</option><option value='CL' >Chile</option><option value='CN' >China</option><option value='CY' >Chipre</option><option value='VA' >Cidade do Vaticano</option><option value='SG' >Cingapura</option><option value='CO' >Colômbia</option><option value='KM' >Comores</option><option value='CG' >Congo - Brazzaville</option><option value='CD' >Congo - Kinshasa</option><option value='KP' >Coreia do Norte</option><option value='KR' >Coreia do Sul</option><option value='CR' >Costa Rica</option><option value='CI' >Costa do Marfim</option><option value='HR' >Croácia</option><option value='CU' >Cuba</option><option value='DK' >Dinamarca</option><option value='DJ' >Djibuti</option><option value='DM' >Dominica</option><option value='EG' >Egito</option><option value='SV' >El Salvador</option><option value='AE' >Emirados Árabes Unidos</option><option value='EC' >Equador</option><option value='ER' >Eritreia</option><option value='SK' >Eslováquia</option><option value='SI' >Eslovênia</option><option value='ES' >Espanha</option><option value='US' >Estados Unidos</option><option value='EE' >Estônia</option><option value='ET' >Etiópia</option><option value='FJ' >Fiji</option><option value='PH' >Filipinas</option><option value='FI' >Finlândia</option><option value='FR' >França</option><option value='GA' >Gabão</option><option value='GM' >Gâmbia</option><option value='GH' >Gana</option><option value='GE' >Geórgia</option><option value='GS' >Geórgia do Sul e Ilhas Sandwich do Sul</option><option value='GI' >Gibraltar</option><option value='GD' >Granada</option><option value='GR' >Grécia</option><option value='GL' >Groênlandia</option><option value='GP' >Guadalupe</option><option value='GU' >Guam</option><option value='GT' >Guatemala</option><option value='GG' >Guernsey</option><option value='GY' >Guiana</option><option value='GF' >Guiana Francesa</option><option value='GN' >Guiné</option><option value='GW' >Guiné Bissau</option><option value='GQ' >Guiné Equatorial</option><option value='HT' >Haiti</option><option value='NL' >Holanda</option><option value='HN' >Honduras</option><option value='HK' >Hong Kong, RAE da China</option><option value='HU' >Hungria</option><option value='YE' >Iêmen</option><option value='BV' >Ilha Bouvet</option><option value='HM' >Ilha Heard e Ilhas McDonald</option><option value='NF' >Ilha Norfolk</option><option value='IM' >Ilha de Man</option><option value='AX' >Ilhas Åland</option><option value='KY' >Ilhas Caiman</option><option value='CC' >Ilhas Coco</option><option value='CK' >Ilhas Cook</option><option value='UM' >Ilhas Distantes dos EUA</option><option value='FO' >Ilhas Faroe</option><option value='FK' >Ilhas Malvinas</option><option value='MP' >Ilhas Marianas do Norte</option><option value='MH' >Ilhas Marshall</option><option value='CX' >Ilhas Natal</option><option value='PN' >Ilhas Pitcairn</option><option value='SB' >Ilhas Salomão</option><option value='TC' >Ilhas Turks e Caicos</option><option value='VG' >Ilhas Virgens Britânicas</option><option value='VI' >Ilhas Virgens dos EUA</option><option value='IN' >Índia</option><option value='ID' >Indonésia</option><option value='IR' >Irã</option><option value='IQ' >Iraque</option><option value='IE' >Irlanda</option><option value='IS' >Islândia</option><option value='IL' >Israel</option><option value='IT' >Itália</option><option value='JM' >Jamaica</option><option value='JP' >Japão</option><option value='JE' >Jersey</option><option value='JO' >Jordânia</option><option value='KW' >Kuwait</option><option value='LA' >Laos</option><option value='LS' >Lesoto</option><option value='LV' >Letônia</option><option value='LB' >Líbano</option><option value='LR' >Libéria</option><option value='LY' >Líbia</option><option value='LI' >Liechtenstein</option><option value='LT' >Lituânia</option><option value='LU' >Luxemburgo</option><option value='MO' >Macau, RAE da China</option><option value='MK' >Macedônia</option><option value='MG' >Madagascar</option><option value='MY' >Malásia</option><option value='MW' >Malawi</option><option value='MV' >Maldivas</option><option value='ML' >Mali</option><option value='MT' >Malta</option><option value='MA' >Marrocos</option><option value='MQ' >Martinica</option><option value='MU' >Maurício</option><option value='MR' >Mauritânia</option><option value='YT' >Mayotte</option><option value='MX' >México</option><option value='MM' >Mianmar (Birmânia)</option><option value='FM' >Micronésia</option><option value='MZ' >Moçambique</option><option value='MD' >Moldávia</option><option value='MC' >Mônaco</option><option value='MN' >Mongólia</option><option value='ME' >Montenegro</option><option value='MS' >Montserrat</option><option value='NA' >Namíbia</option><option value='NR' >Nauru</option><option value='NP' >Nepal</option><option value='NI' >Nicarágua</option><option value='NE' >Níger</option><option value='NG' >Nigéria</option><option value='NU' >Niue</option><option value='NO' >Noruega</option><option value='NC' >Nova Caledônia</option><option value='NZ' >Nova Zelândia</option><option value='OM' >Omã</option><option value='PW' >Palau</option><option value='PA' >Panamá</option><option value='PG' >Papua-Nova Guiné</option><option value='PK' >Paquistão</option><option value='PY' >Paraguai</option><option value='PE' >Peru</option><option value='PF' >Polinésia Francesa</option><option value='PL' >Polônia</option><option value='PR' >Porto Rico</option><option value='PT' >Portugal</option><option value='KE' >Quênia</option><option value='KG' >Quirguistão</option><option value='KI' >Quiribati</option><option value='GB' >Reino Unido</option><option value='CF' >República Centro-Africana</option><option value='DO' >República Dominicana</option><option value='CZ' >República Tcheca</option><option value='CM' >República dos Camarões</option><option value='RE' >Reunião</option><option value='RO' >Romênia</option><option value='RW' >Ruanda</option><option value='RU' >Rússia</option><option value='EH' >Saara Ocidental</option><option value='PM' >Saint Pierre e Miquelon</option><option value='WS' >Samoa</option><option value='AS' >Samoa Americana</option><option value='SM' >San Marino</option><option value='SH' >Santa Helena</option><option value='LC' >Santa Lúcia</option><option value='BL' >São Bartolomeu</option><option value='KN' >São Cristovão e Nevis</option><option value='MF' >São Martinho</option><option value='ST' >São Tomé e Príncipe</option><option value='VC' >São Vicente e Granadinas</option><option value='SN' >Senegal</option><option value='SL' >Serra Leoa</option><option value='RS' >Sérvia</option><option value='SC' >Seychelles</option><option value='SY' >Síria</option><option value='SO' >Somália</option><option value='LK' >Sri Lanka</option><option value='SZ' >Suazilândia</option><option value='SD' >Sudão</option><option value='SE' >Suécia</option><option value='CH' >Suíça</option><option value='SR' >Suriname</option><option value='SJ' >Svalbard e Jan Mayen</option><option value='TJ' >Tadjiquistão</option><option value='TH' >Tailândia</option><option value='TW' >Taiwan</option><option value='TZ' >Tanzânia</option><option value='IO' >Território Britânico do Oceano Índico</option><option value='TF' >Territórios Franceses do Sul</option><option value='PS' >Territórios palestinos</option><option value='TL' >Timor-Leste</option><option value='TG' >Togo</option><option value='TK' >Tokelau</option><option value='TO' >Tonga</option><option value='TT' >Trinidad e Tobago</option><option value='TN' >Tunísia</option><option value='TM' >Turcomenistão</option><option value='TR' >Turquia</option><option value='TV' >Tuvalu</option><option value='UA' >Ucrânia</option><option value='UG' >Uganda</option><option value='UY' >Uruguai</option><option value='UZ' >Uzbequistão</option><option value='VU' >Vanuatu</option><option value='VE' >Venezuela</option><option value='VN' >Vietnã</option><option value='WF' >Wallis e Futuna</option><option value='ZM' >Zâmbia</option><option value='ZW' >Zimbábue</option>
                            	</select>
                            </div>
                             -->
                            <div class="col-md-3">
                            	<label id="label-categoria" ><strong>Status</strong></label>
                            	<select class="custom-select d-block" name="ckbisAtivo">
                                 	<option value="todos">Todos</option>
                                 	<option value="true">Ativo</option>
                                 	<option value="false">Inativo</option>
                          		</select>
                        	</div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-3">
                                <label></label><br>
                                <button type='submit' class='btn btn-success btn-lg btn-block bg-orange' value="CONSULTAR" name='operacao'>FILTRAR</button>
                                <input type="hidden" name="target" value="gerenciarCliente.jsp">
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
                            <th scope="col">ID</th>
                            <th scope="col">Nome do Cliente</th>
                            <th scope="col">CPF</th>
                            <th scope="col">Email</th>
                            <th scope="col">Data de Nascimento</th>
                            <th scope="col">Status</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                    	<%
					    try{
					    	if(resultado != null) {
					    		List<EntidadeDominio> entidades = resultado.getEntidades();
					    		StringBuilder sbRegistro = new StringBuilder();
					    		StringBuilder sbLink = new StringBuilder();
					    		Cliente clin;
					    		
					    		if(entidades != null) {
					    			for(EntidadeDominio ent: Cli) {
					    				clin = (Cliente)ent;
					    				sbRegistro = new StringBuilder();
							    		sbLink = new StringBuilder();
					    				
					    				sbRegistro.append("<tr>");
					    				
					    				sbLink.append("<a href=SalvarCliente?");
						    				sbLink.append("txtId=");
						    				sbLink.append(clin.getId());
						    				sbLink.append("&");
						    				sbLink.append("operacao=");
						    				sbLink.append("VISUALIZAR");
					    				sbLink.append(">");
					    				
					    				sbRegistro.append("<td>");
					    				sbRegistro.append(sbLink.toString());
					    				sbRegistro.append(clin.getId());
					    				sbRegistro.append("<a/>");
					    				sbRegistro.append("</td>");
					    				
					    				sbRegistro.append("<td>");
					    				sbRegistro.append(sbLink.toString());
					    				sbRegistro.append(clin.getsNome());
					    				sbRegistro.append("</a>");
					    				sbRegistro.append("</td>");
					    				
					    				sbRegistro.append("<td>");
					    				sbRegistro.append(clin.getsCPF());
					    				sbRegistro.append("</td>");
					    				
					    				sbRegistro.append("<td>");
					    				sbRegistro.append(clin.getsEmail());
					    				sbRegistro.append("</td>");
					    				
					    				sbRegistro.append("<td>");
					    				sbRegistro.append(clin.getDtDataNasc());
					    				sbRegistro.append("</td>");
					    				
					    				if(clin.getFlgAtivo() == true){
					    					sbRegistro.append("<td>");
						    				sbRegistro.append("<a class='btn btn-success btn-lg btn-block'"); 
						    				sbRegistro.append("href='SalvarCliente?txtId=");
						    				sbRegistro.append(clin.getId());
						    				sbRegistro.append("&");
						    				sbRegistro.append("operacao=EXCLUIR&target=gerenciarCliente.jsp'>");
						    				sbRegistro.append("Desativar Cliente</a>");
						    				sbRegistro.append("</td>");
					    				}else if(clin.getFlgAtivo() == false){
					    					sbRegistro.append("<td>");
						    				sbRegistro.append("<a class='btn btn-success btn-lg btn-block'"); 
						    				sbRegistro.append("href='SalvarCliente?txtId=");
						    				sbRegistro.append(clin.getId());
						    				sbRegistro.append("&");
						    				sbRegistro.append("operacao=ATIVAR&target=gerenciarCliente.jsp'>");
						    				sbRegistro.append("Ativar Cliente</a>");
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
            <div class="row col-md-3" style="margin-left: 900px;">
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>	
</html>