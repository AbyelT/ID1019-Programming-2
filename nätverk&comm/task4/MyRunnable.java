import java.net.*;
import java.io.*;
import java.nio.charset.StandardCharsets;

public class MyRunnable implements Runnable {
    private static Socket socket;

    public MyRunnable(Socket s) {
        this.socket = s;
    }

    // makes sure all %20 is replaced with blankspace
    public void run() {
        try {
            serve();
        } catch (IOException e) {
            System.out.println(e.toString());
        }
    }

    private static void serve() throws IOException{
        BufferedReader buff = null;
        BufferedWriter wuff = null;
        try {
            while (true) {
                buff = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                wuff = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
                String sHost = "";
                int sPort = 0;
                String sQuery = null;

                String request = URLDecoder.decode(buff.readLine(), StandardCharsets.UTF_8.name());
                request = request.substring(4, request.length());
                if (!request.substring(0, 5).equals("/ask?")) // check if the HTTP request is valid
                    throw new Exception("HTTP/1.1 404 page not found");
                else {
                    URL theUrl = new URL("http://localhost" + request);
                    String[] arry = theUrl.getQuery().split("[=?&]");
                    if (!(arry[0].equals("hostname") && arry[2].equals("port"))) { // checks if the given query is valid
                        throw new Exception("HTTP/1.1 400 bad request");
                    } else {
                        if (arry.length > 4) {
                            if (!arry[4].equals("string"))
                                throw new Exception("HTTP/1.1 400 bad request");
                            else
                                sQuery = arry[5].split(" HTTP/1.1")[0];
                        }
                        sHost = arry[1];
                        sPort = Integer.parseInt(arry[3].split(" HTTP/1.1")[0]);
                        String serverOutput = TCPClient.askServer(sHost, sPort, sQuery);
                        wuff.write(serverOutput);
                    }
                }
                wuff.close();
            }
        } catch (Exception e) {
            wuff.write(e.toString());
        }
    }
}