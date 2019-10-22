package com.marshmellow.util;

import java.io.*;
import org.apache.commons.net.telnet.TelnetClient;
 
public class TelnetConnect {
 
    private TelnetClient telnet = new TelnetClient();
    private InputStream in = null;
    private PrintStream out = null;
    private char prompt = '$';
 
    public TelnetConnect(String server, String user, String password) {
        try {
            // telnet 서버로의 접속
            telnet.connect(server, 23);
 
            // 참조할 input, output stream 객체 획득
            in = telnet.getInputStream();
            out = new PrintStream(telnet.getOutputStream());
 
            // 사용자 로그온
            readUntil("login:");
            write(user);
            readUntil("Password:");
            write(password);
 
            // prompt 대기
            readUntil(prompt + " ");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
 
    /**
     * superuser로 전환 @param password superuser의 password @exception
     */
    public void su(String password) {
        try {
            write("su");
            readUntil("Password:");
            write(password);
            prompt = '#';
            readUntil(prompt + " ");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
 
    /**
     * @param pattern
     * @return java.lang.String
     */
    public String readUntil(String pattern) {
        try {
            char lastChar = pattern.charAt(pattern.length() - 1);
            StringBuffer sb = new StringBuffer();
            //boolean found = false;
            char ch = (char) in.read();
 
            while (true) {
                System.out.print(ch);
                sb.append(ch);
                if (ch == lastChar) {
                    if (sb.toString().endsWith(pattern)) {
                        return sb.toString();
                    }
                }
 
                ch = (char) in.read();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
 
        return null;
    }
 
    /**
     * 생성된 output stream에 value를 전송한다. @param value stream으로 전송할 String
     * value @exception
     */
    public void write(String value) {
        try {
            out.println(value);
            out.flush();
            System.out.println(value);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
 
    /**
     * Telnet 명령어를 전송한다. @param command telnet 서버로 전송할 명령어 @exception
     */
    public String sendCommand(String command) {
        try {
            write(command);
            return readUntil(prompt + " ");
        } catch (Exception e) {
            e.printStackTrace();
        }
 
        return null;
    }
 
    /**
     * Telnet 접속을 해제한다.
     */
    public void disconnect() {
        try {
            telnet.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}