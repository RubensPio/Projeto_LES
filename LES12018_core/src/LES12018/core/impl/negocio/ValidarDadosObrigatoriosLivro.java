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
            Autor autor = null;
            String ano = null;
            String titulo = null;
            Editora editora = null;
            String edicao = null;
            String isbn = null;
            int numPaginas = 0;
            String sinopse = null;
            double altura = 0;
            double largura = 0;
            double peso = 0;
            double profundidade = 0;
            try {
	            autor = livro.getAutor();
	            ano = livro.getAnoPub();
	            titulo = livro.getTitulo();
	            editora = livro.getEditora();
	            edicao = livro.getEdicao();
	            isbn = livro.getISBN();
	            numPaginas = Integer.parseInt(livro.getNumPaginas());
	            sinopse = livro.getSinopse();
	            altura = livro.getAltura();
	            largura = livro.getLargura();
	            peso = livro.getPeso();
	            profundidade = livro.getProfundidade();
            }catch(Exception e) {
            	
            }

            if(autor == null || ano==null || titulo == null   || editora == null  ||
                    edicao == null || isbn == null || numPaginas < 0 || sinopse == null || altura < 0   ||  peso < 0 ||
                    profundidade < 0 || largura < 0)
                return "Todos os dados cadastrais de um livro são obrigatórios!";

            if( ano.trim().equals("")|| titulo.trim().equals("")
                    || edicao.trim().equals("") || isbn.trim().equals("") ||
                    sinopse.trim().equals(""))
                return "Todos os dados cadastrais de um livro são obrigatórios!";
        } else {
            return "Deve ser registrado um Livro!";
        }
		return null;
	}
}
