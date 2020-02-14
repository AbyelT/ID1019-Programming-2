import java.net.*;
import java.util.Scanner;
import java.io.*;

public class HTTPAsk {
    public static void main(String[] args) throws IOException{
        //starta server
        int port = Integer.parseInt(args[0]);
        ServerSocket server = new ServerSocket(port);
        StringBuilder sb;             
        System.out.println("Running server, port: " + port);

        while(true) {
            Socket newClient = server.accept();
            InputStream in = newClient.getInputStream();
            OutputStream out = newClient.getOutputStream();
            InputStreamReader iRead = new InputStreamReader(in);    //used as a bridge between byte-stream and char-streams
            BufferedReader buff = new BufferedReader(iRead);
            OutputStreamWriter iWrite = new OutputStreamWriter(out);
            BufferedWriter wuff = new BufferedWriter(iWrite);

            try{
                //fetch the given request
                String request = buff.readLine();
                request = request.substring(5, request.length());
                String[] parameters = request.split("[=?& ]");

                if(parameters[0].equals("ask")) {
                    //extract the hostname, port and if possible the string
                    String sHost = "";
                    int sPort = 0;
                    String sString = null;
                    
                    if(parameters[1].equals("hostname")) 
                        sHost = parameters[2];
                    if(parameters[3].equals("port")) 
                        sPort = Integer.parseInt(parameters[4]);    
                    if(parameters[5].equals("string"))
                        sString = parameters[6];

                    //öppna förbindelse till given hostname, port
                    String serverOutput = TCPClient.askServer(sHost, sPort, sString);                
                    wuff.write(serverOutput);
                }
                else 
                    System.out.println(request);                 
            }
            catch(SocketException e) {
                wuff.write("404 page not found!");
            }
            catch(IOException e) {
                wuff.write("400 bad syntax!");
            }
            wuff.close();
            in.close();
            out.close();
        }
    }
}

