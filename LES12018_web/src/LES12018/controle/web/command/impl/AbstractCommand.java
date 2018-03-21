package LES12018.controle.web.command.impl;

import LES12018.controle.web.command.ICommand;
import LES12018.core.IFachada;
import LES12018.core.impl.controle.Fachada;

public abstract class AbstractCommand implements ICommand{
	protected IFachada fachada = new Fachada();
}
