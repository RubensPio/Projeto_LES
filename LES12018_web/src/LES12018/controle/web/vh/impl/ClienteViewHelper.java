package LES12018.controle.web.vh.impl;

import java.io.IOException;
import java.sql.Date;

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
		if(operacao == "ATIVAR" || operacao == "EXCLUIR") {
			
		} else if(operacao != "VISUALIZAR") {
			String Nome = "";
			String CPF = "";
			String DataNasc = "";
			String Email = "";
			String Telefone = "";
			
			try {
				Nome = request.getParameter("txtnome");
				CPF = request.getParameter("txtcpf");
				DataNasc = request.getParameter("clDataNasc");
				Email = request.getParameter("txtEmail");
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			Endereco end = new Endereco();
			Cartao cart = new Cartao();
			Boolean Cobranca = null;
			try {
				Cobranca = request.getParameter("ckbCobranca").equals("true") ? true : false;
				Cobranca = request.getParameter("ckbCobranca").equals("todos") ? null: Cobranca;
			}catch(Exception e) {
				
			}
			
			try {
				end.setFlgCobranca(Cobranca);
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			if(operacao == "SALVAR")
				end.setFlgCobranca(true);
			
			try {
				end.setCEP(request.getParameter("txtcep"));
				end.setLogradouro(request.getParameter("txtrua"));
				end.setNumerologradouro(request.getParameter("txtnum"));
				end.setEstado(request.getParameter("ddlestado"));
				end.setCidade(request.getParameter("ddlcidade"));
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
				cart.setsBandeira(request.getParameter(""));
				cart.setDtDataVal(request.getParameter("txtValidade"));
				
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			
		}else {
			HttpSession session = request.getSession();
			Resultado resultado = (Resultado) session.getAttribute("resultado");
			int txtId = Integer.parseInt(request.getParameter("txtId"));
			
			for(EntidadeDominio cli: resultado.getEntidades()) {
				if(cli.getId() == txtId) {
					cliente = (Cliente)cli;
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
		if(resultado.getMsg()== null) {
			if(operacao.equals("SALVAR")) {
				resultado.setMsg("Produto cadastrado com sucesso!");
			}
			request.getSession().setAttribute("resultado", resultado);
			d = request.getRequestDispatcher("Index.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR")) {
			request.getSession().setAttribute("livro", resultado.getEntidades().get(0));
			d = request.getRequestDispatcher("FormLivro.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("EXCLUIR")) {
			request.getSession().setAttribute("resultado", null);
			d = request.getRequestDispatcher("IndexCliente.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("ALTERAR")) {
			request.getSession().setAttribute("livro", null);
			d = request.getRequestDispatcher("perfil.jsp");
		}

		
		if(resultado.getMsg() == null && operacao.equals("CONSULTAR")) {
			request.getSession().setAttribute("resultado", resultado);
			d = request.getRequestDispatcher("GerenciarLivro.jsp");		
		}
		
		if(resultado.getMsg() != null) {
			if(operacao.equals("CONSULTAR")) {
				request.getSession().setAttribute("resultado", resultado);
				d = request.getRequestDispatcher("GerenciarLivro.jsp");
			}
			
			if(operacao.equals("SALVAR") || operacao.equals("ALTERAR") || operacao.equals("ATIVAR") || operacao.equals("EXCLUIR")){
				request.getSession().setAttribute("resultado", resultado);
				d = request.getRequestDispatcher("Index.jsp");
			}
		}
		
		d.forward(request, response);
	}
	
}
