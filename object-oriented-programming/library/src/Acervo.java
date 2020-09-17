import java.util.*;

public class Acervo {
	private ArrayList<ItemBibliografico> itens = new ArrayList<ItemBibliografico>();

	public String formataItens() {
		String result = "";
		for (int i = 0; i < itens.size(); i++) {
			result += itens.get(i).toString();
		}
		return result;
	}

	public void addItem(ItemBibliografico i) {
		itens.add(i);
	}

	public ItemBibliografico getItem(int i) {
		return itens.get(i);
	}

	public int size() {
		return itens.size();
	}
}
