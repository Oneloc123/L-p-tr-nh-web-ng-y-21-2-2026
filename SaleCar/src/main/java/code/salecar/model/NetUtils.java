package code.salecar.model;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import org.apache.http.client.fluent.Request;

public class NetUtils {
    public static String getToken(final String code) throws IOException {
        String link = String.format(FacebookConstants.FACEBOOK_LINK_GET_TOKEN, FacebookConstants.FACEBOOK_APP_ID,
                                    FacebookConstants.FACEBOOK_APP_SECRET, FacebookConstants.FACEBOOK_REDIRECT_URL, code);
        String response = Request.Get(link).execute().returnContent().asString();
        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }
    public static FacebookUser getUserInfo(String accessToken) throws IOException {
        String link = "https://graph.facebook.com/me?fields=id,name,email&access_token=" + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        FacebookUser fbUser = new Gson().fromJson(response, FacebookUser.class);
        return fbUser;
    }
}
