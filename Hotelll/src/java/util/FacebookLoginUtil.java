package util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class FacebookLoginUtil {

    public static final String FACEBOOK_APP_ID = "969411312109569";
    public static final String FACEBOOK_APP_SECRET = "676e0dc9514bd48b5c46a03d7939befe";
    public static final String FACEBOOK_REDIRECT_URL = "http://localhost:8080/Hotelll/login/facebook";
    public static final String FACEBOOK_LINK_GET_TOKEN = "https://graph.facebook.com/oauth/access_token?client_id=%s&client_secret=%s&redirect_uri=%s&code=%s";

    public static String getToken(String code) throws Exception {
        String link = String.format(FACEBOOK_LINK_GET_TOKEN, FACEBOOK_APP_ID, FACEBOOK_APP_SECRET,
                FACEBOOK_REDIRECT_URL, code);
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

    public static FacebookAccount getUserInfo(String accessToken) throws Exception {
        String link = "https://graph.facebook.com/me?fields=id,name,email,picture&access_token=" + accessToken;
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
        FacebookAccount acc = new FacebookAccount();
        acc.id = extractJsonString(json, "id");
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

    public static class FacebookAccount {
        public String id;
        public String email;
        public String name;
    }
}
