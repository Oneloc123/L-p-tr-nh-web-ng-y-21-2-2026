<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin - Chỉnh sửa Người dùng | LUXCAR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* (giữ nguyên toàn bộ style như bạn đã có) */
        .avatar-upload-section { text-align: center; margin-bottom: 30px; padding: 20px; background: #fff; border-radius: 20px; border: 1px solid #e9ecef; }
        .current-avatar img { width: 120px; height: 120px; border-radius: 50%; border: 3px solid #2c7da0; object-fit: cover; }
        .btn-upload { background: linear-gradient(135deg, #2c7da0, #1f5e7a); color: #fff; padding: 10px 24px; border-radius: 30px; cursor: pointer; }
        .address-box { border: 1px solid #e9ecef; border-radius: 16px; padding: 15px; margin-top: 10px; background: #fafcfd; }
        .address-box-header { display: flex; justify-content: space-between; align-items: center; }
        .btn-set-main { background: transparent; color: #0d6efd; border: 1px solid #0d6efd; border-radius: 8px; padding: 6px 14px; text-decoration: none; }
        .form-actions { display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px; }
        .btn-save { background: #2c7da0; border: none; padding: 8px 18px; border-radius: 30px; color: white; }
        .btn-cancel { border: 1px solid #e2e8f0; padding: 8px 18px; border-radius: 30px; color: #64748b; background: transparent; }
        body { background-color: #f1f5f9; font-family: 'Inter', sans-serif; }
        .sidebar { width: 280px; background-color: #fff; border-right: 1px solid #e9edf2; height: 100vh; position: sticky; top: 0; }
        .main-content { flex: 1; padding: 2rem; }
        /* ========== ĐỊA CHỈ - GIỐNG GIAO DIỆN USER ========== */
        .address-box {
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 1.25rem;
            margin-bottom: 1.25rem;
            background-color: #ffffff;
            transition: all 0.2s ease;
        }
        .address-box:hover {
            border-color: #cbd5e1;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04);
        }
        /* Địa chỉ chính */
        .address-main {
            border-left: 4px solid #2c7da0;
            background-color: #f8fafc;
        }
        .address-box-header {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px dashed #e2e8f0;
        }
        .address-box-header h4 {
            font-size: 1rem;
            font-weight: 600;
            color: #0f172a;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .address-box-header h4 i {
            font-size: 1rem;
            color: #f59e0b;
        }
        .address-actions {
            display: flex;
            gap: 0.75rem;
            align-items: center;
        }
        .btn-set-main {
            background: transparent;
            border: 1px solid #3b82f6;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 500;
            color: #3b82f6;
            text-decoration: none;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
        }
        .btn-set-main:hover {
            background-color: #3b82f6;
            color: white;
            border-color: #3b82f6;
        }
        .btn-remove-address {
            background: transparent;
            border: 1px solid #ef4444;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 500;
            color: #ef4444;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            cursor: pointer;
        }
        .btn-remove-address:hover {
            background-color: #ef4444;
            color: white;
        }
        /* Input bên trong address box */
        .address-box .form-label {
            font-size: 0.75rem;
            font-weight: 600;
            color: #475569;
            margin-bottom: 0.25rem;
        }
        .address-box .form-control {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 0.4rem 0.75rem;
            font-size: 0.875rem;
        }
        .address-box .form-control:focus {
            border-color: #2c7da0;
            box-shadow: 0 0 0 2px rgba(44,125,160,0.2);
        }
        /* Responsive */
        @media (max-width: 768px) {
            .address-box-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.75rem;
            }
            .address-actions {
                width: 100%;
                justify-content: flex-end;
            }
        }
    </style>
</head>
<body>
<div class="d-flex">
    <!-- SIDEBAR - kiểm tra đường dẫn chính xác -->
    <jsp:include page="/admin/sidebar/sidebar.jsp" />  <%-- thay bằng include động nếu file tồn tại --%>

    <main class="main-content">
        <header class="header d-flex justify-content-between align-items-center">
            <h3><i class="bi bi-people-fill me-2"></i> Chỉnh sửa thông tin người dùng</h3>
        </header>

        <div class="card">
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/admin/updateUser" method="post" enctype="multipart/form-data">
                    <!-- Avatar -->
                    <div class="avatar-upload-section">
                        <div class="current-avatar">
                            <c:choose>
                                <c:when test="${not empty user.imgURL}">
                                    <img id="avatarPreview" src="${pageContext.request.contextPath}${user.imgURL}" alt="Avatar">
                                </c:when>
                                <c:otherwise>
                                    <img id="avatarPreview" src="${pageContext.request.contextPath}/assets/img/default-avatar.png" alt="Avatar">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="upload-btn-wrapper">
                            <label for="avatarInput" class="btn-upload"><i class="fas fa-camera"></i> Chọn ảnh đại diện</label>
                            <input type="file" id="avatarInput" name="avatar" accept="image/jpeg,image/png,image/gif" style="display:none;">
                            <small class="text-muted d-block mt-2">Hỗ trợ: JPG, PNG, GIF. Tối đa 5MB</small>
                        </div>
                        <div id="uploadPreview" style="display:none;"><div class="alert alert-info">Đã chọn: <span id="fileName"></span></div></div>
                    </div>

                    <!-- Thông tin user -->
                    <div class="form-section address-box">
                        <h3><i class="fas fa-user"></i> Thông tin tài khoản</h3>
                        <div class="row">
                            <div class="col-md-6 mb-3"><label>ID</label><input type="text" class="form-control" name="id" value="${user.id}" readonly></div>
                            <div class="col-md-6 mb-3"><label>Tên đăng nhập</label><input type="text" class="form-control" name="username" value="${user.username}" required></div>
                            <div class="col-md-6 mb-3"><label>Họ tên</label><input type="text" class="form-control" name="fullname" value="${user.fullname}" required></div>
                            <div class="col-md-6 mb-3"><label>Email</label><input type="email" class="form-control" name="email" value="${user.email}" required></div>
                            <div class="col-md-6 mb-3"><label>Số điện thoại</label><input type="text" class="form-control" name="phoneNumber" value="${user.phonenumber}"></div>
                            <div class="col-md-6 mb-3"><label>Vai trò</label>
                                <select class="form-select" name="role">
                                    <option value="user" ${user.role == 'user' ? 'selected' : ''}>ROLE_USER</option>
                                    <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>ROLE_ADMIN</option>
                                </select>
                            </div>
                            <div class="col-12 mb-3"><label>Mô tả</label><textarea class="form-control" name="description">${user.description}</textarea></div>
                            <div class="col-md-6 mb-3"><label>Trạng thái</label>
                                <div class="status-options">
                                    <label><input type="radio" name="status" value="true" ${user.status ? 'checked' : ''}> Hoạt động</label>
                                    <label><input type="radio" name="status" value="false" ${!user.status ? 'checked' : ''}> Không hoạt động</label>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3"><label>Địa chỉ chính (mặc định)</label>
                                <select class="form-select" name="addressId">
                                    <option value="0">Chọn địa chỉ chính</option>
                                    <c:forEach var="a" items="${listAddress}">
                                        <option value="${a.id}" ${a.type == 'main' ? 'selected' : ''}>${a.id} - ${a.nameAddress}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Danh sách địa chỉ -->
                    <div class="form-section">
                        <h3><i class="fas fa-map-marker-alt"></i> Thông tin địa chỉ</h3>
                        <c:choose>
                            <c:when test="${not empty listAddress}">
                                <c:forEach var="a" items="${listAddress}">
                                    <div class="address-box ${a.type == 'main' ? 'border-primary' : ''}">
                                        <div class="address-box-header">
                                            <h4>
                                                <c:if test="${a.type == 'main'}"><i class="fas fa-star text-warning"></i> </c:if>
                                                    ${a.type == 'main' ? 'Địa chỉ chính' : 'Địa chỉ phụ'}: ${fn:escapeXml(a.nameAddress)}
                                            </h4>
                                            <div class="address-actions">
                                                <c:if test="${a.type != 'main'}">
                                                    <a href="${pageContext.request.contextPath}/admin/setMainAddress?id=${a.id}&uId=${user.id}" class="btn-set-main"><i class="fas fa-check-circle"></i> Đặt mặc định</a>
                                                </c:if>
                                                <button type="button" class="btn-remove-address" data-bs-toggle="modal" data-bs-target="#deleteModal${a.id}"><i class="fas fa-trash-alt"></i> Xóa</button>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3 mb-3"><label>Số nhà, đường</label><input type="text" class="form-control" name="street${a.id}" value="${fn:escapeXml(a.addressLine)}"></div>
                                            <div class="col-md-3 mb-3"><label>Xã/Phường</label><input type="text" class="form-control" name="commune${a.id}" value="${fn:escapeXml(a.wardName)}"></div>
                                            <div class="col-md-3 mb-3"><label>Quận/Huyện</label><input type="text" class="form-control" name="district${a.id}" value="${fn:escapeXml(a.districName)}"></div>
                                            <div class="col-md-3 mb-3"><label>Tỉnh/Thành phố</label><input type="text" class="form-control" name="province${a.id}" value="${fn:escapeXml(a.provinceName)}"></div>
                                        </div>
                                        <input type="hidden" name="addressId" value="${a.id}">
                                    </div>

                                    <!-- Modal xóa -->
                                    <div class="modal fade" id="deleteModal${a.id}" tabindex="-1">
                                        <div class="modal-dialog"><div class="modal-content">
                                            <div class="modal-header"><h5>Xác nhận xóa</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                                            <div class="modal-body">Xóa địa chỉ "${a.nameAddress}" ?</div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                <a href="${pageContext.request.contextPath}/admin/removeAddress?id=${a.id}&userId=${user.id}" class="btn btn-danger">Xóa</a>
                                            </div>
                                        </div></div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise><div class="address-box"><h4>📭 Chưa có địa chỉ nào</h4></div></c:otherwise>
                        </c:choose>
                        <button type="button" class="btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#addAddressModal"><i class="fas fa-plus"></i> Thêm địa chỉ mới</button>
                    </div>

                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/userAdmin" class="btn-cancel"><i class="fas fa-times"></i> Hủy</a>
                        <button type="submit" class="btn-save"><i class="fas fa-save"></i> Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </main>
</div>

<!-- Modal thêm địa chỉ (dùng API JSON) -->
<div class="modal fade" id="addAddressModal" tabindex="-1">
    <div class="modal-dialog"><div class="modal-content">
        <div class="modal-header"><h5>Thêm địa chỉ mới</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
        <div class="modal-body">
            <div id="addressModalError" class="alert alert-danger d-none"></div>
            <div class="mb-3"><label>Tên địa chỉ *</label><input type="text" class="form-control" id="addressName" placeholder="VD: Nhà riêng"></div>
            <div class="mb-3"><label>Tỉnh/TP *</label><select class="form-select" id="provinceSelect"><option selected disabled>-- Chọn --</option></select></div>
            <div class="mb-3"><label>Quận/Huyện</label><select class="form-select" id="districtSelect" disabled><option>-- Chọn --</option></select></div>
            <div class="mb-3"><label>Phường/Xã *</label><select class="form-select" id="wardSelect" required disabled><option disabled>-- Chọn --</option></select></div>
            <div class="mb-3"><label>Số nhà, đường *</label><input type="text" class="form-control" id="streetAddress"></div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
            <button type="button" class="btn btn-primary" id="saveAddressBtn"><i class="fas fa-save"></i> Lưu</button>
        </div>
    </div></div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Preview ảnh đại diện
    document.getElementById('avatarInput').onchange = function(e) {
        const file = e.target.files[0];
        if(file) {
            const reader = new FileReader();
            reader.onload = function(ev) {
                document.getElementById('avatarPreview').src = ev.target.result;
                document.getElementById('fileName').innerText = file.name;
                document.getElementById('uploadPreview').style.display = 'block';
            };
            reader.readAsDataURL(file);
        }
    };

    // ========== THÊM ĐỊA CHỈ ==========
    const ctx = "${pageContext.request.contextPath}";
    let addressData = [];
    const provinceSel = document.getElementById('provinceSelect');
    const districtSel = document.getElementById('districtSelect');
    const wardSel = document.getElementById('wardSelect');
    const saveAddrBtn = document.getElementById('saveAddressBtn');
    const addrName = document.getElementById('addressName');
    const streetAddr = document.getElementById('streetAddress');
    const modalError = document.getElementById('addressModalError');

    function showErr(msg) { modalError.innerText = msg; modalError.classList.remove('d-none'); setTimeout(()=>modalError.classList.add('d-none'),4000); }

    const addModal = document.getElementById('addAddressModal');
    addModal.addEventListener('show.bs.modal', function() {
        addrName.value = ''; streetAddr.value = '';
        provinceSel.innerHTML = '<option selected disabled>-- Chọn Tỉnh / Thành phố --</option>';
        districtSel.innerHTML = '<option disabled>-- Chọn Quận / Huyện --</option>'; districtSel.disabled = true;
        wardSel.innerHTML = '<option disabled>-- Chọn Phường / Xã --</option>'; wardSel.disabled = true;
        modalError.classList.add('d-none');
        if(addressData.length===0) loadAddressData();
        else renderProvinces();
    });

    async function loadAddressData() {
        try {
            const res = await fetch('https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json');
            if(!res.ok) throw new Error();
            addressData = await res.json();
            renderProvinces();
        } catch(e) { showErr('Không tải được dữ liệu địa chỉ'); }
    }
    function renderProvinces() {
        addressData.forEach(p => {
            let opt = document.createElement('option');
            opt.value = p.Name; opt.text = p.Name; opt.dataset.id = p.Id;
            provinceSel.appendChild(opt);
        });
    }
    provinceSel.addEventListener('change', function() {
        districtSel.innerHTML = '<option disabled selected>-- Chọn Quận / Huyện --</option>';
        wardSel.innerHTML = '<option disabled>-- Chọn Phường / Xã --</option>'; wardSel.disabled = true;
        districtSel.disabled = false;
        const provId = this.options[this.selectedIndex].dataset.id;
        const province = addressData.find(p => p.Id === provId);
        if(province && province.Districts) {
            province.Districts.forEach(d => {
                let opt = document.createElement('option');
                opt.value = d.Name; opt.text = d.Name; opt.dataset.id = d.Id;
                districtSel.appendChild(opt);
            });
        }
    });
    districtSel.addEventListener('change', function() {
        wardSel.innerHTML = '<option disabled selected>-- Chọn Phường / Xã --</option>';
        wardSel.disabled = false;
        const provId = provinceSel.options[provinceSel.selectedIndex].dataset.id;
        const province = addressData.find(p => p.Id === provId);
        if(!province) return;
        const distId = this.options[this.selectedIndex].dataset.id;
        const district = province.Districts.find(d => d.Id === distId);
        if(district && district.Wards) {
            district.Wards.forEach(w => {
                let opt = document.createElement('option');
                opt.value = w.Name; opt.text = w.Name;
                wardSel.appendChild(opt);
            });
        }
    });
    saveAddrBtn.addEventListener('click', async function() {
        const name = addrName.value.trim();
        const province = provinceSel.value;
        const district = districtSel.value;
        const ward = wardSel.value;
        const street = streetAddr.value.trim();
        if(!name) return showErr('Nhập tên địa chỉ');
        if(!province || province.includes('Chọn')) return showErr('Chọn Tỉnh/TP');
        if(!district || district.includes('Chọn')) return showErr('Chọn Quận/Huyện');
        if(!ward || ward.includes('Chọn')) return showErr('Chọn Phường/Xã');
        if(!street) return showErr('Nhập số nhà, tên đường');
        saveAddrBtn.disabled = true; saveAddrBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang lưu...';
        try {
            const resp = await fetch(ctx + '/addAddress', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: new URLSearchParams({ name, street, commune: ward, district, province, userId: '${user.id}' })
            });
            if(resp.ok) location.reload();
            else { showErr('Lưu thất bại'); saveAddrBtn.disabled = false; saveAddrBtn.innerHTML = '<i class="fas fa-save"></i> Lưu'; }
        } catch(e) { showErr('Lỗi kết nối'); saveAddrBtn.disabled = false; saveAddrBtn.innerHTML = '<i class="fas fa-save"></i> Lưu'; }
    });
    if(document.readyState === 'loading') document.addEventListener('DOMContentLoaded', loadAddressData);
    else loadAddressData();
</script>
</body>
</html>