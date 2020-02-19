import java.net.*;
import java.io.*;

public class ConcHTTPAsk {
    public static void main(String[] args) throws IOException{
        int port = Integer.parseInt(args[0]);
        ServerSocket server = new ServerSocket(port);
        StringBuilder sb;             
        System.out.println("Running server, port: " + port);

        while(true){
            Socket newClient = server.accept();
            try{
                MyRunnable runIt = new MyRunnable(newClient);
                Thread t = new Thread(runIt);
                t.start();
            }
            catch(Exception e) {
                System.out.println(e.toString());
            }
        }
    }
}