package les12018.dominio;

import les12018.auxiliar.ItemsGrafico;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

public class DadosParaGrafico extends EntidadeDominio{
	private ArrayList<ItemsGrafico> items = new ArrayList<ItemsGrafico>();
	private Date dataInicial;
	private Date dataFinal;
	private int totalCat;

	public Date getDataFinal() {
		return dataFinal;
	}

	public void setDataFinal(Date dataFinal) {
		this.dataFinal = dataFinal;
	}

	public Date getDataInicial() {
		return dataInicial;
	}

	public void setDataInicial(Date dataInicial) {
		this.dataInicial = dataInicial;
	}

	public ArrayList<ItemsGrafico> getItems() {
		return items;
	}

	public void setItems(ArrayList<ItemsGrafico> items) {
		this.items = items;
	}

	public int getTotalCat() {
		return totalCat;
	}

	public void setTotalCat(int totalCat) {
		this.totalCat = totalCat;
	}
}
