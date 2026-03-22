package code.salecar.service.user;

import code.salecar.dao.UserDao;
import code.salecar.model.User;

import java.util.List;

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

    public User getUserById(int id) {
        return  ud.getUserById(id);
    }

    public User getUserByEmail(String email) {
        return ud.getUserByEmail(email);
    }

    public List<User> getList() {
        return ud.getList();
    }

    public void deleteUserById(int id) {
        ud.deleteUserById(id);
    }

    public List<User> getUserBykeyWord(String keyword) {
        return ud.getUserByKeyWord(keyword);
    }

    public List<User> filterUser(String role, String status) {
        boolean stat = true;
        if(status.equals("")){
            return ud.filterByRole(role);
        }
        if(status.equals("false")){
            stat = false;
        }
        return ud.fileUser(role,stat);
    }
}
