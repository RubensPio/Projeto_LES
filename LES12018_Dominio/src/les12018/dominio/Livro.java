package les12018.dominio;

import java.util.List;

public class Livro extends EntidadeDominio {
	private String Titulo;
	private String AnoPub;
	private String Edicao;
	private String ISBN;
	private String Sinopse;
	private String CodBarras;
	private String NumPaginas;
	private int Estoque;
	private double peso;
	private double Altura;
	private double largura;
	private double profundidade;
	private boolean ativo;
	private Autor autor;
	private Editora editora;
	private List<Categoria> Categorias;
	private GrupoPrecificacao GP;
	private Inativacao inativacao;
	private Ativacao ativacao;
	
	public Inativacao getInativacao() {
		return inativacao;
	}
	public void setInativacao(Inativacao inativacao) {
		this.inativacao = inativacao;
	}
	public Ativacao getAtivacao() {
		return ativacao;
	}
	public void setAtivacao(Ativacao ativacao) {
		this.ativacao = ativacao;
	}
	public int getEstoque() {
		return Estoque;
	}
	public void setEstoque(int estoque) {
		Estoque = estoque;
	}
	
	public Editora getEditora() {
		return editora;
	}
	public void setEditora(Editora editora) {
		this.editora = editora;
	}
	
	public boolean isAtivo() {
		return ativo;
	}
	public void setAtivo(boolean ativo) {
		this.ativo = ativo;
	}
	
	public String getTitulo() {
		return Titulo;
	}
	public void setTitulo(String titulo) {
		Titulo = titulo;
	}
	public String getAnoPub() {
		return AnoPub;
	}
	public void setAnoPub(String anoPub) {
		AnoPub = anoPub;
	}
	public String getEdicao() {
		return Edicao;
	}
	public void setEdicao(String edicao) {
		Edicao = edicao;
	}
	public String getISBN() {
		return ISBN;
	}
	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}
	public String getSinopse() {
		return Sinopse;
	}
	public void setSinopse(String sinopse) {
		Sinopse = sinopse;
	}
	public String getCodBarras() {
		return CodBarras;
	}
	public void setCodBarras(String codBarras) {
		CodBarras = codBarras;
	}
	public String getNumPaginas() {
		return NumPaginas;
	}
	public void setNumPaginas(String numPaginas) {
		NumPaginas = numPaginas;
	}
	public double getPeso() {
		return peso;
	}
	public void setPeso(double peso) {
		this.peso = peso;
	}
	public double getAltura() {
		return Altura;
	}
	public void setAltura(double altura) {
		Altura = altura;
	}
	public double getLargura() {
		return largura;
	}
	public void setLargura(double largura) {
		this.largura = largura;
	}
	public double getProfundidade() {
		return profundidade;
	}
	public void setProfundidade(double profundidade) {
		this.profundidade = profundidade;
	}
	public Autor getAutor() {
		return autor;
	}
	public void setAutor(Autor autor) {
		this.autor = autor;
	}
	public List<Categoria> getCategorias() {
		return Categorias;
	}
	public void setCategorias(List<Categoria> categorias) {
		Categorias = categorias;
	}
	public GrupoPrecificacao getGP() {
		return GP;
	}
	public void setGP(GrupoPrecificacao gP) {
		GP = gP;
	}
	
}
