import java.net.*;
import java.io.*;

/**
 * HTTPEcho acts as a web-server process that accepts incoming
 * TCP connections, reads data and echoes an HTTP response back
 * the same data that was given.
 */

public class HTTPEcho {

    /**
     * main implements the server-side process by creating 
     * a socket with a port for clients to connect to, 
     * @param args the given port number
     * @throws IOException
     */
    public static void main(String[] args) throws IOException{
        
        int portNr = Integer.parseInt(args[0]);
        ServerSocket server = new ServerSocket(portNr); //create a server socket to port 20
        StringBuilder sb = new StringBuilder();

        while(true) {
            Socket newClient = server.accept();
            InputStream in = newClient.getInputStream();

            if(in.available() > 0) {
                InputStreamReader iRead = new InputStreamReader(in);    //used as a bridge between byte-stream and char-streams
                BufferedReader buff = new BufferedReader(iRead);

                while(buff.ready()) {
                    sb.append(buff.readLine() + "\n");}
            
                OutputStream out = newClient.getOutputStream();
                OutputStreamWriter iWrite = new OutputStreamWriter(out);
                BufferedWriter wuff = new BufferedWriter(iWrite);

                wuff.write(sb.toString());
                wuff.close();
            }
        }
    }
}
