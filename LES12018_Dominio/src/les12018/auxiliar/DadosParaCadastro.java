package les12018.auxiliar;

import les12018.dominio.EntidadeDominio;
import java.util.ArrayList;
import les12018.dominio.*;

public class DadosParaCadastro extends EntidadeDominio{
	private ArrayList<Autor> Autores = new ArrayList<>();
	private ArrayList<Editora> Editora = new ArrayList<>();
	private ArrayList<Categoria> Categoria = new ArrayList<>();
	private ArrayList<GrupoPrecificacao> Precificacoes = new ArrayList<>();
	private ArrayList<CatInativacao> CategoriasDeInativacao = new ArrayList<>();
	private ArrayList<CatAtivacao> CategoriasDeAtivacao = new ArrayList<>();
	
	public ArrayList<Autor> getAutores() {
		return Autores;
	}
	public void setAutores(ArrayList<Autor> autores) {
		Autores = autores;
	}
	public ArrayList<Editora> getEditora() {
		return Editora;
	}
	public void setEditora(ArrayList<Editora> editora) {
		Editora = editora;
	}
	public ArrayList<Categoria> getCategoria() {
		return Categoria;
	}
	public void setCategoria(ArrayList<Categoria> categoria) {
		Categoria = categoria;
	}
	public ArrayList<GrupoPrecificacao> getPrecificacoes() {
		return Precificacoes;
	}
	public void setPrecificacoes(ArrayList<GrupoPrecificacao> precificacoes) {
		Precificacoes = precificacoes;
	}
	public ArrayList<CatInativacao> getCategoriasDeInativacao() {
		return CategoriasDeInativacao;
	}
	public void setCategoriasDeInativacao(ArrayList<CatInativacao> categoriasDeInativacao) {
		CategoriasDeInativacao = categoriasDeInativacao;
	}
	public ArrayList<CatAtivacao> getCategoriasDeAtivacao() {
		return CategoriasDeAtivacao;
	}
	public void setCategoriasDeAtivacao(ArrayList<CatAtivacao> categoriasDeAtivacao) {
		CategoriasDeAtivacao = categoriasDeAtivacao;
	}
}
