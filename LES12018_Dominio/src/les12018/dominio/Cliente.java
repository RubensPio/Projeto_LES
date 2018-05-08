package les12018.dominio;

import java.sql.Date;
import java.util.ArrayList;

public class Cliente extends EntidadeDominio{
	private String sGenero;
	private String sNome;
	private Date dtDataNasc;
	private String sCPF;
	private String sEmail;
	private String sSenha;
	private String novaSenha;
	private int nRanking;
	private String sTelefone;
	private ArrayList<Endereco> enderecos = new ArrayList<Endereco>();
	private ArrayList<Cartao> cartoes= new ArrayList<Cartao>();
	private Boolean isAdmin;
	private Boolean flgAtivo;
	
	public String getNovaSenha() {
		return novaSenha;
	}
	public void setNovaSenha(String novaSenha) {
		this.novaSenha = novaSenha;
	}
	public String getsGenero() {
		return sGenero;
	}
	public void setsGenero(String sGenero) {
		this.sGenero = sGenero;
	}
	public String getsNome() {
		return sNome;
	}
	public void setsNome(String sNome) {
		this.sNome = sNome;
	}
	public Date getDtDataNasc() {
		return dtDataNasc;
	}
	public void setDtDataNasc(Date dtDataNasc) {
		this.dtDataNasc = dtDataNasc;
	}
	public String getsCPF() {
		return sCPF;
	}
	public void setsCPF(String sCPF) {
		this.sCPF = sCPF;
	}
	public String getsEmail() {
		return sEmail;
	}
	public void setsEmail(String sEmail) {
		this.sEmail = sEmail;
	}
	public String getsSenha() {
		return sSenha;
	}
	public void setsSenha(String sSenha) {
		this.sSenha = sSenha;
	}
	public int getnRanking() {
		return nRanking;
	}
	public void setnRanking(int nRanking) {
		this.nRanking = nRanking;
	}
	public String getsTelefone() {
		return sTelefone;
	}
	public void setsTelefone(String sTelefone) {
		this.sTelefone = sTelefone;
	}
	public ArrayList<Endereco> getEnderecos() {
		return enderecos;
	}
	public void setEnderecos(ArrayList<Endereco> enderecos) {
		this.enderecos = enderecos;
	}
	public ArrayList<Cartao> getCartoes() {
		return cartoes;
	}
	public void setCartoes(ArrayList<Cartao> cartoes) {
		this.cartoes = cartoes;
	}
	public Boolean getIsAdmin() {
		return isAdmin;
	}
	public void setIsAdmin(Boolean isAdmin) {
		this.isAdmin = isAdmin;
	}
	public Boolean getFlgAtivo() {
		return flgAtivo;
	}
	public void setFlgAtivo(Boolean flgAtivo) {
		this.flgAtivo = flgAtivo;
	}
}
