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
                        <a class="navbar-brand" href="perfil.html">Bem Vindo, Souza</a>
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
                            <div class="card-header bg-primary text-white text-uppercase bg-orange"><i class="fa fa-shopping-basket"></i> Pedidos</div>
                            <ul class="list-group category_block">
                                <li class="list-group-item"><a href="pedidos.html">Todos os Pedidos</a></li>
                                <li class="list-group-item"><a href="pedido-troca.html">Pedidos de Troca</a></li>
                            </ul>
                        </div>
                        <div class="card bg-light mb-3">
                                <div class="card-header bg-primary text-white text-uppercase bg-orange"><i class="fa fa-male"></i> Dados</div>
                                <ul class="list-group category_block">
                                    <li class="list-group-item"><a href="perfil.html">Gerenciar Perfil</a></li>
                                    <li class="list-group-item"><a href="mudar-senha.html">Alterar Senha</a></li>
                                    <li class="list-group-item"><a href="cartoes.html">Gerenciar Cartoes</a></li>
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
                                            <th><h1><i class="fa fa-user"></i></h1></th>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td><h4>Email:</h4><label>souza@hotmail.com</label></tb>
                                            </tr>
                                            <tr>
                                                <td><h4>Data de Nascimento:</h4><label>10/07/1994</label></tb>
                                            </tr>
                                            <tr>
                                                <td><h4>Telefone:</h4><label>1148756251</label></tb>
                                            </tr>
                                            <tr>
                                                <td>Rank: 01</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
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
                                                    <tr>
                                                        <td><a href="alterar-endereco.html">Rua Matreira, 756, Sao Paulo, Brasil</a></td>
                                                    </tr>
                                                </tbody>
                                        </table>
                                </div>
                                <div class="table-responsive">
                                        <table class="table">
                                                <thead>
                                                    <th><h4> Enderecos</h4></th>
                                                    <th></th>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td><a href="#">Rua Seleiro, 766, Sao Paulo, Brasil</a></td>
                                                        <td><button class="btn btn-success"><i class="fa fa-minus"></i></button></td>
                                                    </tr>
                                                </tbody>
                                        </table>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div class="row">
                                <div class="col">
                                    <div></div>
                                    <form action="">
                                        <button class="btn btn-success" type="subimit"><i class="fa fa-plus"></i></a>
                                    </form><br>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
    </body>
</html>