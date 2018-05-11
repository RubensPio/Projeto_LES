package LES12018.controle.web.vh.impl;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.plaf.synth.SynthSeparatorUI;

import java.util.ArrayList;
import java.util.List;

import LES12018.controle.web.vh.IViewHelper;
import LES12018.core.aplicacao.Resultado;
import les12018.dominio.Cliente;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.Livro;
import les12018.dominio.Pedido;
import les12018.dominio.Produto;

public class PedidoViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		System.out.println(operacao);
		Pedido pedido = new Pedido();
		Resultado resultado = (Resultado) request.getSession().getAttribute("login");
		List<EntidadeDominio> Cli = resultado.getEntidades();		
		Cliente cliente = (Cliente)Cli.get(0);
		double total = 0;
		int qtd = 0;
		double subtotal = 0;
		if(operacao.equals("ADDCARRINHO")) {
			if(request.getSession().getAttribute("carrinho") != null) {
				pedido = (Pedido) request.getSession().getAttribute("carrinho");
				ArrayList<Produto> produtos = pedido.getProdutos();
				Produto produto = new Produto();
				for(Produto prod:pedido.getProdutos()) {
					if(prod.getLivro().getId() == Integer.parseInt(request.getParameter("txtLivId"))) {
						qtd = prod.getQuantidade() + Integer.parseInt(request.getParameter("txtQtd"));
						subtotal = qtd*prod.getLivro().getPrecoUnit();
						
						prod.setSubtotal(subtotal);
						prod.setQuantidade(qtd);
						total += pedido.getValorTotal() + subtotal;
						pedido.setValorTotal(total);
						return pedido;
					}
				}
				
				produto.setLivro(new Livro());
				produto.getLivro().setId(Integer.parseInt(request.getParameter("txtLivId")));
				produto.getLivro().setTitulo(request.getParameter("txtTitulo"));
				produto.setQuantidade(Integer.parseInt(request.getParameter("txtQtd")));
				produto.getLivro().setPrecoUnit(Double.parseDouble(request.getParameter("txtSubTotal")));
				produto.setSubtotal(Double.parseDouble(request.getParameter("txtSubTotal")));
				total = pedido.getValorTotal() + Double.parseDouble(request.getParameter("txtSubTotal"));
				System.out.println(total);
				pedido.setValorTotal(total);
				produtos.add(produto);
				pedido.setProdutos(produtos);
				
				return pedido;
			}else {
				Pedido ped = new Pedido();
				ped.setCliente(new Cliente());
				ped.getCliente().setsNome(cliente.getsNome());
				ped.getCliente().setId(cliente.getId());
				ArrayList<Produto> produtos = new ArrayList<Produto>();
				Produto produto = new Produto();
				produto.setLivro(new Livro());
				produto.getLivro().setId(Integer.parseInt(request.getParameter("txtLivId")));
				produto.getLivro().setTitulo(request.getParameter("txtTitulo"));
				produto.getLivro().setPrecoUnit(Double.parseDouble(request.getParameter("txtSubTotal")));
				produto.setQuantidade(Integer.parseInt(request.getParameter("txtQtd")));
				produto.setSubtotal(Double.parseDouble(request.getParameter("txtSubTotal")));
				produtos.add(produto);
				ped.setProdutos(produtos);
				ped.setValorTotal(Double.parseDouble(request.getParameter("txtSubTotal")));
				System.out.println(ped.getValorTotal());
				return ped;
			}
		} else if(operacao.equals("REALIZAR-COMPRA")) {
			for(int i = 1; request.getParameter("Num"+i) != null; i++) {
				pedido = (Pedido) request.getSession().getAttribute("carrinho");
				ArrayList<Produto> produtos = pedido.getProdutos();
				qtd = produtos.get(i-1).getQuantidade();
				System.out.println(Integer.parseInt(request.getParameter("Num"+i)));
				System.out.println(produtos.get(i-1).getQuantidade());
				if(produtos.get(i-1).getQuantidade() < Integer.parseInt(request.getParameter("Num"+i))) {
					produtos.get(i-1).setQuantidade(Integer.parseInt(request.getParameter("Num"+i))-qtd);
				}else {
					produtos.get(i-1).setQuantidade(0);
				}if(Integer.parseInt(request.getParameter("Num"+i)) == 0) {
					produtos.remove(i-1);
					i--;
					pedido.setProdutos(produtos);
					continue;
				}
				subtotal = 0;
				subtotal = produtos.get(i-1).getLivro().getPrecoUnit() * Integer.parseInt(request.getParameter("Num"+i));
				total += subtotal;
				produtos.get(i-1).setSubtotal(subtotal);
				pedido.setProdutos(produtos);
				System.out.println("iiiiiiiihhhh");
			}
			pedido.setValorTotal(total);
			
			return pedido;
		}
		
		return pedido;
	}

	@Override
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		RequestDispatcher d = null;
		String operacao = request.getParameter("operacao");
		String target ="";
		
		if(resultado.getMsg() == null && operacao.equals("ADDCARRINHO")) {
			request.getSession().setAttribute("carrinho", resultado.getEntidades().get(0));
			
			d = request.getRequestDispatcher("ClienteLogado.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("REALIZAR-COMPRA")) {
			Pedido ped = (Pedido)request.getSession().getAttribute("carrinho");
			Pedido pedi = (Pedido) resultado.getEntidades().get(0);
			int qtd = 0;
			for(Produto prod:ped.getProdutos()) {
				for(Produto produto:pedi.getProdutos()) {
					if(produto.getLivro().equals(prod.getLivro())) {
						if(produto.getQuantidade() > 0) {
							qtd = prod.getQuantidade();
							prod.setQuantidade(produto.getQuantidade() + qtd);
						}
					}
				}
			}
			request.getSession().setAttribute("carrinho", ped);
			
			d = request.getRequestDispatcher("pagamento.html");
		}
		
		if(resultado.getMsg() != null) {
			
		}
		
		d.forward(request, response);
	}

}
