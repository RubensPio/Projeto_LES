package LES12018.controle.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;
import java.util.HashMap;
import LES12018.controle.web.command.ICommand;
import LES12018.controle.web.command.impl.AlterarCommand;
import LES12018.controle.web.command.impl.AtivarCommand;
import LES12018.controle.web.command.impl.ConsultarCommand;
import LES12018.controle.web.command.impl.ExcluirCommand;
import LES12018.controle.web.command.impl.LogarCommand;
import LES12018.controle.web.command.impl.SalvarCommand;
import LES12018.controle.web.command.impl.VisualizarCommand;
import LES12018.controle.web.vh.IViewHelper;
import LES12018.controle.web.vh.impl.ClienteViewHelper;
import LES12018.controle.web.vh.impl.DadosParaLivroViewHelper;
import LES12018.controle.web.vh.impl.GraficoViewHelper;
import LES12018.controle.web.vh.impl.LivroViewHelper;
import LES12018.controle.web.vh.impl.PedidoViewHelper;
import LES12018.core.aplicacao.Resultado;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.Livro;
import les12018.dominio.Pedido;

/**
 * Servlet implementation class Servlet
 */
@WebServlet("/Servlet")
public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static Map<String, ICommand> commands;
	private static Map<String, IViewHelper> vhs;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Servlet() {
        super();
        commands = new HashMap<String, ICommand>();
        
        commands.put("SALVAR", new SalvarCommand());
        commands.put("ADDCARRINHO", new AlterarCommand());
        commands.put("REALIZAR-COMPRA", new AlterarCommand());
        commands.put("REMOVECARRINHO", new ExcluirCommand());
        commands.put("REALIZAR-TROCA", new SalvarCommand());
        commands.put("CONSULTAR-ADMIN", new ConsultarCommand());
        commands.put("CONSULTAR-TROCA", new ConsultarCommand());
        commands.put("CONSULTAR-TROCAS-ADMIN", new ConsultarCommand());
        commands.put("CONSULTAR-CUPOM", new ConsultarCommand());
        commands.put("CONSULTAR-COMPRA", new ConsultarCommand());
        commands.put("CONSULTAR-ESTOQUE", new ConsultarCommand());
        commands.put("GRAFICO", new ConsultarCommand());
        commands.put("FINALIZARCOMPRA", new SalvarCommand());
        commands.put("EXCLUIR", new ExcluirCommand());
        commands.put("ATIVAR", new AtivarCommand());
        commands.put("CONSULTAR", new ConsultarCommand());
        commands.put("VISUALIZAR", new VisualizarCommand());
        commands.put("VISUALIZAR-ADMIN", new VisualizarCommand());
        commands.put("VISUALIZAR-TROCA", new VisualizarCommand());
        commands.put("ALTERAR", new AlterarCommand());
        commands.put("ALTERAR-CUPOM", new AlterarCommand());
        commands.put("ADICIONAR-AO-ESTOQUE", new AlterarCommand());
        commands.put("REMOVER-ESTOQUE", new AlterarCommand());
        commands.put("LOGAR", new LogarCommand());
        
        vhs = new HashMap<String, IViewHelper>();
        
        vhs.put("/LES12018_web/SalvarLivro", new LivroViewHelper());
        vhs.put("/LES12018_web/DadosParaLivro", new DadosParaLivroViewHelper());
        vhs.put("/LES12018_web/Livros", new LivroViewHelper());
        vhs.put("/LES12018_web/SalvarCliente", new ClienteViewHelper());
        vhs.put("/LES12018_web/Login", new ClienteViewHelper());
        vhs.put("/LES12018_web/Pedido", new PedidoViewHelper());
        vhs.put("/LES12018_web/Grafico", new GraficoViewHelper());
    }

    /**
     * TODO Descri��o do M�todo
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
    		IOException {
    	doProcessRequest(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcessRequest(request, response);
	}
	
	
	protected void doProcessRequest(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		//Obt�m a uri que invocou esta servlet (O que foi definido no methdo do form html)
		String uri = request.getRequestURI();
		//System.out.println(uri);
		
		//Obt�m a opera��o executada
		String operacao = request.getParameter("operacao");
		//System.out.println(operacao);
		
		//Obt�m um viewhelper indexado pela uri que invocou esta servlet
		IViewHelper vh = vhs.get(uri);
		//System.out.println(vh.getClass().getName());
		
		//O viewhelper retorna a entidade especifica para a tela que chamou esta servlet
		EntidadeDominio entidade =  vh.getEntidade(request);
		
		//Obt�m o command para executar a respectiva opera��o
		ICommand command = commands.get(operacao);
		/*Executa o command que chamar� a fachada para executar a opera��o requisitada
		 * o retorno � uma inst�ncia da classe resultado que pode conter mensagens derro 
		 * ou entidades de retorno
		 */
		//System.out.println(command.getClass().getName());
		Resultado resultado = new Resultado();
		try {
			resultado = command.execute(entidade);
		}catch (Exception e) {
		}
		/*
		 * Executa o m�todo setView do view helper espec�fico para definir como dever� ser apresentado 
		 * o resultado para o usu�rio
		 */
		vh.setView(resultado, request, response);
	
	}
}
