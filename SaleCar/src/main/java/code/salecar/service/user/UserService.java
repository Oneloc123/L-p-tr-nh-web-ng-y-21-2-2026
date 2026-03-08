package code.salecar.service.user;

import code.salecar.dao.UserDao;
import code.salecar.model.User;

public class UserService {

    private UserDao ud = new UserDao();
    public User getUserByUsername(String username) {
    return ud.getUserByUsername(username);
    }

    public void register(User user) {
         ud.register(user);
    }

    public void UpdateProfile(User user) {
        ud.UpdateProfile(user);
    }

    public String getUserNameById(int userId) {
        return ud.getUserNameById( userId);
    }
}
