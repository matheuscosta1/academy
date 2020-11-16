package chavevalor;

import org.apache.thrift.TException;

import java.util.HashMap;

public class ChaveValorHandleExtendsChaveValor implements ChaveValorHandleExtendsChaveValorInterface {
    private HashMap<Integer,String> kv = new HashMap<>();
    @Override
    public String getKV(int key) throws TException {
        if(kv.containsKey(key))
            return kv.get(key);
        else
            throw new KeyNotFound();
    }

    @Override
    public String setKV(int key, String valor) {
        String oldValue = "";
        if (kv.containsKey(key)) {
            oldValue = kv.get(key);
            System.out.println(oldValue);
        }
        kv.put(key,valor);
        return oldValue;

    }
    @Override
    public void delKV(int key) {
        kv.remove(key);
    }
}
