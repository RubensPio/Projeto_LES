package les12018.dominio;

public class Ativacao extends EntidadeDominio{
	private String Motivo;
	private CatAtivacao categoria;
	
	public String getMotivo() {
		return Motivo;
	}
	public void setMotivo(String motivo) {
		Motivo = motivo;
	}
	public CatAtivacao getCategoria() {
		return categoria;
	}
	public void setCategoria(CatAtivacao categoria) {
		this.categoria = categoria;
	}

}
