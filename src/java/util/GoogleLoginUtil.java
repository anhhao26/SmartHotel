package util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class GoogleLoginUtil {

    public static final String GOOGLE_CLIENT_ID = "1027963339074-9t9p9v3j5r8o5m4q4k6n7v7m1v7m1v7m.apps.googleusercontent.com";
    public static final String GOOGLE_CLIENT_SECRET = "GOCSPX-v7m1v7m1v7m1v7m1v7m1v7m1v7m";
    public static final String GOOGLE_REDIRECT_URL = "http://localhost:8080/Hotelll/login/google";
    public static final String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";

    public static String getToken(String code) throws Exception {
        String params = String.format("client_id=%s&client_secret=%s&redirect_uri=%s&code=%s&grant_type=authorization_code",
                GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET, GOOGLE_REDIRECT_URL, code);
        
        URL url = new URL(GOOGLE_LINK_GET_TOKEN);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        
        byte[] postDataBytes = params.getBytes("UTF-8");
        conn.setFixedLengthStreamingMode(postDataBytes.length);
        
        try (java.io.OutputStream os = conn.getOutputStream()) {
            os.write(postDataBytes);
        }

        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        StringBuilder response = new StringBuilder();
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        String json = response.toString();
        String tokenKey = "\"access_token\":\"";
        int startIndex = json.indexOf(tokenKey);
        if (startIndex == -1) {
            tokenKey = "\"access_token\": \"";
            startIndex = json.indexOf(tokenKey);
            if (startIndex == -1)
                return null;
        }
        startIndex += tokenKey.length();
        int endIndex = json.indexOf("\"", startIndex);
        return json.substring(startIndex, endIndex);
    }

    public static GoogleAccount getUserInfo(String accessToken) throws Exception {
        String link = "https://www.googleapis.com/oauth2/v3/userinfo?access_token=" + accessToken;
        URL url = new URL(link);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        StringBuilder response = new StringBuilder();
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        String json = response.toString();
        GoogleAccount acc = new GoogleAccount();
        acc.id = extractJsonString(json, "sub");
        acc.email = extractJsonString(json, "email");
        acc.name = extractJsonString(json, "name");
        return acc;
    }

    private static String extractJsonString(String json, String key) {
        String searchKey = "\"" + key + "\":\"";
        int startIndex = json.indexOf(searchKey);
        if (startIndex == -1) {
            searchKey = "\"" + key + "\": \"";
            startIndex = json.indexOf(searchKey);
            if (startIndex == -1)
                return null;
        }
        startIndex += searchKey.length();
        int endIndex = json.indexOf("\"", startIndex);
        return json.substring(startIndex, endIndex);
    }

    public static class GoogleAccount {
        public String id;
        public String email;
        public String name;
    }
}
