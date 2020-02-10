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
        ServerSocket server = new ServerSocket(portNr);             //create a server socket to port 20
        System.out.println("Running server, port: " + portNr);
        StringBuilder sb;
        String s;

        while(true) {
            Socket newClient = server.accept();
            InputStream in = newClient.getInputStream();
            OutputStream out = newClient.getOutputStream();

            sb = new StringBuilder("HTTP/1.1 200 OK\r\n\r\n");
            InputStreamReader iRead = new InputStreamReader(in);    //used as a bridge between byte-stream and char-streams
            BufferedReader buff = new BufferedReader(iRead);
            
            while(!((s = buff.readLine()).equals(""))) {
                sb.append(s + "\r\n");
                //System.out.println(s + "row\r");
            }
                
            OutputStreamWriter iWrite = new OutputStreamWriter(out);
            BufferedWriter wuff = new BufferedWriter(iWrite);
                
            wuff.write(sb.toString());
            //wuff.write("hi there");
            //System.out.print(resp + sb.toString());
            wuff.close();
            in.close();
            out.close();
        }
    }
}
