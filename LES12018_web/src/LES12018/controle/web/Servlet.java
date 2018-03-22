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
import LES12018.controle.web.command.impl.ConsultarCommand;
import LES12018.controle.web.command.impl.ExcluirCommand;
import LES12018.controle.web.command.impl.SalvarCommand;
import LES12018.controle.web.command.impl.VisualizarCommand;
import LES12018.controle.web.vh.IViewHelper;
import LES12018.controle.web.vh.impl.LivroViewHelper;
import LES12018.core.aplicacao.Resultado;
import les12018.dominio.EntidadeDominio;

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
        commands.put("EXCLUIR", new ExcluirCommand());
        commands.put("CONSULTAR", new ConsultarCommand());
        commands.put("VISUALIZAR", new VisualizarCommand());
        commands.put("ALTERAR", new AlterarCommand());
        
        vhs = new HashMap<String, IViewHelper>();
        
        vhs.put("/LES12018_web/", new LivroViewHelper());
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	protected void doProcessRequest(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
	
		//Obtêm a uri que invocou esta servlet (O que foi definido no methdo do form html)
		String uri = request.getRequestURI();
		
		//Obtêm a operação executada
		String operacao = request.getParameter("operacao");
		
		//Obtêm um viewhelper indexado pela uri que invocou esta servlet
		IViewHelper vh = vhs.get(uri);
		
		//O viewhelper retorna a entidade especifica para a tela que chamou esta servlet
		EntidadeDominio entidade =  vh.getEntidade(request);

		//Obtêm o command para executar a respectiva operação
		ICommand command = commands.get(operacao);
		
		
		/*Executa o command que chamará a fachada para executar a operação requisitada
		 * o retorno é uma instância da classe resultado que pode conter mensagens derro 
		 * ou entidades de retorno
		 */
		Resultado resultado = command.execute(entidade);
		
		/*
		 * Executa o método setView do view helper específico para definir como deverá ser apresentado 
		 * o resultado para o usuário
		 */
		vh.setView(resultado, request, response);
	
	}

}
