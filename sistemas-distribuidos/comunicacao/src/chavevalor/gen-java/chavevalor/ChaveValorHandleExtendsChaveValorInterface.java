package chavevalor;

import org.apache.thrift.TException;

public interface ChaveValorHandleExtendsChaveValorInterface {

    String getKV(int key) throws TException;

    String setKV(int key, String valor) throws TException;

    void delKV(int key) throws TException;
}
