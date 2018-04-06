package LES12018.controle.web.vh.impl;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import LES12018.controle.web.vh.IViewHelper;
import LES12018.core.aplicacao.Resultado;
import les12018.auxiliar.DadosParaCadastro;
import les12018.dominio.Autor;
import les12018.dominio.EntidadeDominio;

public class DadosParaLivroViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
			DadosParaCadastro dadosLivro = new DadosParaCadastro();
		return dadosLivro;
	}

	@Override
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		RequestDispatcher d = null;
		DadosParaCadastro dt = new DadosParaCadastro();
		String operacao = request.getParameter("target");
		request.getSession().setAttribute("dados", resultado);
		dt = (DadosParaCadastro)resultado.getEntidades().get(0);
		d = request.getRequestDispatcher(operacao);
		d.forward(request, response);
		
		
	}	

}
