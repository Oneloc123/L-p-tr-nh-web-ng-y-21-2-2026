package code.salecar.service.address;

import code.salecar.dao.AddressDao;

public class AddressService {
    AddressDao ad = new AddressDao();
    public void setMainAddress(int addressId,int userId) {
        ad.setMainAddress(addressId,userId);

    }
}
