package code.salecar.service.address;

import code.salecar.dao.AddressDao;
import code.salecar.model.Address;

import java.util.ArrayList;

public class AddressService {
    AddressDao ad = new AddressDao();
    public void setMainAddress(int addressId,int userId) {
        ad.setMainAddress(addressId,userId);

    }

    public void addAddress(Address address) {
        ad.addAddress(address);
    }

    public void removeAddressById(int id) {
        ad.removeAddressById(id);
    }

    public ArrayList<Address> getListAddressById(int id) {
        return ad.getListAddressById(id);
    }

    public void updateAddress(Address a) {
        ad.updateAddress(a);
    }
}
