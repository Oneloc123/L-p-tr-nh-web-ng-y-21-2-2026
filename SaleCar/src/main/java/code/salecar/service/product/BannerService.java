package code.salecar.service.product;

import code.salecar.dao.BannerDAO;
import code.salecar.model.enumeration.Status;
import code.salecar.model.product.entity.Banner;

import java.util.List;

public class BannerService {
    private final BannerDAO bannerDAO = new BannerDAO();

    /**
     * Parse status filter param: "active" -> 1, "inactive" -> 0, else -1 (all).
     */
    private int parseStatusParam(String statusParam) {
        if (statusParam == null || statusParam.isEmpty()) return -1;
        if ("active".equalsIgnoreCase(statusParam)) return 1;
        if ("inactive".equalsIgnoreCase(statusParam)) return 0;
        return -1;
    }

    public List<Banner> getBanners(String search, String statusParam, String sort, String order, int limit, int page) {
        return bannerDAO.getBanners(search, parseStatusParam(statusParam), sort, order, limit, page);
    }

    public int countBanners(String search, String statusParam) {
        return bannerDAO.countBanners(search, parseStatusParam(statusParam));
    }

    public Banner getBannerById(long id) {
        return bannerDAO.getBannerById(id);
    }

    public long insertBanner(Banner banner) {
        return bannerDAO.insertBanner(banner);
    }

    public boolean updateBanner(Banner banner) {
        return bannerDAO.updateBanner(banner);
    }

    public boolean deleteBanner(long id) {
        return bannerDAO.deleteBanner(id);
    }

    public boolean toggleStatus(long id) {
        return bannerDAO.toggleStatus(id);
    }
}
