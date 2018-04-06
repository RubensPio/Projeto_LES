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
import LES12018.controle.web.command.impl.SalvarCommand;
import LES12018.controle.web.command.impl.VisualizarCommand;
import LES12018.controle.web.vh.IViewHelper;
import LES12018.controle.web.vh.impl.DadosParaLivroViewHelper;
import LES12018.controle.web.vh.impl.LivroViewHelper;
import LES12018.core.aplicacao.Resultado;
import les12018.dominio.EntidadeDominio;
import les12018.dominio.Livro;

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
        commands.put("ATIVAR", new AtivarCommand());
        commands.put("CONSULTAR", new ConsultarCommand());
        commands.put("VISUALIZAR", new VisualizarCommand());
        commands.put("ALTERAR", new AlterarCommand());
        
        vhs = new HashMap<String, IViewHelper>();
        
        vhs.put("/LES12018_web/SalvarLivro", new LivroViewHelper());
        vhs.put("/LES12018_web/DadosParaLivro", new DadosParaLivroViewHelper());
        vhs.put("/LES12018_web/Livros", new LivroViewHelper());
    }

    /**
     * TODO Descrição do Método
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
		//Obtêm a uri que invocou esta servlet (O que foi definido no methdo do form html)
		String uri = request.getRequestURI();
		//System.out.println(uri);
		
		//Obtêm a operação executada
		String operacao = request.getParameter("operacao");
		//System.out.println(operacao);
		
		//Obtêm um viewhelper indexado pela uri que invocou esta servlet
		IViewHelper vh = vhs.get(uri);
		//System.out.println(vh.getClass().getName());
		
		//O viewhelper retorna a entidade especifica para a tela que chamou esta servlet
		EntidadeDominio entidade =  vh.getEntidade(request);
		
		//Obtêm o command para executar a respectiva operação
		ICommand command = commands.get(operacao);
		/*Executa o command que chamará a fachada para executar a operação requisitada
		 * o retorno é uma instância da classe resultado que pode conter mensagens derro 
		 * ou entidades de retorno
		 */
		//System.out.println(command.getClass().getName());
		Resultado resultado = command.execute(entidade);
		
		/*
		 * Executa o método setView do view helper específico para definir como deverá ser apresentado 
		 * o resultado para o usuário
		 */
		vh.setView(resultado, request, response);
	
	}
}
