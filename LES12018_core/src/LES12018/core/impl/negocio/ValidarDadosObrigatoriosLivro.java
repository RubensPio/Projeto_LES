package LES12018.core.impl.negocio;

import LES12018.core.IStrategy;
import les12018.dominio.Autor;
import les12018.dominio.Editora;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.Livro;

public class ValidarDadosObrigatoriosLivro implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Livro){
            Livro livro = (Livro)entidade;

            Autor autor = livro.getAutor();
            String ano = livro.getAnoPub();
            String titulo = livro.getTitulo();
            Editora editora = livro.getEditora();
            String edicao = livro.getEdicao();
            String isbn = livro.getISBN();
            String numPaginas = livro.getNumPaginas();
            String sinopse = livro.getSinopse();
            double altura = livro.getAltura();
            double peso = livro.getPeso();
            double profundidade = livro.getProfundidade();

            if(autor == null || ano==null || titulo == null   || editora == null  ||
                    edicao == null || isbn == null || numPaginas == null|| sinopse == null || altura == 0   ||  peso == 0 ||
                    profundidade == 0)
                return "Todos os dados cadastrais de um livro são obrigatórios!";

            if(autor.getNome().trim().equals("") || 
                    ano.trim().equals("")|| titulo.trim().equals("") || editora.getNome().trim().equals("")
                    || edicao.trim().equals("") || isbn.trim().equals("") || numPaginas.trim().equals("") ||
                    sinopse.trim().equals(""))
                return "Todos os dados cadastrais de um livro são obrigatórios!";
        } else {
            return "Deve ser registrado um Livro!";
        }
		return null;
	}
}
