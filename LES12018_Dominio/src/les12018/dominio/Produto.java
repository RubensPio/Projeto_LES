package les12018.dominio;

public class Produto extends EntidadeDominio{
	private Livro livro = new Livro();
	private int quantidade;
	private int quantidadeAnterior = 0;
	private double subtotal;
	private boolean flgRemover = false;
	
	public int getQuantidadeAnterior() {
		return quantidadeAnterior;
	}
	public void setQuantidadeAnterior(int quantidadeAnterior) {
		this.quantidadeAnterior = quantidadeAnterior;
	}
	public boolean isFlgRemover() {
		return flgRemover;
	}
	public void setFlgRemover(boolean flgRemover) {
		this.flgRemover = flgRemover;
	}
	public Livro getLivro() {
		return livro;
	}
	public void setLivro(Livro livro) {
		this.livro = livro;
	}
	public int getQuantidade() {
		return quantidade;
	}
	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}
	public double getSubtotal() {
		return subtotal;
	}
	public void setSubtotal(double subtotal) {
		this.subtotal = subtotal;
	}
	
}
