package chavevalor;

import org.apache.thrift.server.TServer;
import org.apache.thrift.server.TServer.Args;
import org.apache.thrift.server.TSimpleServer;
import org.apache.thrift.transport.TServerSocket;
import org.apache.thrift.transport.TServerTransport;

import static chavevalor.ChaveValor.*;

public class ChaveValorServer{

    public static void main(String [] args){
        try{
            ChaveValorHandleExtendsChaveValor handler = new ChaveValorHandleExtendsChaveValor();
            Processor processor = new Processor(handler);
            TServerTransport serverTransport = new TServerSocket(9090);
            TServer server = new TSimpleServer (new Args(serverTransport).processor(processor));

            System.out.println("Starting the simple server...");
            server.serve();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
