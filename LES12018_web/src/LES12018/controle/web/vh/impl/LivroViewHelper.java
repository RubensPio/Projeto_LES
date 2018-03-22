package LES12018.controle.web.vh.impl;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import LES12018.controle.web.vh.IViewHelper;
import LES12018.core.aplicacao.Resultado;
import les12018.dominio.Autor;
import les12018.dominio.Cliente;
import les12018.dominio.Editora;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.GrupoPrecificacao;
import les12018.dominio.Livro;

public class LivroViewHelper implements IViewHelper{
	
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		Livro livro = null;
		Autor autor = new Autor();
		Editora editora = new Editora();
		GrupoPrecificacao gp = new GrupoPrecificacao();
		
		livro.setAutor(autor);
		livro.setEditora(editora);
		livro.setGP(gp);
		
		if(!operacao.equals("VISUALIZAR")) {
			String Titulo = request.getParameter("txtTitulo");
			String Ano = request.getParameter("txtAno");
			String NumPaginas = request.getParameter("txtNumPaginas");
			String Edicao = request.getParameter("txtEdicao");
			String ISBN = request.getParameter("txtISBN");
			int Autor = Integer.parseInt(request.getParameter("ddlAutor"));
			int GrupoPrecificacao = Integer.parseInt(request.getParameter("dllGrupoPre"));
			String Sinopse = request.getParameter("txtSinopse");
			String Categorias = request.getParameter("ddlCategoria");
			String[] categorias = Categorias.split(" ");
			Boolean isAtivo = request.getParameter("cbIsAtivo").equals("true") ? true : false;
			isAtivo = request.getParameter("cbIsAtivo").equals("todos") ? null : isAtivo;
			int Editora = Integer.parseInt(request.getParameter("ddlEditora"));
			
			livro = new Livro();
			
			int estoque = 0, id=0;
			double preco = 0.0, valor = 0.0;
			Double altura = 0.0, largura = 0.0, peso = 0.0, profundidade = 0.0;
			
			try {
				estoque = Integer.parseInt(request.getParameter("txtEstoque"));
				preco = Double.parseDouble(request.getParameter("txtPreco"));
				valor = Double.parseDouble(request.getParameter("txtValor"));
				altura = Double.parseDouble(request.getParameter("txtAltura"));
				largura = Double.parseDouble(request.getParameter("txtLargura"));
				peso = Double.parseDouble(request.getParameter("txtPeso"));
				profundidade = Double.parseDouble(request.getParameter("txtProfundidade"));
				
			} catch(Exception e){
				
			}
			
			HttpSession session = request.getSession();
			Cliente usuario = (Cliente)session.getAttribute("usuario");
			
			try {
				id = Integer.parseInt(request.getParameter("txtId"));
				livro.setAltura(id);
			} catch (Exception e) {
				//TODO: handle exception
			}
			
			livro.setEstoque(estoque);
			livro.setPreco(preco);
			livro.getAutor().setId(Autor);
			livro.getEditora().setId(Editora);
			livro.getGP().setId(GrupoPrecificacao);
			livro.setSinopse(Sinopse);
			livro.setISBN(ISBN);
			livro.setAnoPub(Ano);
			livro.setNumPaginas(NumPaginas);
			livro.setTitulo(Titulo);
			livro.setAtivo(isAtivo);
			livro.setEstoque(estoque);
			livro.setPreco(preco);
			livro.setAltura(altura);
			livro.setLargura(largura);
			livro.setPeso(peso);
			livro.setProfundidade(profundidade);			
		} else {
			HttpSession session = request.getSession();
			Resultado resultado = (Resultado) session.getAttribute("resultado");
			int txtId = Integer.parseInt(request.getParameter("txtId"));
			
			for(EntidadeDominio liv: resultado.getEntidades()) {
				if(liv.getId() == txtId) {
					livro = (Livro)liv;
				}
			}
		}
		return livro;
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
			d = request.getRequestDispatcher("FormConsultaLivro.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("ALTERAR")) {
			d = request.getRequestDispatcher("FormConsultarLivro.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR")) {
			request.setAttribute("livro", resultado.getEntidades().get(0));
			d = request.getRequestDispatcher("FormLivro");
		}
		
		if(resultado.getMsg() == null && operacao.equals("EXCLUIR")) {
			request.getSession().setAttribute("resultado", null);
			d = request.getRequestDispatcher("FormConsultaLivro.jsp");
		}
		
		if(resultado.getMsg() != null) {
			if(operacao.equals("SALVAR") || operacao.equals("ALTERAR")) {
				request.getSession().setAttribute("resultado", resultado);
				d = request.getRequestDispatcher("FormConsultaLivro.jsp");
			}
		}
		
		d.forward(request, response);
	}
}
