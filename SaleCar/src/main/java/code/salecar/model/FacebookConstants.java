package code.salecar.model;

public class FacebookConstants {
    public static String FACEBOOK_APP_ID = "";
    public static String FACEBOOK_APP_SECRET = "";
    public static String FACEBOOK_REDIRECT_URL = "http://localhost:8080/login/loginFacebook";
    public static String FACEBOOK_LINK_GET_TOKEN = "https://graph.facebook.com/v18.0/oauth/access_token?client_id=%s&client_secret=%s&redirect_uri=%s&code=%s";
}
