package Teste;

import java.util.ArrayList;
import java.util.List;

import LES12018.core.impl.dao.LivroDAO;
import LES12018.core.util.ConverteDate;
import jdk.internal.dynalink.linker.ConversionComparator;
import les12018.dominio.Autor;
import les12018.dominio.Categoria;
import les12018.dominio.Editora;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.GrupoPrecificacao;
import les12018.dominio.Livro;

public class Principal {

	public static void main(String[] args) {
		Livro livro = new Livro();
		LivroDAO dao = new LivroDAO();
		Categoria cat = new Categoria();
		Categoria cat2 = new Categoria();
		Editora editora = new Editora();
		GrupoPrecificacao grp = new GrupoPrecificacao();
		ConverteDate cvd = new ConverteDate();
		Autor autor = new Autor();
		List<Categoria> cats = new ArrayList<Categoria>();
		boolean ativacao = true;
		
		cat.setId(1);
		cat.setNome("Terror");
		cat2.setId(4);
		cat2.setNome("Tecnologia");
		
		cats.add(cat);
		cats.add(cat2);
		
		autor.setNome("Dan Brown");
		autor.setId(3);
		
		editora.setId(1);
		grp.setId(1);
		
		
		livro.setAltura(2);
		livro.setAnoPub("2017");
		livro.setCodBarras("231231212312321");
		livro.setISBN("231231212312321");
		livro.setEdicao("1");
		livro.setAutor(autor);
		livro.setEditora(editora);
		livro.setGP(grp);
		livro.setLargura(3);
		livro.setPeso(2);
		livro.setProfundidade(2);
		livro.setTitulo("As Tranças do Rei Careca");
		livro.setAtivo(ativacao);
		livro.setNumPaginas("254");
		livro.setSinopse("oloco bixo");
		livro.setCategorias(cats);
		livro.setDtCadastro(cvd.converteStringDate("20/03/2018"));
		
		dao.salvar(livro);

	}

}
