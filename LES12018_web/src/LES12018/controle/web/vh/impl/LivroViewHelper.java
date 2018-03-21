package LES12018.controle.web.vh.impl;

import javax.servlet.http.HttpServletRequest;

import LES12018.controle.web.vh.IViewHelper;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.Livro;

public class LivroViewHelper implements IViewHelper{
	
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		Livro livro = null;
		
		if(!operacao.equals("VISUALIZAR")) {
			String Titulo = request.getParameter("txtTitulo");
			String Ano = request.getParameter("txtAno");
			String NumPaginas = request.getParameter("txtNumPaginas");
			String 
		}
	}
}
