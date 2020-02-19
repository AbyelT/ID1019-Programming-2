import java.net.*;
import java.io.*;

public class HTTPAsk2 {
    public static void main(String[] args) throws IOException {
        int port = Integer.parseInt(args[0]);
        ServerSocket server = new ServerSocket(port);
        System.out.println("Running server, port: " + port);

        while (true) {
            Socket newClient = server.accept();
            BufferedReader buff = new BufferedReader(new InputStreamReader(newClient.getInputStream()));
            BufferedWriter wuff = new BufferedWriter(new OutputStreamWriter(newClient.getOutputStream()));
            try {
                String request = buff.readLine();
                request = request.substring(4, request.length());
                request = "http://localhost:" + port + request;
                URL theUrl = new URL(request);
                String string = theUrl.getQuery();
                if ((string = theUrl.getQuery()) != null) {
                    String[] arry = string.split("[=?& ]");
                    String sHost = arry[1];
                    int sPort = Integer.parseInt(arry[3]);
                    String sQuery = arry[5];
                    String serverOutput = TCPClient.askServer(sHost, sPort, sQuery);
                    wuff.write(serverOutput);
                }
            } 
            catch(UnknownHostException e) {
                wuff.write("404 page not found");
            }
            catch(SocketTimeoutException e) {
                wuff.write("408 connection timed out");
            }
            catch(SocketException e) {
                wuff.write("400 bad request");
            }
            catch(Exception e) {
                System.out.println(e);                 
            }
            wuff.close();
        }
    }
}
