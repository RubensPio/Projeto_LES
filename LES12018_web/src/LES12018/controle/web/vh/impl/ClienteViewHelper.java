package LES12018.controle.web.vh.impl;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sun.corba.se.spi.orb.ParserData;

import LES12018.controle.web.vh.IViewHelper;
import LES12018.core.aplicacao.Resultado;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.Livro;
import les12018.dominio.Cliente;
import les12018.dominio.Cartao;
import les12018.dominio.Endereco;

public class ClienteViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		Cliente cliente = new Cliente();
		
		System.out.println(operacao);
		
		String Senha = "";
		String Email = "";
		int id = 0;
		if(operacao.equals("LOGOUT")) {
			return cliente;
		}else if(operacao.equals("EXCLUIR")) {
			try {
				id = Integer.parseInt(request.getParameter("txtId"));
				cliente.setId(id);
				cliente.setEnderecos(new ArrayList<Endereco>());
				cliente.setCartoes(new ArrayList<Cartao>());
				cliente.getEnderecos().add(new Endereco());
				cliente.getCartoes().add(new Cartao());
				
				try {
					cliente.getEnderecos().get(0).setCEP(request.getParameter("txtcep"));
					cliente.getEnderecos().get(0).setNumerologradouro(request.getParameter("txtnum"));
				}catch (Exception e) {
					// TODO: handle exception
				}
				
				try {
					cliente.getCartoes().get(0).setsNumCartao(request.getParameter("txtNumCartao"));
				}catch (Exception e) {
					// TODO: handle exception
				}
			}catch (Exception e) {
				// TODO: handle exception
			}
			return cliente;
		}else if(operacao.equals("ALTERAR") && request.getParameter("txtSenhaNova") != null) {
			String NovaSenha = "";
			try {
				NovaSenha = request.getParameter("txtSenhaNova");
				Senha = request.getParameter("txtpasswd");
				id = Integer.parseInt(request.getParameter("txtId"));
				cliente.setsSenha(Senha);
				cliente.setNovaSenha(NovaSenha);
				cliente.setId(id);
				cliente.setEnderecos(new ArrayList<Endereco>());
				cliente.setCartoes(new ArrayList<Cartao>());
				cliente.getEnderecos().add(new Endereco());
				cliente.getCartoes().add(new Cartao());
			}catch (Exception e) {
				// TODO: handle exception
			}
			return cliente;
		}else if(operacao.equals("LOGAR")) {
			try {
				id = Integer.parseInt(request.getParameter("txtId"));
				cliente.setId(id);
			} catch (Exception e) {
				// TODO: handle exception
			}
				try {
					Email = request.getParameter("txtemail");
					Senha = request.getParameter("txtpasswd");
				}catch (Exception e) {
					// TODO: handle exception
				}
				try {
					cliente.setsEmail(Email);
					cliente.setsSenha(Senha);
					cliente.setIsAdmin(null);
					cliente.setFlgAtivo(true);
				}catch (Exception e) {
					// TODO: handle exception
				}
				
				return cliente;
		}else if(!operacao.equals("VISUALIZAR")) {
			
			try {
				id = Integer.parseInt(request.getParameter("txtId"));
				cliente.setId(id);
			} catch (Exception e) {
				// TODO: handle exception
			}
				try {
					Email = request.getParameter("txtemail");
					Senha = request.getParameter("txtpasswd");
				}catch (Exception e) {
					// TODO: handle exception
				}
				try {
					cliente.setsEmail(Email);
					cliente.setsSenha(Senha);
				}catch (Exception e) {
					// TODO: handle exception
				}
				
			String Nome = "";
			String CPF = "";
			String DataNasc = "";
			String Telefone = "";
			String genero = "";
			
			try {
				Nome = request.getParameter("txtnome");
				CPF = request.getParameter("txtcpf");
				DataNasc = request.getParameter("clDataNasc");
				Email = request.getParameter("txtemail");
				Senha = request.getParameter("txtpasswd");
				Telefone = request.getParameter("txttelefone");
				genero = request.getParameter("ddlGenero");
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			Boolean isAtivo = true;
			try {
				isAtivo = request.getParameter("ckbisAtivo").equals("true") ? true:false;
				isAtivo = request.getParameter("ckbisAtivo").equals("todos") ? null: isAtivo;
			}catch(Exception e) {
			}
			
			try {
				cliente.setsNome(Nome);
				cliente.setsCPF(CPF);
				cliente.setDtDataNasc(Date.valueOf(DataNasc));
				cliente.setsEmail(Email);
				cliente.setsTelefone(Telefone);
				cliente.setsSenha(Senha);
				cliente.setsGenero(genero);
				cliente.setIsAdmin(false);
				cliente.setFlgAtivo(isAtivo);
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			Endereco end = new Endereco();
			Cartao cart = new Cartao();
			Boolean Cobranca;
			
			try {
				Cobranca = request.getParameter("cbkCobranca").equals("true") ? true:false;
			}catch(Exception e) {
				Cobranca = false;
			}
			try {
				end.setFlgCobranca(Cobranca);
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			if(operacao.equals("SALVAR") && request.getParameter("txtId") == null || operacao.equals("LOGIN"))
				end.setFlgCobranca(true);
			
			try {
				end.setNome(request.getParameter("txtNomeEnd"));
				end.setPais(request.getParameter("ddlpais"));
				end.setCEP(request.getParameter("txtcep"));
				end.setBairro(request.getParameter("txtBairro"));
				end.setTipoLogradouro(request.getParameter("ddlTipoLogr"));
				end.setTipoResidencia(request.getParameter("ddlTipoRes"));
				end.setLogradouro(request.getParameter("txtrua"));
				end.setNumerologradouro(request.getParameter("txtnum"));
				end.setEstado(request.getParameter("ddlestado"));
				end.setCidade(request.getParameter("ddlcidade"));
				
				cliente.setEnderecos(new ArrayList<Endereco>());
				cliente.getEnderecos().add(end);
				
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			try {
				end.setComp(request.getParameter("txtcomp"));
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			try {
				cart.setsNumCartao(request.getParameter("txtNumCartao"));
				cart.setsNomeTitular(request.getParameter("txtTitular"));
				cart.setsCodSeguranca(request.getParameter("txtCodSeg"));
				cart.setsBandeira(request.getParameter("btnBandeira"));
				//cart.setDtDataVal(request.getParameter("txtValidade"));
				cart.setDtDataVal(request.getParameter("ddlAno") + "-" + request.getParameter("ddlMes") + "-01");
				cliente.setCartoes(new ArrayList<Cartao>());
				cliente.getCartoes().add(cart);
				
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		}else {
			Cliente CliEnd;
			String txtcep = null;
			String txtnum = null;
			String txtnumCart = null;
			HttpSession session = request.getSession();
			Resultado resultado = (Resultado) session.getAttribute("resultado");
			int txtId = Integer.parseInt(request.getParameter("txtId"));
			
			try {
				txtcep = request.getParameter("txtcep");
				txtnum = request.getParameter("txtnum");
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			try {
				txtnumCart = request.getParameter("txtNumCartao");
			}catch (Exception e) {
				// TODO: handle exception
			}
			if(txtcep != null && txtnum != null) {
				for(EntidadeDominio cli: resultado.getEntidades()) {
					CliEnd = (Cliente)cli;
					if(cli.getId() == txtId) {
						cliente = (Cliente)cli;
						for(Endereco end:CliEnd.getEnderecos()) {
							if(end.getCEP().equals(txtcep) && end.getNumerologradouro().equals(txtnum)) {
								cliente.setEnderecos(new ArrayList<Endereco>());
								cliente.getEnderecos().add(end);
							}
						}
					}
				}
			}
			
			if(txtnumCart != null) {
				for(EntidadeDominio cli: resultado.getEntidades()) {
					CliEnd = (Cliente)cli;
					if(cli.getId() == txtId) {
						cliente = (Cliente)cli;
						for(Cartao cart:CliEnd.getCartoes()) {
							if(cart.getsNumCartao().equals(txtnumCart)) {
								cliente.setCartoes(new ArrayList<Cartao>());
								cliente.getCartoes().add(cart);
							}
						}
					}
				}
			}
			
			if(txtcep == null && txtnum == null && txtnumCart == null) {
				for(EntidadeDominio cli: resultado.getEntidades()) {
					if(cli.getId() == txtId) {
						cliente = (Cliente)cli;
					}
				}
			}
		}
		
		return cliente;
	}

	@Override
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		RequestDispatcher d = null;
		String operacao = request.getParameter("operacao");
		String target="";
		
		if(resultado.getMsg()== null) {
			if(operacao.equals("SALVAR")) {
				request.getSession().setAttribute("resultado", resultado);
				try {
					target = request.getParameter("target");
				}catch (Exception e) {
				}
				
				if(target != null) {
					d = request.getRequestDispatcher(target);
				}else {
					d = request.getRequestDispatcher("login.jsp");
				}
			}
		}
		
		if(resultado.getMsg() == null && operacao.equals("LOGAR")) {
			request.getSession().setAttribute("login", resultado);
			List<EntidadeDominio> ent = resultado.getEntidades();
			Cliente cli = (Cliente)ent.get(0);
			if(cli.getIsAdmin())
				d = request.getRequestDispatcher("Index.jsp");
			else
				d = request.getRequestDispatcher("ClienteLogado.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR")) {
			
			request.getSession().setAttribute("visualizar", resultado.getEntidades().get(0));
			
			try {
				target = request.getParameter("target");
				System.out.println(target);
			}catch (Exception e) {
				
			}
			
			if(target != null) {
				d = request.getRequestDispatcher(target);
			}else {
				d = request.getRequestDispatcher("alterar-endereco.jsp");
			}
		}
		
		if(resultado.getMsg() == null && operacao.equals("EXCLUIR")) {
			try {
				target = request.getParameter("target");
			}catch (Exception e) {
			}
			
			if(target != null) {
				request.getSession().invalidate();
				d = request.getRequestDispatcher(target);
			}else {
				request.getSession().setAttribute("resultado", null);
				d = request.getRequestDispatcher("ClienteLogado.jsp");
			}
		}
		
		if(resultado.getMsg() == null && operacao.equals("ATIVAR")) {
			d = request.getRequestDispatcher("gerenciarCliente.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("CONSULTAR-CUPOM")) {
			request.getSession().setAttribute("resultado", resultado);
			
			d = request.getRequestDispatcher("cupons.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("CONSULTAR-COMPRA")) {
			request.getSession().setAttribute("resultado", resultado);
			
			d = request.getRequestDispatcher("carrinho.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("LOGOUT")) {
			System.out.println("entra no logout");
			request.getSession().invalidate();
			d = request.getRequestDispatcher("IndexCliente.html");
		}
		
		if(resultado.getMsg() == null && operacao.equals("ALTERAR")) {
			request.getSession().setAttribute("resultado", null);
			d = request.getRequestDispatcher("ClienteLogado.jsp");
		}

		
		if(resultado.getMsg() == null && operacao.equals("CONSULTAR")) {
			request.getSession().setAttribute("resultado", resultado);
			try {
				target = request.getParameter("target");
			}catch (Exception e) {
			}
			
			if(target != null) {
				d = request.getRequestDispatcher(target);
			}else {
				d = request.getRequestDispatcher("perfil.jsp");
			}
		}
		
		if(resultado.getMsg() != null) {
			if(operacao.equals("CONSULTAR")) {
				request.getSession().setAttribute("resultado", resultado);
				d = request.getRequestDispatcher("GerenciarLivro.jsp");
			}
			if(operacao.equals("SALVAR")) {
				request.getSession().setAttribute("resultado", resultado);
				d = request.getRequestDispatcher("login.jsp");
			}
			if(operacao.equals("ALTERAR") || operacao.equals("ATIVAR") || operacao.equals("EXCLUIR")){
				request.getSession().setAttribute("resultado", resultado);
				d = request.getRequestDispatcher("IndexCliente.html");
			}
			if(operacao.equals("LOGAR")) {
				request.getSession().setAttribute("login", resultado);
				d = request.getRequestDispatcher("login.jsp");
			}
		}
		
		d.forward(request, response);
	}
	
}
