package code.salecar.service.address;

import code.salecar.dao.AddressDao;
import code.salecar.dao.AddressesDao;
import code.salecar.model.Address;
import code.salecar.model.Addresses;

import java.util.ArrayList;
import java.util.List;

public class AddressesService {
    AddressesDao ad = new AddressesDao();
    public void setMainAddress(int addressId,int userId) {
        ad.setMainAddress(addressId,userId);

    }

    public void addAddress(Addresses address) {
        ad.addAddress(address);
    }

    public void removeAddressById(int id) {
        ad.removeAddressById(id);
    }

    public ArrayList<Addresses> getListAddressById(int id) {
        return ad.getListAddressById(id);
    }

    public List<Addresses> getListAddress() {
        return ad.getListAddress();
    }
}
