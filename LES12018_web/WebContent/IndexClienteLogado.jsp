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
			StringBuilder sb;
		%>
    <header>
        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-orange">
            <div class="container">
                <a class="navbar-brand" href="IndexClienteLogado.html">
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
							sb.append("<a class='navbar-brand' href='SalvarCliente?txtId='");
							sb.append(cliente.getId());
							sb.append("&");
							sb.append("operacao='CONSULTAR'>");
							sb.append("Bem Vindo, ");
							sb.append(cliente.getsNome());
							sb.append("</a>");
							
							out.print(sb.toString());
						%>
                    </div>
                    <a class="btn btn-success btn-sm ml-3" href="carrinho.html">
                    <i class="fa fa-shopping-cart"></i> Carrinho
                    <span class="badge badge-light">3</span></a>
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
                                <div class="card-header bg-primary text-white text-uppercase bg-orange"><i class="fa fa-search"></i> Filtro</div>
                                <ul class="list-group category_block">
                                    <li class="list-group-item"><input id="txtTitulo" class="form-control" type="text" name="txtTitulo" placeholder="Titulo"></li>
                                    <li class="list-group-item"><input id="txtAno" class="form-control" type="text" name="txtAno" placeholder="Ano de Publicacao"></li>
                                    <li class="list-group-item"><input id="txtEdicao" class="form-control" type="text" name="txtEdicao" placeholder="Edicao"></li>
                                    <li class="list-group-item"><input id="txtISBN" class="form-control" type="text" name="txtISBN" placeholder="ISBN"></li>
                                    <li class="list-group-item"><select class="custom-select">
                                        <option>Selecione a categoria</option>
                                    </select></li>
                                    <li class="list-group-item"><select class="custom-select">
                                        <option>Selecione o Autor</option>
                                    </select></li>
                                    <li class="list-group-item"><select class="custom-select">
                                        <option>Selecione o Grupo de Precificacao</option>
                                    </select></li>
                                    <li class="list-group-item"><select class="custom-select">
                                        <option>Selecione o Status</option>
                                    </select></li>
                                    <li class="list-group-item"><input id="txtCodBarras" class="form-control" type="text" name="txtCodBarras" placeholder="Edicao"></li>
                                    <li class="list-group-item"><input id="txtDataCadastro" class="form-control" type="text" name="txtDataCadastro" placeholder="Edicao"></li>
                                    <li class="list-group-item"><input id="txtNumPag" class="form-control" type="text" name="txtNumPag" placeholder="Nº Paginas"></li>
                                    <li class="list-group-item"><input id="txtPreco" class="form-control" type="text" name="txtPreco" placeholder="Preco"></li>
                                    <li class="list-group-item"><input id="txtAltura" class="form-control" type="text" name="txtAltura" placeholder="Altura"></li>
                                    <li class="list-group-item"><input id="txtLargura" class="form-control" type="text" name="txtLargura" placeholder="Largura"></li>
                                    <li class="list-group-item"><input id="txtProfundidade" class="form-control" type="text" name="txtProfundidade" placeholder="Profundidade"></li>
                                    <li class="list-group-item"><input id="txtPeso" class="form-control" type="text" name="txtPeso" placeholder="Peso"></li>
                                    <li class="list-group-item"><button class="btn btn-success btn-block"><i class="fa fa-search"></i></button></li>
                                </ul>
                            </div>
                            
                        </div>
                        <div class="col">
                            <div class="row">
                                <div class="col-12 col-md-6 col-lg-4">
                                    <div class="card">
                                        <img class="card-img-top" src="https://dummyimage.com/600x400/55595c/fff" alt="Card image cap">
                                        <div class="card-body">
                                            <h4 class="card-title"><a href="livro.html" title="View Product">Product title</a></h4>
                                            <h6 class="card-title">Editora</h6>
                                            <p class="card-text"> 
                                                R$ 29,90 
                                                em ate 3x de R$ 10</p>
                                            <div class="row">
                                                <div class="col">
                                                    <h5 class="card-price">R$ 99,99</h5> 
                                                </div>
                                                <div class="col">
                                                    <a href="carrinho.html" class="btn btn-success btn-block">Adicionar ao Carrinho</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div><br>
                                
                                <!--<div class="col-12">
                                    <nav aria-label="...">
                                        <ul class="pagination">
                                            <li class="page-item disabled">
                                                <a class="page-link" href="#" tabindex="-1">Previous</a>
                                            </li>
                                            <li class="page-item"><a class="page-link" href="#">1</a></li>
                                            <li class="page-item active">
                                                <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
                                            </li>
                                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                                            <li class="page-item">
                                                <a class="page-link" href="#">Next</a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>-->
                
                    </div>
                </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </body>
</html>