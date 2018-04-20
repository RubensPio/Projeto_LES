package les12018.dominio;

import java.sql.Date;

public class Cartao extends EntidadeDominio{
	private String sNumCartao;
	private String sCodSeguranca;
	private String sNomeTitular;
	private String sBandeira;
	private String dtDataVal;
	
	public String getsNumCartao() {
		return sNumCartao;
	}
	public void setsNumCartao(String sNumCartao) {
		this.sNumCartao = sNumCartao;
	}
	public String getsCodSeguranca() {
		return sCodSeguranca;
	}
	public void setsCodSeguranca(String sCodSeguranca) {
		this.sCodSeguranca = sCodSeguranca;
	}
	public String getsNomeTitular() {
		return sNomeTitular;
	}
	public void setsNomeTitular(String sNomeTitular) {
		this.sNomeTitular = sNomeTitular;
	}
	public String getsBandeira() {
		return sBandeira;
	}
	public void setsBandeira(String sBandeira) {
		this.sBandeira = sBandeira;
	}
	public String getDtDataVal() {
		return dtDataVal;
	}
	public void setDtDataVal(String dtDataVal) {
		this.dtDataVal = dtDataVal;
	}
	
}
