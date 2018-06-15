package LES12018.controle.web.vh.impl;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import LES12018.controle.web.vh.IViewHelper;
import LES12018.core.aplicacao.Resultado;
import les12018.dominio.DadosParaGrafico;
import les12018.dominio.EntidadeDominio;

public class GraficoViewHelper implements IViewHelper {

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		DadosParaGrafico dadosParaGrafico = new DadosParaGrafico();
		
		dadosParaGrafico.setDataInicial(Date.valueOf(request.getParameter("StartDate")));
		dadosParaGrafico.setDataFinal(Date.valueOf(request.getParameter("FinalDate")));
		
		return dadosParaGrafico;
	}

	@Override
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		RequestDispatcher d = null;
		String operacao = request.getParameter("operacao");
		
		if(resultado.getMsg() == null) {
			if(operacao.equals("GRAFICO")) {
				request.getSession().setAttribute("grafico", resultado.getEntidades().get(0));
				d = request.getRequestDispatcher("dashboard.jsp");
			}
		}
		
		d.forward(request, response);
	}

}
