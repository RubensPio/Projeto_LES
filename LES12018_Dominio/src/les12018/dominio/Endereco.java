package les12018.dominio;

public class Endereco extends EntidadeDominio{
	private String tipoResidencia;										// Ex: Casa, apartamento, etc
	private String tipoLogradouro;										// EX: Avenida, rua, etc
	private String Logradouro;											// Armazena o nome do logradouro
	private String numerologradouro;									// Armazena o numero da residencia
	private String Bairro;												// Armazena o bairro do cliente
	private String CEP;													// Armazena o CEP do cliente
	private String Cidade;												// Idem Cidade
	private String Estado;												// Idem Estado
	private String Pais;												// Idem Pais
	private Boolean flgCobranca;
	private String Comp;
	
	public String getComp() {
		return Comp;
	}
	public void setComp(String comp) {
		Comp = comp;
	}
	public String getTipoResidencia() {
		return tipoResidencia;
	}
	public void setTipoResidencia(String tipoResidencia) {
		this.tipoResidencia = tipoResidencia;
	}
	public String getTipoLogradouro() {
		return tipoLogradouro;
	}
	public void setTipoLogradouro(String tipoLogradouro) {
		this.tipoLogradouro = tipoLogradouro;
	}
	public String getLogradouro() {
		return Logradouro;
	}
	public void setLogradouro(String logradouro) {
		Logradouro = logradouro;
	}
	public String getNumerologradouro() {
		return numerologradouro;
	}
	public void setNumerologradouro(String numerologradouro) {
		this.numerologradouro = numerologradouro;
	}
	public String getBairro() {
		return Bairro;
	}
	public void setBairro(String bairro) {
		Bairro = bairro;
	}
	public String getCEP() {
		return CEP;
	}
	public void setCEP(String cEP) {
		CEP = cEP;
	}
	public String getCidade() {
		return Cidade;
	}
	public void setCidade(String cidade) {
		Cidade = cidade;
	}
	public String getEstado() {
		return Estado;
	}
	public void setEstado(String estado) {
		Estado = estado;
	}
	public String getPais() {
		return Pais;
	}
	public void setPais(String pais) {
		Pais = pais;
	}
	public Boolean getFlgCobranca() {
		return flgCobranca;
	}
	public void setFlgCobranca(Boolean flgCobranca) {
		this.flgCobranca = flgCobranca;
	}
}
