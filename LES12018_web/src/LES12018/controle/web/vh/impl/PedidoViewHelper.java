package LES12018.controle.web.vh.impl;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSeparatorUI;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import LES12018.controle.web.vh.IViewHelper;
import LES12018.core.aplicacao.Resultado;
import LES12018.core.impl.dao.ClienteDAO;
import les12018.dominio.Cartao;
import les12018.dominio.Cliente;
import les12018.dominio.CupomPromocional;
import les12018.dominio.CupomTroca;
import les12018.dominio.Endereco;
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
		boolean flgTroca;
		CupomTroca cpt = new CupomTroca();
		Resultado resultado = (Resultado) request.getSession().getAttribute("login");
		List<EntidadeDominio> Cli = resultado.getEntidades();		
		Cliente cliente = (Cliente)Cli.get(0);
		ArrayList<Produto> produtos;
		double total = 0;
		int qtd = 0;
		double subtotal = 0;
		
		if(operacao.equals("ALTERAR")) {
			pedido.setStatus(request.getParameter("txtStatus"));
			pedido.setId(Integer.parseInt(request.getParameter("txtId")));
			
			return pedido;
		}else if(operacao.equals("REMOVECARRINHO")) {
			pedido = (Pedido) request.getSession().getAttribute("carrinho");
			produtos = pedido.getProdutos();
			if(pedido.getStatus() == null) {
				for(Produto produto:produtos) {
					if(produto.getLivro().getId() == Integer.parseInt(request.getParameter("txtLivId"))) {
						produto.setFlgRemover(true);
					}
				}
				pedido.setProdutos(produtos);
				
				return pedido;
			}
		}else if(operacao.equals("ADDCARRINHO")) {
			if(request.getSession().getAttribute("carrinho") != null) {
				pedido = (Pedido) request.getSession().getAttribute("carrinho");
				produtos = pedido.getProdutos();
				Produto produto = new Produto();
				for(Produto prod:pedido.getProdutos()) {
					if(prod.getLivro().getId() == Integer.parseInt(request.getParameter("txtLivId"))) {
						qtd = Integer.parseInt(request.getParameter("txtQtd")) + prod.getQuantidade();
						prod.setQuantidadeAnterior(prod.getQuantidade());
						subtotal = qtd*prod.getLivro().getPrecoUnit();
						total = pedido.getValorTotal();
						total += Integer.parseInt(request.getParameter("txtQtd")) * prod.getLivro().getPrecoUnit();
						prod.setSubtotal(subtotal);
						prod.setQuantidade(qtd);
						prod.setFlgRemover(true);
						pedido.setValorTotal(total);
						return pedido;
					}
				}
				
				produto.setLivro(new Livro());
				produto.setQuantidadeAnterior(produto.getQuantidade());
				produto.getLivro().setId(Integer.parseInt(request.getParameter("txtLivId")));
				produto.getLivro().setTitulo(request.getParameter("txtTitulo"));
				produto.setQuantidade(Integer.parseInt(request.getParameter("txtQtd")));
				produto.getLivro().setPrecoUnit(Double.parseDouble(request.getParameter("txtSubTotal")));
				produto.setSubtotal(produto.getQuantidade()*Double.parseDouble(request.getParameter("txtSubTotal")));
				total = pedido.getValorTotal() + produto.getSubtotal();
				produto.setFlgRemover(true);
				pedido.setValorTotal(total);
				produtos.add(produto);
				pedido.setProdutos(produtos);
				
				return pedido;
			}else {
				Pedido ped = new Pedido();
				ped.setCliente(new Cliente());
				ped.getCliente().setsNome(cliente.getsNome());
				ped.getCliente().setId(cliente.getId());
				produtos = new ArrayList<Produto>();
				Produto produto = new Produto();
				produto.setLivro(new Livro());
				produto.getLivro().setId(Integer.parseInt(request.getParameter("txtLivId")));
				produto.getLivro().setTitulo(request.getParameter("txtTitulo"));
				produto.getLivro().setPrecoUnit(Double.parseDouble(request.getParameter("txtSubTotal")));
				produto.setQuantidade(Integer.parseInt(request.getParameter("txtQtd")));
				produto.setSubtotal(produto.getQuantidade()*Double.parseDouble(request.getParameter("txtSubTotal")));
				produto.setFlgRemover(true);
				produtos.add(produto);
				ped.setProdutos(produtos);
				ped.setValorTotal(produto.getSubtotal());
				return ped;
			}
		} else if(operacao.equals("REALIZAR-COMPRA")) {
			for(int i = 1; request.getParameter("Num"+i) != null; i++) {
				pedido = (Pedido) request.getSession().getAttribute("carrinho");
				produtos = pedido.getProdutos();
				qtd = produtos.get(i-1).getQuantidade();
				total = pedido.getValorTotal();
				if(produtos.get(i-1).getQuantidade() < Integer.parseInt(request.getParameter("Num"+i))) {
					produtos.get(i-1).setQuantidadeAnterior(produtos.get(i-1).getQuantidade());
					produtos.get(i-1).setQuantidade(Integer.parseInt(request.getParameter("Num"+i)));
					produtos.get(i-1).setFlgRemover(true);
					subtotal = 0;
					subtotal = produtos.get(i-1).getLivro().getPrecoUnit() * Integer.parseInt(request.getParameter("Num"+i));
					total += subtotal - produtos.get(i-1).getSubtotal();
					produtos.get(i-1).setSubtotal(subtotal);
					pedido.setProdutos(produtos);
					pedido.setValorTotal(total);
				}
			}
			return pedido;
		}else if(operacao.equals("FINALIZARCOMPRA")) {
			pedido = (Pedido) request.getSession().getAttribute("carrinho");
			Cliente cli = new Cliente();
			Cliente cliC = new Cliente();
			Cartao cart = new Cartao();
			ArrayList<Cartao> cartoes = new ArrayList<Cartao>();
			Endereco end = new Endereco();
			cli.setId(cliente.getId());
			cliC.setId(cliente.getId());
			if(!request.getParameter("ddlEndereco").equals("0")) {
				String op = request.getParameter("ddlEndereco");
				String array[] = new String[2];
				array = op.split(";");
				end.setCEP(array[0]);
				end.setNumerologradouro(array[1]);
			} else {
				end.setNome(request.getParameter("txtNomeEnd"));
				end.setCEP(request.getParameter("txtcep"));
				end.setBairro(request.getParameter("txtBairro"));
				end.setTipoLogradouro(request.getParameter("ddlTipoLogr"));
				end.setTipoResidencia(request.getParameter("ddlTipoRes"));
				end.setLogradouro(request.getParameter("txtrua"));
				end.setNumerologradouro(request.getParameter("txtnum"));
				end.setComp(request.getParameter("txtcomp"));
				end.setEstado(request.getParameter("ddlestado"));
				end.setCidade(request.getParameter("ddlcidade"));
				cli.setEnderecos(new ArrayList<Endereco>());
				cli.getEnderecos().add(end);
				if(Boolean.parseBoolean(request.getParameter("ckbSalvar"))) {
					ClienteDAO clidao = new ClienteDAO();
					clidao.salvar(cli);
				}
			}
			
			try {
				if(request.getParameter("txtCupomPromocional") != null || !request.getParameter("txtCupomPromocional").trim().equals("")) {
					pedido.setCupomPromocional(new CupomPromocional());
					pedido.getCupomPromocional().setId(Integer.parseInt(request.getParameter("txtCupomPromocional")));
				}
			}catch (Exception e) {
				// TODO: handle exception
			}
			String[] cupons=null;
			try {
				cupons = request.getParameterValues("ddlCupons");
			}catch (Exception e) {
				// TODO: handle exception
			}
			try {
				String array[] = new String[2];
				pedido.setCuponsTroca(new ArrayList<CupomTroca>());
				for(String cup:cupons) {
					array = cup.split(";");
					cpt = new CupomTroca();
					cpt.setId(Integer.parseInt(array[0]));
					cpt.setValor(Double.parseDouble(array[1]));
					pedido.getCuponsTroca().add(cpt);
				}
			}catch (Exception e) {
				// TODO: handle exception
			}

			pedido.setCliente(cli);
			pedido.setStatus("Esperando Aprovação");
			pedido.setEndEntrega(end);
			pedido.setFrete(45);
			pedido.setFormaDePagamento(request.getParameter("ddlMetodoPagamento"));
			
			if(!request.getParameter("ddlCartoes").equals("0")) {
				ArrayList<String>valores = new ArrayList<String>();
				cart.setsNumCartao(request.getParameter("ddlCartoes"));
				Map<String,String[]> parmMap = request.getParameterMap();
				for(String cartao:parmMap.get("ddlCartoes")) {
					cart = new Cartao();
					cart.setsNumCartao(cartao);
					cartoes.add(cart);
				}
				
				if(cartoes.size() > 1){
					for(String valor:parmMap.get("valorApagar")) {
						valores.add(valor);
						System.out.println(valor);
					}
					
					for(int i = 0;i < cartoes.size(); i++) {
						cartoes.get(i).setValorPago(Double.parseDouble(valores.get(i)));
						System.out.println(cartoes.get(i).getValorPago());
					}
				}else {
					cartoes.get(0).setValorPago(pedido.getValorTotal()+pedido.getFrete());
				}
			}else {
				cart.setsNumCartao(request.getParameter("txtNumCartao"));
				cart.setsCodSeguranca(request.getParameter("txtCodSeg"));
				cart.setsBandeira(request.getParameter("btnBandeira"));
				cart.setsNomeTitular(request.getParameter("txtTitular"));
				cart.setDtDataVal(request.getParameter("ddlAno") + "-" + request.getParameter("ddlMes") + "-01");
				if(Boolean.parseBoolean(request.getParameter("ckbSalvarCartao"))) {
					cliC.setCartoes(new ArrayList<Cartao>());
					cliC.getCartoes().add(cart);
					ClienteDAO clidao = new ClienteDAO();
					clidao.salvar(cliC);
				}
				cart.setValorPago(pedido.getValorTotal()+pedido.getFrete());
				cartoes.add(cart);
			}
			pedido.setCartao(cartoes);
			
			return pedido;
		}else if(operacao.equals("CONSULTAR-ADMIN") || operacao.equals("CONSULTAR") || operacao.equals("CONSULTAR-TROCA") || operacao.equals("CONSULTAR-TROCAS-ADMIN")) {
			Pedido ped = new Pedido();
			
			try {
				ped.setId(Integer.parseInt(request.getParameter("txtId")));
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			try {
				ped.setStatus(request.getParameter("txtStatusP"));
				ped.setFormaDePagamento(request.getParameter("txtFormPagamento"));
				ped.getCartao().add(new Cartao());
				ped.getCartao().get(0).setsNumCartao(request.getParameter("txtNumCartao"));
				ped.setEndEntrega(new Endereco());
				ped.getEndEntrega().setCEP(request.getParameter("txtCEP"));
				ped.getEndEntrega().setNumerologradouro(request.getParameter("txtNumLogradouro"));
			}catch (Exception e) {
				// TODO: handle exception
			}
		
			try {
				flgTroca = request.getParameter("txtTroca").equals("true") ? true:false;
			}catch(Exception e) {
				flgTroca = false;
			}
			
			try {
				ped.setFlgTroca(flgTroca);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			try {
				ped.setValorTotal(Double.parseDouble(request.getParameter("txtValorTotal")));
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			try {
				ped.setDtCadastro(Date.valueOf(request.getParameter("dtDataPedido")));
			}catch (Exception e) {
				// TODO: handle exception
			}
			return ped;
		}else if(operacao.equals("REALIZAR-TROCA")) {
			pedido = (Pedido) request.getSession().getAttribute("pedido-troca");

			for(Produto prod:pedido.getProdutos()) {
				for(int i=1; request.getParameter("ckbTrocar"+i) != null; i++) {
					if(Integer.parseInt(request.getParameter("Id"+i)) == prod.getLivro().getId()) {
						prod.setQuantidadeAnterior(prod.getQuantidade());
						prod.setQuantidade(Integer.parseInt(request.getParameter("Num"+i)));
						prod.getLivro().setPrecoUnit(prod.getSubtotal()/prod.getQuantidade());
						prod.setSubtotal(prod.getQuantidade()*prod.getLivro().getPrecoUnit());
						total += prod.getSubtotal();
						prod.setFlgRemover(true);
					}
				}
			}
			pedido.setValorTotal(total);
			pedido.setFlgTroca(true);
			
			return pedido;
		}else if(operacao.equals("VISUALIZAR-ADMIN") || operacao.equals("VISUALIZAR") || operacao.equals("VISUALIZAR-TROCA")) {
			HttpSession session = request.getSession();
			Resultado resultado2 = (Resultado) session.getAttribute("pedidos");
			int txtId = Integer.parseInt(request.getParameter("txtId"));
			
			for(EntidadeDominio ped: resultado2.getEntidades()) {
				if(ped.getId() == txtId) {
					pedido = (Pedido)ped;
				}
			}
		}else if(operacao.equals("ALTERAR-CUPOM")) {
			pedido.setStatus(request.getParameter("txtStatus"));
			try {
				flgTroca = request.getParameter("txtTroca").equals("true") ? true:false;
			}catch(Exception e) {
				flgTroca = false;
			}
			
			try {
				pedido.setFlgTroca(flgTroca);
			}catch (Exception e) {
				// TODO: handle exception
			}
			pedido.setId(Integer.parseInt(request.getParameter("txtId")));
			pedido.getCliente().setId(Integer.parseInt(request.getParameter("txtCliId")));
			pedido.setValorTotal(Double.parseDouble(request.getParameter("txtValorTotal")));
			
			return pedido;
		}
		
		return pedido;
	}

	@Override
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		RequestDispatcher d = null;
		String operacao = request.getParameter("operacao");
		
		if(resultado.getMsg() == null && operacao.equals("ADDCARRINHO")) {
			Pedido pedido = (Pedido) resultado.getEntidades().get(0);
			for(Produto prod:pedido.getProdutos()) {
				if(prod.isFlgRemover()) {
					prod.setFlgRemover(false);	
					break;
				}
			}
			resultado.getEntidades().remove(0);
			resultado.getEntidades().add(pedido);
			request.getSession().setAttribute("carrinho", resultado.getEntidades().get(0));
			
			d = request.getRequestDispatcher("ClienteLogado.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR")) {
			request.getSession().setAttribute("pedido", resultado.getEntidades().get(0));
			
			d = request.getRequestDispatcher("Visualizar-Pedido.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR-ADMIN")) {
			request.getSession().setAttribute("pedido", resultado.getEntidades().get(0));
			
			d = request.getRequestDispatcher("Visualizar-PedidoAdmin.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR-TROCA")) {
			request.getSession().setAttribute("pedido-troca", resultado.getEntidades().get(0));
			
			d = request.getRequestDispatcher("Pedido-Troca.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("REMOVECARRINHO")) {
			Pedido pedido = (Pedido) resultado.getEntidades().get(0);
			for(Produto prod:pedido.getProdutos()) {
				if(prod.isFlgRemover()) {
					pedido.getProdutos().remove(prod);
					break;
				}
			}
			resultado.getEntidades().remove(0);
			resultado.getEntidades().add(pedido);
			request.getSession().setAttribute("carrinho", resultado.getEntidades().get(0));
			
			d = request.getRequestDispatcher("carrinho.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("REALIZAR-COMPRA")) {
			Pedido pedido = (Pedido) resultado.getEntidades().get(0);
			for(Produto prod:pedido.getProdutos()) {
				if(prod.isFlgRemover()) {
					prod.setFlgRemover(false);
				}
			}
			resultado.getEntidades().remove(0);
			resultado.getEntidades().add(pedido);
			request.getSession().setAttribute("carrinho", resultado.getEntidades().get(0));
			
			d = request.getRequestDispatcher("Pagamento.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("FINALIZARCOMPRA")) {
			request.getSession().setAttribute("carrinho", null);
			
			d = request.getRequestDispatcher("ClienteLogado.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("REALIZAR-TROCA")) {
			d = request.getRequestDispatcher("ClienteLogado.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("CONSULTAR-ADMIN")) {
			request.getSession().setAttribute("pedidos", resultado);
			
			d = request.getRequestDispatcher("GerenciarPedido.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("CONSULTAR")) {
			request.getSession().setAttribute("pedidos", resultado);
			
			d = request.getRequestDispatcher("pedidos.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("CONSULTAR-TROCA")) {
			request.getSession().setAttribute("pedidos", resultado);
			
			d = request.getRequestDispatcher("trocas.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("CONSULTAR-TROCAS-ADMIN")) {
			request.getSession().setAttribute("pedidos", resultado);
			
			d = request.getRequestDispatcher("GerenciarTroca.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("ALTERAR-CUPOM")) {
			d = request.getRequestDispatcher("Index.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("ALTERAR")) {
			request.getSession().setAttribute("pedido", null);
			
			d = request.getRequestDispatcher("Index.jsp");
		}
		
		if(resultado.getMsg() != null && operacao.equals("FINALIZARCOMPRA")) {
			
			d = request.getRequestDispatcher("carrinho.jsp");
		}
		
		/*if(resultado.getMsg() != null) {
			request.getSession().setAttribute("erro", resultado);
			d = request.getRequestDispatcher("Erro.jsp");
		}*/
		
		d.forward(request, response);
	}

}
