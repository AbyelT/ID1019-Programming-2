import java.net.*;
import java.io.*;

public class MyRunnable implements Runnable {
    private static Socket socket;

    public MyRunnable(Socket s) {
        this.socket = s;
    }

    public void run() {
        try {
            while (true) {
                BufferedReader buff = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                BufferedWriter wuff = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
                String sQuery;

                String request = buff.readLine();
                request = request.substring(4, request.length());
                request = "http://localhost:" + socket.getPort() + request;
                URL theUrl = new URL(request);
                String string = theUrl.getQuery();
                if ((string = theUrl.getQuery()) != null) {
                    String[] arry = string.split("[=?& ]");
                    String sHost = arry[1];
                    int sPort = Integer.parseInt(arry[3]);
                    if(arry.length > 5)
                        sQuery = arry[5];
                    else 
                        sQuery = null;
                    String serverOutput = TCPClient.askServer(sHost, sPort, sQuery);
                    wuff.write(serverOutput);
                }
                wuff.close();
            }
        } catch (IOException e) {
            //have a better exception handling
        }
    }
}