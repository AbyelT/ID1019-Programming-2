import java.net.*;
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
            BufferedReader buff = new BufferedReader(new InputStreamReader(newClient.getInputStream()));
            BufferedWriter wuff = new BufferedWriter(new OutputStreamWriter(newClient.getOutputStream()));

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
                    System.out.println(serverOutput); 
                    wuff.write(serverOutput);
                } 
            }
            catch(UnknownHostException e) {
                wuff.write("404 page not found");
            }
            catch(SocketTimeoutException e) {
                wuff.write("408 connection timed out");
            }
            catch(Exception e) {
                System.out.println(e);                 
                wuff.write("400 bad syntax");
            }
            wuff.close();
            in.close();
            out.close();
        }
    }
}

