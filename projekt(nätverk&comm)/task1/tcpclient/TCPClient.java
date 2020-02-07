package tcpclient;
import java.net.*;
import java.io.*;
/**
 * TCP client acts as an client-side of an TCP communication, it creates an TCP
 * socket and uses them to send and recive data from a server-side process.
 */
public class TCPClient {
    /**
     * askServer creates an TCP socket and through it sends and receives data from a
     * server. Depending if the user included query, one of the two methods is used
     *
     * @param hostname the hostname of the web server to connect
     * @param port     the portnumber of the server-side process
     * @param ToServer the query sent to the server
     * @return a string containing the response from the server
     */
    public static String askServer(String hostname, int port, String ToServer) throws IOException {
        if (ToServer == null)
            return askServer(hostname, port);
        else {
            byte[] fromServer = new byte[2048];
            byte[] fromUser = new byte[2048];
            StringBuilder sb = new StringBuilder();
            Socket mySocket;
            try {
                mySocket = new Socket(hostname, port);
                char[] arry = ToServer.toCharArray();
                for (int i = 0; i < arry.length; i++) {
                    Integer toByte = (int) arry[i];
                    fromUser[i] = toByte.byteValue();
                }
                mySocket.getOutputStream().write(fromUser);
                mySocket.getOutputStream().write('\n');
                mySocket.setSoTimeout(3000);
                int length = mySocket.getInputStream().read(fromServer);
                int i = 0;
                while (i < length && fromServer[i] != -1) {
                    sb.append((char)fromServer[i++]);
                }
                mySocket.close();
            } catch (SocketException e) {
                sb.append("Connection to the host timed out");
            }
            return sb.toString();
        }
    }

    public static String askServer(String hostname, int port) throws IOException {
        byte[] fromServer = new byte[1024];
        StringBuilder sb = new StringBuilder();
        try {
            Socket mySocket = new Socket(hostname, port);
            mySocket.setSoTimeout(3000);
            int length = mySocket.getInputStream().read(fromServer);
            int i = 0;
            while (i < length && fromServer[i] != -1) {
                sb.append((char)fromServer[i++]); 
            }
            mySocket.close();
        } catch (SocketException e) {
            sb.append("Connection to the host timed out");
        }
        return sb.toString();
    }
}
