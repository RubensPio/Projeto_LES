<%@page import="LES12018.core.aplicacao.Resultado"%>
<%@page import="les12018.dominio.EntidadeDominio"%>
<%@page import="les12018.dominio.*"%>
<%@page import="les12018.auxiliar.DadosParaCadastro"%>
<%@page import="les12018.dominio.Livro"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
	<title>Login</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="shortcut icon" href="imagens/logo_6ce_icon.ico" type="image/x-icon">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->
</head>
<body>
	
	<div class="limiter">
		<div class="container-login100" style="background-image: url('images/biblioteca.jpg');">
			<div class="wrap-login100">
				<form action="Login" class="login100-form validate-form" method="post">
					<span class="login100-form-logo">
						<i class="fa fa-user"></i>
					</span>

					<span class="login100-form-title p-b-34 p-t-27">
						Log in
					</span>

					<div class="wrap-input100 validate-input" data-validate = "Usu�rio">
						<input class="input100" type="text" name="txtemail" placeholder="Usu�rio">
						<span class="focus-input100" data-placeholder="&#xf207;"></span>
					</div>

					<div class="wrap-input100 validate-input" data-validate="Senha">
						<input class="input100" type="password" name="txtpasswd" placeholder="Senha">
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
					</div>

					<div class="contact100-form-checkbox ">
						<input hidden class="input-checkbox100" id="ckb1" type="checkbox" name="remember-me">
						<label hidden class="label-checkbox100" for="ckb1">
							Remember me
						</label>
					</div>

					<div class="container-login100-form-btn">
						<button type="submit" class="login100-form-btn" name="operacao" value="LOGAR">
							Login
						</button>
					</div>
				</form>
				<%
				    Resultado resultado = (Resultado) session.getAttribute("login");
				    if(resultado !=null && resultado.getMsg() != null){
				        out.print(resultado.getMsg());
				    }
				%>
				<div class="text-center p-t-90">
					<a id="registrar" href='cadastroCliente.jsp'>Registrar-se</a>	
				</div>
			</div>
		</div>
	</div>
	

	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>