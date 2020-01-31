package tcpclient;

import java.net.*;
import java.io.*;

/**
 * TCP client acts as an client-side of server communication, it creates TCP
 * sockets and uses them to send and recive data from a server-side process
 */
public class TCPClient {

    public static String askServer(String hostname, int port, String ToServer) throws IOException {
        if (ToServer == null)
            return askServer(hostname, port);
        else {
            byte[] fromServer = new byte[1024];
            byte[] fromUser =  new byte[1024];

            StringBuilder sb = new StringBuilder();
            Socket mySocket;

            try{
                mySocket = new Socket(hostname, port);

                //explicit conversion
                char[] arry = ToServer.toCharArray(); 
                for(int i=0; i < arry.length; i++) {
                    Integer toByte = (int)arry[i];
                    fromUser[i] = toByte.byteValue();
                }

                mySocket.getOutputStream().write(fromUser);
                mySocket.getOutputStream().write('\n');

                mySocket.setSoTimeout(1500);
                int length = mySocket.getInputStream().read(fromServer);

                int i=0;
                while(i < length && fromServer[i] != -1) {
                    char c = (char)fromServer[i++];
                    sb.append(c);
                }
                mySocket.close();
            }
            catch(SocketException e) {
                sb.append("Connection to the host timed out");}
            catch(IOException e) {
                sb.append("An error has occurred, please check that the hostname and portnumber is correct");}
            return sb.toString();
        }
    }

    /**
     * askServer creates an TCP socket and through it sends or receives data from a
     * server
     */
    public static String askServer(String hostname, int port) throws IOException {
        byte[] fromServer = new byte[1024];
        StringBuilder sb = new StringBuilder();

        try {
            Socket mySocket = new Socket(hostname, port);
            mySocket.setSoTimeout(1500);
            int length = mySocket.getInputStream().read(fromServer);
           
            int i=0;
            while(i < length && fromServer[i] != -1) {
                char c = (char)fromServer[i++];
                sb.append(c);
            }
            mySocket.close();
        }
        catch(UnknownHostException e){
            sb.append("The given hostname does not exist");}
        catch(IOException e){
            sb.append("An error has occurred, please check that the hostname and portnumber is correct");}
        return sb.toString();
    }
}
