package les12018.auxiliar;

import les12018.dominio.EntidadeDominio;

public class ItemsGrafico extends EntidadeDominio {
	private int idCategoria;
	private String nomeCategoria;
	private int qtdTotal;
	private int mes;
	private boolean flgUnico = false;

	public int getIdCategoria() {
		return idCategoria;
	}
	public void setIdCategoria(int idCategoria) {
		this.idCategoria = idCategoria;
	}
	public String getNomeCategoria() {
		return nomeCategoria;
	}
	public void setNomeCategoria(String nomeCategoria) {
		this.nomeCategoria = nomeCategoria;
	}
	public int getQtdTotal() {
		return qtdTotal;
	}
	public void setQtdTotal(int qtdTotal) {
		this.qtdTotal = qtdTotal;
	}
	public int getMes() {
		return mes;
	}
	public void setMes(int mes) {
		this.mes = mes;
	}
	public boolean isFlgUnico() {
		return flgUnico;
	}
	public void setFlgUnico(boolean flgUnico) {
		this.flgUnico = flgUnico;
	}
}
