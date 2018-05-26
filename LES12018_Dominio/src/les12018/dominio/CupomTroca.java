package les12018.dominio;

public class CupomTroca extends EntidadeDominio{
	private Double Valor;
	private boolean FlgUsado = false;

	public Double getValor() {
		return Valor;
	}

	public void setValor(Double valor) {
		Valor = valor;
	}

	public boolean isFlgUsado() {
		return FlgUsado;
	}

	public void setFlgUsado(boolean flgUsado) {
		FlgUsado = flgUsado;
	}
}
