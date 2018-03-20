package les12018.dominio;

public class Inativacao extends EntidadeDominio{
	private String Motivo;
	private CatInativacao categoria;
	
	public String getMotivo() {
		return Motivo;
	}
	public void setMotivo(String motivo) {
		Motivo = motivo;
	}
	public CatInativacao getCategoria() {
		return categoria;
	}
	public void setCategoria(CatInativacao categoria) {
		this.categoria = categoria;
	}
}
