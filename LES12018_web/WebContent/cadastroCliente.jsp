<DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="main.css">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
        <meta charset="UTF-8">
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <form action="SalvarCliente" method="post" id="fileForm" role="form">
                    <fieldset><legend class="text-left">Cadastro <span class="req"></span></legend>
        
                        <!--Nome do cliente -->
                        <div class="form-group">
                        <label for="nome"><span class="req"></span> Nome * </label>
                                <input required type="text" name="txtnome" id="nome" class="form-control" maxlength="50" onkeyup="Validate(this);" placeholder="Ex: João da Silva"/> 
                        </div>
            			
            			<!-- Gênero -->
            			<div class="form-group">
                            <label for="gênero"><span class="req"> </span> Gênero *  </label> 
                                <select class="form-control" type="text" name="ddlGenero" id = "pais" required>
                                	<option>Selecione...</option>
                                	<option value="M">Masculino</option>
                                	<option value="F">Feminino</option>
                                </select>  
                                    <div id="errLast"></div>
                        </div>
                        
                        <!--CPF do cliente -->
                        <div class="form-group"> 	 
                            <label for="cpf"><span class="req"> </span> CPF * </label>
                                <input class="form-control" type="text" name="txtcpf" id = "cpf" maxlength="14" required placeholder="Digite apenas números" /> 
                                    <div id="errFirst"></div>    
                        </div>
            
                        <!--Data de nascimento do cliente -->
                        <div class="form-group">
                            <label for="dataNasc"><span class="req"> </span> Data de Nascimento * </label><br>
                            <input class="form-control" type="date" name="clDataNasc">
                        </div>
                        
                        <!--Email do cliente -->
                        <div class="form-group">
                            <label for="email"><span class="req"> </span> Email * </label> 
                                <input class="form-control" required type="text" name="txtemail" id = "email"  onchange="email_validate(this.value);" placeholder="Ex: joao.silva@seuemail.com"/>   
                                    <div class="status" id="status"></div>
                        </div>
            
                        <!--Telefone do cliente -->
                        <div class="form-group">
                            <label for="telefone"><span class="req"> </span> Telefone *  </label> 
                                <input class="form-control" type="text" name="txttelefone" id = "telefone" maxlength="15"  placeholder="Ex: (11) 91234-5678 " required />  
                                    <div id="errLast"></div>
                        </div>
            
                        <!--PaÃ­s do cliente -->
                        <div class="form-group">
                                <label for="pais"><span class="req"> </span> País *  </label> 
                                    <select class="form-control" type="text" name="txtpais" id = "pais" required>
                                        <option value="Brasil">Brasil</option> 
                                    <!-- <option value=''>Selecione...</option><option value='AF' >AfeganistÃ£o</option><option value='ZA' >Ã�frica do Sul</option><option value='AL' >AlbÃ¢nia</option><option value='DE' >Alemanha</option><option value='AD' >Andorra</option><option value='AO' >Angola</option><option value='AI' >Anguilla</option><option value='AQ' >AntÃ¡rtida</option><option value='AG' >AntÃ­gua e Barbuda</option><option value='AN' >Antilhas Holandesas</option><option value='SA' >ArÃ¡bia Saudita</option><option value='DZ' >ArgÃ©lia</option><option value='AR' >Argentina</option><option value='AM' >ArmÃªnia</option><option value='AW' >Aruba</option><option value='AU' >AustrÃ¡lia</option><option value='AT' >Ã�ustria</option><option value='AZ' >AzerbaijÃ£o</option><option value='BS' >Bahamas</option><option value='BH' >Bahrein</option><option value='BD' >Bangladesh</option><option value='BB' >Barbados</option><option value='BE' >BÃ©lgica</option><option value='BZ' >Belize</option><option value='BJ' >Benin</option><option value='BM' >Bermudas</option><option value='BY' >BielorrÃºssia</option><option value='BO' >BolÃ­via</option><option value='BA' >BÃ³snia e Herzegovina</option><option value='BW' >Botsuana</option><option value='BR' selected>Brasil</option><option value='BN' >Brunei</option><option value='BG' >BulgÃ¡ria</option><option value='BF' >Burquina Faso</option><option value='BI' >Burundi</option><option value='BT' >ButÃ£o</option><option value='CV' >Cabo Verde</option><option value='KH' >Camboja</option><option value='CA' >CanadÃ¡</option><option value='QA' >Catar</option><option value='KZ' >CazaquistÃ£o</option><option value='TD' >Chade</option><option value='CL' >Chile</option><option value='CN' >China</option><option value='CY' >Chipre</option><option value='VA' >Cidade do Vaticano</option><option value='SG' >Cingapura</option><option value='CO' >ColÃ´mbia</option><option value='KM' >Comores</option><option value='CG' >Congo - Brazzaville</option><option value='CD' >Congo - Kinshasa</option><option value='KP' >Coreia do Norte</option><option value='KR' >Coreia do Sul</option><option value='CR' >Costa Rica</option><option value='CI' >Costa do Marfim</option><option value='HR' >CroÃ¡cia</option><option value='CU' >Cuba</option><option value='DK' >Dinamarca</option><option value='DJ' >Djibuti</option><option value='DM' >Dominica</option><option value='EG' >Egito</option><option value='SV' >El Salvador</option><option value='AE' >Emirados Ã�rabes Unidos</option><option value='EC' >Equador</option><option value='ER' >Eritreia</option><option value='SK' >EslovÃ¡quia</option><option value='SI' >EslovÃªnia</option><option value='ES' >Espanha</option><option value='US' >Estados Unidos</option><option value='EE' >EstÃ´nia</option><option value='ET' >EtiÃ³pia</option><option value='FJ' >Fiji</option><option value='PH' >Filipinas</option><option value='FI' >FinlÃ¢ndia</option><option value='FR' >FranÃ§a</option><option value='GA' >GabÃ£o</option><option value='GM' >GÃ¢mbia</option><option value='GH' >Gana</option><option value='GE' >GeÃ³rgia</option><option value='GS' >GeÃ³rgia do Sul e Ilhas Sandwich do Sul</option><option value='GI' >Gibraltar</option><option value='GD' >Granada</option><option value='GR' >GrÃ©cia</option><option value='GL' >GroÃªnlandia</option><option value='GP' >Guadalupe</option><option value='GU' >Guam</option><option value='GT' >Guatemala</option><option value='GG' >Guernsey</option><option value='GY' >Guiana</option><option value='GF' >Guiana Francesa</option><option value='GN' >GuinÃ©</option><option value='GW' >GuinÃ© Bissau</option><option value='GQ' >GuinÃ© Equatorial</option><option value='HT' >Haiti</option><option value='NL' >Holanda</option><option value='HN' >Honduras</option><option value='HK' >Hong Kong, RAE da China</option><option value='HU' >Hungria</option><option value='YE' >IÃªmen</option><option value='BV' >Ilha Bouvet</option><option value='HM' >Ilha Heard e Ilhas McDonald</option><option value='NF' >Ilha Norfolk</option><option value='IM' >Ilha de Man</option><option value='AX' >Ilhas Ã…land</option><option value='KY' >Ilhas Caiman</option><option value='CC' >Ilhas Coco</option><option value='CK' >Ilhas Cook</option><option value='UM' >Ilhas Distantes dos EUA</option><option value='FO' >Ilhas Faroe</option><option value='FK' >Ilhas Malvinas</option><option value='MP' >Ilhas Marianas do Norte</option><option value='MH' >Ilhas Marshall</option><option value='CX' >Ilhas Natal</option><option value='PN' >Ilhas Pitcairn</option><option value='SB' >Ilhas SalomÃ£o</option><option value='TC' >Ilhas Turks e Caicos</option><option value='VG' >Ilhas Virgens BritÃ¢nicas</option><option value='VI' >Ilhas Virgens dos EUA</option><option value='IN' >Ã�ndia</option><option value='ID' >IndonÃ©sia</option><option value='IR' >IrÃ£</option><option value='IQ' >Iraque</option><option value='IE' >Irlanda</option><option value='IS' >IslÃ¢ndia</option><option value='IL' >Israel</option><option value='IT' >ItÃ¡lia</option><option value='JM' >Jamaica</option><option value='JP' >JapÃ£o</option><option value='JE' >Jersey</option><option value='JO' >JordÃ¢nia</option><option value='KW' >Kuwait</option><option value='LA' >Laos</option><option value='LS' >Lesoto</option><option value='LV' >LetÃ´nia</option><option value='LB' >LÃ­bano</option><option value='LR' >LibÃ©ria</option><option value='LY' >LÃ­bia</option><option value='LI' >Liechtenstein</option><option value='LT' >LituÃ¢nia</option><option value='LU' >Luxemburgo</option><option value='MO' >Macau, RAE da China</option><option value='MK' >MacedÃ´nia</option><option value='MG' >Madagascar</option><option value='MY' >MalÃ¡sia</option><option value='MW' >Malawi</option><option value='MV' >Maldivas</option><option value='ML' >Mali</option><option value='MT' >Malta</option><option value='MA' >Marrocos</option><option value='MQ' >Martinica</option><option value='MU' >MaurÃ­cio</option><option value='MR' >MauritÃ¢nia</option><option value='YT' >Mayotte</option><option value='MX' >MÃ©xico</option><option value='MM' >Mianmar (BirmÃ¢nia)</option><option value='FM' >MicronÃ©sia</option><option value='MZ' >MoÃ§ambique</option><option value='MD' >MoldÃ¡via</option><option value='MC' >MÃ´naco</option><option value='MN' >MongÃ³lia</option><option value='ME' >Montenegro</option><option value='MS' >Montserrat</option><option value='NA' >NamÃ­bia</option><option value='NR' >Nauru</option><option value='NP' >Nepal</option><option value='NI' >NicarÃ¡gua</option><option value='NE' >NÃ­ger</option><option value='NG' >NigÃ©ria</option><option value='NU' >Niue</option><option value='NO' >Noruega</option><option value='NC' >Nova CaledÃ´nia</option><option value='NZ' >Nova ZelÃ¢ndia</option><option value='OM' >OmÃ£</option><option value='PW' >Palau</option><option value='PA' >PanamÃ¡</option><option value='PG' >Papua-Nova GuinÃ©</option><option value='PK' >PaquistÃ£o</option><option value='PY' >Paraguai</option><option value='PE' >Peru</option><option value='PF' >PolinÃ©sia Francesa</option><option value='PL' >PolÃ´nia</option><option value='PR' >Porto Rico</option><option value='PT' >Portugal</option><option value='KE' >QuÃªnia</option><option value='KG' >QuirguistÃ£o</option><option value='KI' >Quiribati</option><option value='GB' >Reino Unido</option><option value='CF' >RepÃºblica Centro-Africana</option><option value='DO' >RepÃºblica Dominicana</option><option value='CZ' >RepÃºblica Tcheca</option><option value='CM' >RepÃºblica dos CamarÃµes</option><option value='RE' >ReuniÃ£o</option><option value='RO' >RomÃªnia</option><option value='RW' >Ruanda</option><option value='RU' >RÃºssia</option><option value='EH' >Saara Ocidental</option><option value='PM' >Saint Pierre e Miquelon</option><option value='WS' >Samoa</option><option value='AS' >Samoa Americana</option><option value='SM' >San Marino</option><option value='SH' >Santa Helena</option><option value='LC' >Santa LÃºcia</option><option value='BL' >SÃ£o Bartolomeu</option><option value='KN' >SÃ£o CristovÃ£o e Nevis</option><option value='MF' >SÃ£o Martinho</option><option value='ST' >SÃ£o TomÃ© e PrÃ­ncipe</option><option value='VC' >SÃ£o Vicente e Granadinas</option><option value='SN' >Senegal</option><option value='SL' >Serra Leoa</option><option value='RS' >SÃ©rvia</option><option value='SC' >Seychelles</option><option value='SY' >SÃ­ria</option><option value='SO' >SomÃ¡lia</option><option value='LK' >Sri Lanka</option><option value='SZ' >SuazilÃ¢ndia</option><option value='SD' >SudÃ£o</option><option value='SE' >SuÃ©cia</option><option value='CH' >SuÃ­Ã§a</option><option value='SR' >Suriname</option><option value='SJ' >Svalbard e Jan Mayen</option><option value='TJ' >TadjiquistÃ£o</option><option value='TH' >TailÃ¢ndia</option><option value='TW' >Taiwan</option><option value='TZ' >TanzÃ¢nia</option><option value='IO' >TerritÃ³rio BritÃ¢nico do Oceano Ã�ndico</option><option value='TF' >TerritÃ³rios Franceses do Sul</option><option value='PS' >TerritÃ³rios palestinos</option><option value='TL' >Timor-Leste</option><option value='TG' >Togo</option><option value='TK' >Tokelau</option><option value='TO' >Tonga</option><option value='TT' >Trinidad e Tobago</option><option value='TN' >TunÃ­sia</option><option value='TM' >TurcomenistÃ£o</option><option value='TR' >Turquia</option><option value='TV' >Tuvalu</option><option value='UA' >UcrÃ¢nia</option><option value='UG' >Uganda</option><option value='UY' >Uruguai</option><option value='UZ' >UzbequistÃ£o</option><option value='VU' >Vanuatu</option><option value='VE' >Venezuela</option><option value='VN' >VietnÃ£</option><option value='WF' >Wallis e Futuna</option><option value='ZM' >ZÃ¢mbia</option><option value='ZW' >ZimbÃ¡bue</option> -->
                                    </select>
                                        <div id="errLast"></div>
                        </div>

                        <!--CEP do cliente -->
                        <div class="form-group">
                        	<div class="row">
                        		<div class="col-md-6">
	                                <label for="cep"><span class="req"> </span> CEP *  </label> 
	                                    <input class="form-control" type="text" name="txtcep" id = "cep" maxlength="8"  placeholder="Ex: Digite apenas números" required />  
	                                        <div id="errLast"></div>
                                </div>
                                <div class="col-md-6">
                                	<label for="cep"><span class="req"> </span> Bairro *  </label> 
	                                    <input class="form-control" type="text" name="txtBairro"  placeholder="Ex: Jd Esperanca" required />  
	                                        <div id="errLast"></div>
                                </div>
                            </div>
                        </div>

                        <!--Rua do cliente -->
                        <div class="form-group">
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
		                                <input class="form-control" type="text" name="txtrua" id = "rua" maxlength="50"  placeholder="Ex: Rua Bonita" required />  
		                                    <div id="errLast"></div>
	                             </div>
                            </div>
                        </div>

                        <!--Linha contendo número da casa, Complemento, Estado e Cidade do cliente -->
                        <div class="form-group ">
                            <div class="row">
                                <div class="col-md-3">
                                <label for="num"><span class="req"> </span> Número *  </label> 
                                    <input class="form-control" type="text" name="txtnum" id = "num" maxlength="50"  placeholder="Ex: 267" required />  
                                        <div id="errLast"></div>
                            </div>
                            
                            <div class="col-md-3">
                                <label for="comp"><span class="req"> </span> Complemento *  </label> 
                                    <input class="form-control" type="text" name="txtcomp" id = "comp" maxlength="50"  placeholder="Ex: 267" />  
                                        <div id="errLast"></div>
                            </div>
                        
                            <div class="col-md-3">
                                <label for="estado"><span class="req"> </span> Estado *  </label> 
                                    <select class="form-control" type="text" name="ddlestado" id = "estado" required>
                                        <option value="SP">São Paulo</option> 
                                    </select>
                                        <div id="errLast"></div>
                            </div>

                            <div class="col-md-3">
                                    <label for="cidade"><span class="req"> </span> Cidade *  </label> 
                                        <select class="form-control" type="text" name="ddlcidade" id = "cidade" required>
                                            <option value="São Paulo">São Paulo</option> 
                                        </select>
                                            <div id="errLast"></div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="password"><span class="req"> </span>Senha * </label>
                                <input required name="txtpasswd" type="password" class="form-control inputpass" minlength="4" maxlength="16"  id="pass1" placeholder="Digite sua senha" />
                                    <div id="errLast"></div>
                            <label for="password"><span class="req"> </span> Confirmar Senha * </label>
                                <input required name="password" type="password" class="form-control inputpass" minlength="4" maxlength="16" placeholder="Digite novamente para validar"  id="pass2" onkeyup="checkPass(); return false;" />
                                    <span id="confirmMessage" class="confirmMessage"></span>
                                        <div id="errLast"></div>
                        </div>
            
                        <div class="form-group">
                            <input class="btn btn-success bg-orange" type="submit" name="operacao" value="SALVAR">
                        </div>
                    </fieldset>
                        </form><!-- ends register form -->
            
                    </div><!-- ends col-6 -->
                    
                        <div style="font-family:Helvetica Neue; font-size: 20px;" class="col-md-6">
                            <h1 class="page-header">TOPBOOKS </h1>
                            <p>É necessário se cadastrar para adquirir produtos em nossa loja. <br>Realizando o cadastro permite que você salve seus endereços para entrega e seus cartões para serem utilizados em compras futuras, além de receber cupons para descontos em outros livros! </p>
                            
                        </div>
                
            </div>
        </div>
    </body>    
</html>