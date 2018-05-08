package les12018.dominio;

import java.util.ArrayList;

public class Pedido extends EntidadeDominio{
	private ArrayList<Produto> Produtos = new ArrayList<Produto>();
	private Cliente cliente = new Cliente();
	private Endereco endEntrega = new Endereco();
	private double Frete;
	private double ValorTotal;
	private String FormaDePagamento;
	
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
	
	
}
