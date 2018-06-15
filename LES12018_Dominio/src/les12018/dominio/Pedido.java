package les12018.dominio;

import java.util.ArrayList;

public class Pedido extends EntidadeDominio{
	private ArrayList<Produto> Produtos = new ArrayList<Produto>();
	private Cliente cliente = new Cliente();
	private ArrayList<Cartao> cartao = new ArrayList<Cartao>();
	private Endereco endEntrega = new Endereco();
	private double Frete;
	private double ValorTotal = 0;
	private String FormaDePagamento;
	private String Status;
	private CupomPromocional cupomPromocional;
	private ArrayList<CupomTroca> cuponsTroca;
	private boolean flgTroca = false;
	
	public CupomPromocional getCupomPromocional() {
		return cupomPromocional;
	}
	public void setCupomPromocional(CupomPromocional cupomPromocional) {
		this.cupomPromocional = cupomPromocional;
	}
	public ArrayList<CupomTroca> getCuponsTroca() {
		return cuponsTroca;
	}
	public void setCuponsTroca(ArrayList<CupomTroca> cuponsTroca) {
		this.cuponsTroca = cuponsTroca;
	}
	
	public String getStatus() {
		return Status;
	}
	public void setStatus(String status) {
		Status = status;
	}
	public ArrayList<Produto> getProdutos() {
		return Produtos;
	}
	public void setProdutos(ArrayList<Produto> produtos) {
		Produtos = produtos;
	}
	public Cliente getCliente() {
		return cliente;
	}
	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}
	public Endereco getEndEntrega() {
		return endEntrega;
	}
	public void setEndEntrega(Endereco endEntrega) {
		this.endEntrega = endEntrega;
	}
	public double getFrete() {
		return Frete;
	}
	public void setFrete(double frete) {
		Frete = frete;
	}
	public double getValorTotal() {
		return ValorTotal;
	}
	public void setValorTotal(double valorTotal) {
		ValorTotal = valorTotal;
	}
	public String getFormaDePagamento() {
		return FormaDePagamento;
	}
	public void setFormaDePagamento(String formaDePagamento) {
		FormaDePagamento = formaDePagamento;
	}
	public boolean isFlgTroca() {
		return flgTroca;
	}
	public void setFlgTroca(boolean flgTroca) {
		this.flgTroca = flgTroca;
	}
	public ArrayList<Cartao> getCartao() {
		return cartao;
	}
	public void setCartao(ArrayList<Cartao> cartao) {
		this.cartao = cartao;
	}
	
	
}
