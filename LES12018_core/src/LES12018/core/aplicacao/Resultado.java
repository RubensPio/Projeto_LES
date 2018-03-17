package LES12018.core.aplicacao;

import java.util.List;
import les12018.dominio.EntidadeDominio;

public class Resultado extends EntidadeAplicacao{
		private String msg;
		private List<EntidadeDominio> entidades;
		
		public String getMsg() {
			return msg;
		}
		public void setMsg(String msg) {
			this.msg = msg;
		}
		public List<EntidadeDominio> getEntidades() {
			return entidades;
		}
		public void setEntidades(List<EntidadeDominio> entidades) {
			this.entidades = entidades;
		}
		
		
}
