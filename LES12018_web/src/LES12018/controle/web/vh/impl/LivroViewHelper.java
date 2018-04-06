package LES12018.controle.web.vh.impl;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import LES12018.controle.web.vh.IViewHelper;
import LES12018.core.aplicacao.Resultado;
import les12018.dominio.Ativacao;
import les12018.dominio.Autor;
import les12018.dominio.CatAtivacao;
import les12018.dominio.CatInativacao;
import les12018.dominio.Categoria;
import les12018.dominio.Cliente;
import les12018.dominio.Editora;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.GrupoPrecificacao;
import les12018.dominio.Inativacao;
import les12018.dominio.Livro;
import sun.misc.Perf.GetPerfAction;

public class LivroViewHelper implements IViewHelper{
	
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		//System.out.println(operacao);
		Livro livro = new Livro();
		Categoria categ = new Categoria();
		int id = 0;
		
		try {
			id = Integer.parseInt(request.getParameter("txtId"));
			livro.setId(id);
		} catch (Exception e) {
			//TODO: handle exception
		}
		
		if(operacao.equals("ATIVAR") || operacao.equals("EXCLUIR")){
			livro.setInativacao(new Inativacao());
			livro.setAtivacao(new Ativacao());
			livro.getAtivacao().setCategoria(new CatAtivacao());
			livro.getInativacao().setCategoria(new CatInativacao());
			
			int CatInativacao = 0;
			int CatAtivacao = 0;
			String MotivoAtivacao = "";
			String MotivoInativacao = "";
			
			try {
				CatInativacao = Integer.parseInt(request.getParameter("ddlCatInativ"));
				MotivoInativacao = request.getParameter("txtMotivoInativ");
			}catch(Exception e) {
				
			}
			
			try {
				CatAtivacao = Integer.parseInt(request.getParameter("ddlCatAtiv"));
				MotivoAtivacao = request.getParameter("txtMotivoAti");
			}catch(Exception e) {
				
			}
			
			livro.getAtivacao().setMotivo(MotivoAtivacao);
			livro.getAtivacao().getCategoria().setId(CatAtivacao);
			
			livro.getInativacao().setMotivo(MotivoInativacao);
			livro.getInativacao().getCategoria().setId(CatInativacao);
		}else if(!operacao.equals("VISUALIZAR")) {
			
			String Titulo = "";
			String Ano = "";
			String NumPaginas = "";
			String Edicao = "";
			String CodBarras = ""; 
			String ISBN = "";
			String Sinopse = "";
			try {
				Titulo = request.getParameter("txtTitulo");
				Ano = request.getParameter("txtAno");
				NumPaginas = request.getParameter("txtNumPaginas");
				Edicao = request.getParameter("txtEdicao");
				CodBarras = request.getParameter("txtCodBarras");
				ISBN = request.getParameter("txtISBN");
				Sinopse = request.getParameter("txtSinopse");
			}catch (Exception e) {
				// TODO: handle exception
			}
			Boolean Ativinho = null;
			try {
				Ativinho = request.getParameter("ckbisAtivo").equals("true") ? true : false;
				Ativinho = request.getParameter("ckbisAtivo").equals("todos") ? null: Ativinho;
			}catch(Exception e) {
				
			}
			int Editora = 0;
			int Autor = 0;
			int GrupoPrecificacao = 0;
			String[] categorias = request.getParameterValues("ddlCategorias");
			try {
				Editora = Integer.parseInt(request.getParameter("ddlEditora"));
				Autor = Integer.parseInt(request.getParameter("ddlAutor"));
				GrupoPrecificacao = Integer.parseInt(request.getParameter("ddlGrupoPre"));
			}catch(Exception e) {
				
			}
			livro = new Livro();
			livro.setAutor(new Autor());
			livro.setEditora(new Editora());
			livro.setCategorias(new ArrayList<Categoria>());
			livro.setGP(new GrupoPrecificacao());
			
			int estoque = 0;
			double preco = 0.0, valor = 0.0;
			Double altura = 0.0, largura = 0.0, peso = 0.0, profundidade = 0.0;
			
			try {
				//estoque = Integer.parseInt(request.getParameter("txtEstoque"));
				//preco = Double.parseDouble(request.getParameter("txtPreco"));
				//valor = Double.parseDouble(request.getParameter("txtValor"));
				altura = Double.parseDouble(request.getParameter("txtAltura"));
				largura = Double.parseDouble(request.getParameter("txtLargura"));
				peso = Double.parseDouble(request.getParameter("txtPeso"));
				profundidade = Double.parseDouble(request.getParameter("txtProfundidade"));
				
			} catch(Exception e){
				
			}
			
			try {
				id = Integer.parseInt(request.getParameter("txtId"));
				livro.setId(id);
			} catch (Exception e) {
				//TODO: handle exception
			}
			
			HttpSession session = request.getSession();
			Cliente usuario = (Cliente)session.getAttribute("usuario");
			
			livro.setEstoque(estoque);
			livro.setPreco(preco);
			livro.getAutor().setId(Autor);
			livro.getEditora().setId(Editora);
			livro.setEdicao(Edicao);
			livro.getGP().setId(GrupoPrecificacao);
			livro.setSinopse(Sinopse);
			livro.setISBN(ISBN);
			livro.setCodBarras(CodBarras);
			livro.setAnoPub(Ano);
			livro.setNumPaginas(NumPaginas);
			livro.setTitulo(Titulo);
			livro.setAtivo(Ativinho);
			livro.setEstoque(estoque);
			livro.setPreco(preco);
			livro.setAltura(altura);
			livro.setLargura(largura);
			livro.setPeso(peso);
			livro.setProfundidade(profundidade);
			try {
				for(String cat: categorias) {
					categ = new Categoria();
					categ.setId(Integer.parseInt(cat));
					livro.getCategorias().add(categ);
				}
			}catch (Exception e) {
				
			}
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
		//System.out.println(operacao);
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
			d = request.getRequestDispatcher("Index.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("ALTERAR")) {
			request.getSession().setAttribute("livro", null);
			d = request.getRequestDispatcher("Index.jsp");
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
