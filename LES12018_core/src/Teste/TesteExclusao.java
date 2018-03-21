package Teste;

import LES12018.core.impl.dao.LivroDAO;
import les12018.dominio.CatInativacao;
import les12018.dominio.Inativacao;
import les12018.dominio.Livro;

public class TesteExclusao {

	public static void main(String[] args) {
		Livro livro = new Livro();
		LivroDAO dao = new LivroDAO();
		Inativacao mot = new Inativacao();
		CatInativacao catin = new CatInativacao();
		
		catin.setId(1);
		mot.setCategoria(catin);
		mot.setMotivo("Eu quis desativar pq o aranda é gay");
		
		livro.setId(2);
		livro.setInativacao(mot);
		
		dao.excluir(livro);

	}

}
