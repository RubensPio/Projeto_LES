package les12018.dominio;

public class GrupoPrecificacao extends EntidadeDominio{
	private String Nome;
	private double porcentagem;
	
	public String getNome() {
		return Nome;
	}
	public void setNome(String nome) {
		Nome = nome;
	}
	public double getPorcentagem() {
		return porcentagem;
	}
	public void setPorcentagem(double porcentagem) {
		this.porcentagem = porcentagem;
	}
}
