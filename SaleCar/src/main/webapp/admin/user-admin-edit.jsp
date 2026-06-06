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
        body { background-color: #f1f5f9; font-family: 'Inter', sans-serif; }
        .sidebar { width: 280px; background-color: #fff; border-right: 1px solid #e9edf2; height: 100vh; position: sticky; top: 0; }
        .main-content { flex: 1; padding: 2rem; }

        .avatar-upload-section { text-align: center; margin-bottom: 30px; padding: 20px; background: #fff; border-radius: 20px; border: 1px solid #e9ecef; }
        .current-avatar img { width: 120px; height: 120px; border-radius: 50%; border: 3px solid #2c7da0; object-fit: cover; }
        .btn-upload { background: linear-gradient(135deg, #2c7da0, #1f5e7a); color: #fff; padding: 10px 24px; border-radius: 30px; cursor: pointer; display: inline-block; }

        .form-section { background: #fff; padding: 25px; border-radius: 20px; border: 1px solid #e9ecef; margin-bottom: 25px; }
        .form-section h3 { font-size: 1.2rem; font-weight: 600; color: #1e293b; margin-bottom: 20px; border-bottom: 2px solid #f1f5f9; padding-bottom: 10px; }

        /* ========== ĐỊA CHỈ ========== */
        .address-box { border: 1px solid #e2e8f0; border-radius: 16px; padding: 1.25rem; margin-bottom: 1.25rem; background-color: #ffffff; transition: all 0.2s ease; }
        .address-box:hover { border-color: #cbd5e1; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04); }
        .address-main { border-left: 4px solid #2c7da0; background-color: #f8fafc; }
        .address-box-header { display: flex; flex-wrap: wrap; justify-content: space-between; align-items: center; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 1px dashed #e2e8f0; }
        .address-box-header h4 { font-size: 1rem; font-weight: 600; color: #0f172a; margin: 0; display: flex; align-items: center; gap: 0.5rem; }
        .address-box-header h4 i { font-size: 1rem; color: #f59e0b; }

        .address-actions { display: flex; gap: 0.75rem; align-items: center; }
        .btn-set-main { background: transparent; border: 1px solid #3b82f6; padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.75rem; font-weight: 500; color: #3b82f6; text-decoration: none; transition: all 0.2s; display: inline-flex; align-items: center; gap: 0.3rem; }
        .btn-set-main:hover { background-color: #3b82f6; color: white; }
        .btn-remove-address { background: transparent; border: 1px solid #ef4444; padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.75rem; font-weight: 500; color: #ef4444; transition: all 0.2s; display: inline-flex; align-items: center; gap: 0.3rem; cursor: pointer; }
        .btn-remove-address:hover { background-color: #ef4444; color: white; }

        .form-actions { display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px; }
        .btn-save { background: #2c7da0; border: none; padding: 10px 24px; border-radius: 30px; color: white; font-weight: 500; }
        .btn-save:hover { background: #1f5e7a; }
        .btn-cancel { border: 1px solid #e2e8f0; padding: 10px 24px; border-radius: 30px; color: #64748b; background: transparent; text-decoration: none; }
        .btn-cancel:hover { background: #e2e8f0; }
    </style>
</head>
<body>
<div class="d-flex">
    <jsp:include page="/admin/sidebar/sidebar.jsp" />

    <main class="main-content">
        <header class="header d-flex justify-content-between align-items-center mb-4">
            <h3><i class="bi bi-people-fill me-2"></i> Chỉnh sửa thông tin người dùng</h3>
        </header>

        <div class="card shadow-sm border-0" style="border-radius: 20px;">
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/updateUser" method="post" enctype="multipart/form-data">

                    <input type="hidden" name="id" value="${user.id}">

                    <div class="avatar-upload-section shadow-sm">
                        <div class="current-avatar mb-3">
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
                            <label for="avatarInput" class="btn-upload"><i class="fas fa-camera me-2"></i>Chọn ảnh đại diện</label>
                            <input type="file" id="avatarInput" name="avatar" accept="image/jpeg,image/png,image/webp" style="display:none;">
                            <small class="text-muted d-block mt-2">Định dạng hỗ trợ: JPG, PNG, WEBP. Tối đa 2MB</small>
                        </div>
                        <div id="uploadPreview" class="mt-2" style="display:none;">
                            <span class="badge bg-info text-dark">Đã chọn: <span id="fileName"></span></span>
                        </div>
                    </div>

                    <div class="form-section">
                        <h3><i class="fas fa-user-circle me-2"></i>Thông tin tài khoản</h3>
                        <div class="row g-3">
                            <div class="col-md-2">
                                <label class="form-label fw-semibold text-secondary">User ID</label>
                                <input type="text" class="form-control bg-light" value="${user.id}" readonly>
                            </div>
                            <div class="col-md-5">
                                <label class="form-label fw-semibold">Tên đăng nhập *</label>
                                <input type="text" class="form-control ${not empty usernameError ? 'is-invalid' : ''}"
                                       name="username" value="${fn:escapeXml(user.username)}" required>
                                <c:if test="${not empty usernameError}">
                                    <div class="invalid-feedback">${usernameError}</div>
                                </c:if>
                            </div>
                            <div class="col-md-5">
                                <label class="form-label fw-semibold">Họ và tên *</label>
                                <input type="text" class="form-control ${not empty fullnameError ? 'is-invalid' : ''}"
                                       name="fullname" value="${fn:escapeXml(user.fullname)}" required>
                                <c:if test="${not empty fullnameError}">
                                    <div class="invalid-feedback">${fullnameError}</div>
                                </c:if>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Địa chỉ Email *</label>
                                <input type="email" class="form-control ${not empty emailError ? 'is-invalid' : ''}"
                                       name="email" value="${fn:escapeXml(user.email)}" required>
                                <c:if test="${not empty emailError}">
                                    <div class="invalid-feedback">${emailError}</div>
                                </c:if>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Số điện thoại</label>
                                <input type="text" class="form-control ${not empty phonenumberError ? 'is-invalid' : ''}"
                                       name="phoneNumber" value="${fn:escapeXml(user.phonenumber)}">
                                <c:if test="${not empty phonenumberError}">
                                    <div class="invalid-feedback">${phonenumberError}</div>
                                </c:if>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Vai trò hệ thống</label>
                                <select class="form-select" name="role">
                                    <option value="user" ${user.role == 'user' ? 'selected' : ''}>ROLE_USER (Khách hàng)</option>
                                    <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>ROLE_ADMIN (Quản trị viên)</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Trạng thái tài khoản</label>
                                <div class="mt-2">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="status" id="statusActive" value="true" ${user.status ? 'checked' : ''}>
                                        <label class="form-check-label text-success fw-medium" for="statusActive">Hoạt động</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="status" id="statusInActive" value="false" ${!user.status ? 'checked' : ''}>
                                        <label class="form-check-label text-danger fw-medium" for="statusInActive">Khóa / Chặn</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Địa chỉ giao dịch chính</label>
                                <select class="form-select" name="addressId">
                                    <option value="0">-- Chưa thiết lập địa chỉ chính --</option>
                                    <c:forEach var="a" items="${listAddress}">
                                        <option value="${a.id}" ${a.type == 'main' ? 'selected' : ''}>
                                            ID: ${a.id} - ${fn:escapeXml(a.nameAddress)}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-12">
                                <label class="form-label fw-semibold">Mô tả / Ghi chú về user</label>
                                <textarea class="form-control" name="description" rows="3" placeholder="Nhập ghi chú cá nhân hoặc thông tin bổ sung...">${fn:escapeXml(user.description)}</textarea>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h3><i class="fas fa-map-marker-alt me-2"></i>Sổ địa chỉ người dùng</h3>

                        <c:choose>
                            <c:when test="${not empty listAddress}">
                                <div class="row">
                                    <c:forEach var="a" items="${listAddress}">
                                        <div class="col-12">
                                            <div class="address-box ${a.type == 'main' ? 'address-main shadow-sm' : ''}">
                                                <div class="address-box-header">
                                                    <h4>
                                                        <c:if test="${a.type == 'main'}">
                                                            <i class="fas fa-star text-warning"></i>
                                                        </c:if>
                                                        <span class="badge ${a.type == 'main' ? 'bg-primary' : 'bg-secondary'} me-2">
                                                                ${a.type == 'main' ? 'Mặc định' : 'Phụ'}
                                                        </span>
                                                            ${fn:escapeXml(a.nameAddress)}
                                                    </h4>
                                                    <div class="address-actions">
                                                        <c:if test="${a.type != 'main'}">
                                                            <a href="${pageContext.request.contextPath}/admin/setMainAddress?id=${a.id}&uId=${user.id}" class="btn-set-main">
                                                                <i class="fas fa-check-circle"></i> Đặt mặc định
                                                            </a>
                                                        </c:if>
                                                        <button type="button" class="btn-remove-address" data-bs-toggle="modal" data-bs-target="#deleteModal${a.id}">
                                                            <i class="fas fa-trash-alt"></i> Xóa
                                                        </button>
                                                    </div>
                                                </div>
                                                <div class="row g-2 text-secondary" style="font-size: 0.9rem;">
                                                    <div class="col-md-3"><strong>Đường/Số nhà:</strong> ${fn:escapeXml(a.addressLine)}</div>
                                                    <div class="col-md-3"><strong>Phường/Xã:</strong> ${fn:escapeXml(a.wardName)}</div>
                                                    <div class="col-md-3"><strong>Quận/Huyện:</strong> ${fn:escapeXml(a.districName)}</div>
                                                    <div class="col-md-3"><strong>Tỉnh/Thành phố:</strong> ${fn:escapeXml(a.provinceName)}</div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="modal fade" id="deleteModal${a.id}" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title text-danger"><i class="fas fa-exclamation-triangle me-2"></i>Xác nhận xóa</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        Bạn có chắc chắn muốn xóa địa chỉ <strong>"${fn:escapeXml(a.nameAddress)}"</strong> này ra khỏi hệ thống? Hành động này không thể hoàn tác.
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary rounded-pill" data-bs-dismiss="modal">Hủy</button>
                                                        <a href="${pageContext.request.contextPath}/admin/removeAddress?id=${a.id}&userId=${user.id}" class="btn btn-danger rounded-pill">Đồng ý xóa</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center p-4 bg-light rounded-3 text-muted">
                                    <i class="fas fa-folder-open fa-2x mb-2"></i>
                                    <p class="mb-0">Người dùng này chưa đăng ký sổ địa chỉ nào.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <button type="button" class="btn btn-outline-primary btn-sm rounded-pill mt-3" data-bs-toggle="modal" data-bs-target="#addAddressModal">
                            <i class="fas fa-plus me-1"></i> Thêm địa chỉ mới cho khách hàng
                        </button>
                    </div>

                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/userAdmin" class="btn-cancel"><i class="fas fa-times me-2"></i>Hủy bỏ</a>
                        <button type="submit" class="btn-save shadow-sm"><i class="fas fa-save me-2"></i>Cập nhật thông tin</button>
                    </div>
                </form>
            </div>
        </div>
    </main>
</div>

<div class="modal fade" id="addAddressModal" tabindex="-1" aria-labelledby="addAddressModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addAddressModalLabel"><i class="fas fa-map-marked-alt me-2"></i>Thêm địa chỉ mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="addressModalError" class="alert alert-danger d-none"></div>
                <div class="mb-3">
                    <label class="form-label fw-medium">Tên định danh địa chỉ *</label>
                    <input type="text" class="form-control" id="addressName" placeholder="VD: Nhà riêng, Cơ quan...">
                </div>
                <div class="mb-3">
                    <label class="form-label fw-medium">Tỉnh / Thành phố *</label>
                    <select class="form-select" id="provinceSelect">
                        <option selected disabled>-- Chọn Tỉnh / Thành phố --</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-medium">Quận / Huyện *</label>
                    <select class="form-select" id="districtSelect" disabled>
                        <option selected disabled>-- Chọn Quận / Huyện --</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-medium">Phường / Xã *</label>
                    <select class="form-select" id="wardSelect" disabled>
                        <option selected disabled>-- Chọn Phường / Xã --</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-medium">Số nhà, tên đường cụ thể *</label>
                    <input type="text" class="form-control" id="streetAddress" placeholder="VD: 123 Đường Lê Lợi">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary rounded-pill" data-bs-dismiss="modal">Đóng</button>
                <button type="button" class="btn btn-primary rounded-pill" id="saveAddressBtn"><i class="fas fa-save me-1"></i>Lưu lại</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Live Preview hình ảnh trước khi Upload lên Server
    document.getElementById('avatarInput').onchange = function(e) {
        const file = e.target.files[0];
        if(file) {
            // Kiểm tra dung lượng file client-side (> 2MB)
            if(file.size > 2 * 1024 * 1024) {
                alert("Kích thước file không được vượt quá 2MB!");
                this.value = '';
                return;
            }
            const reader = new FileReader();
            reader.onload = function(ev) {
                document.getElementById('avatarPreview').src = ev.target.result;
                document.getElementById('fileName').innerText = file.name;
                document.getElementById('uploadPreview').style.display = 'block';
            };
            reader.readAsDataURL(file);
        }
    };

    // ========== XỬ LÝ API GHÉP ĐỊA CHỈ HÀNH CHÍNH ==========
    const ctx = "${pageContext.request.contextPath}";
    let addressData = [];
    const provinceSel = document.getElementById('provinceSelect');
    const districtSel = document.getElementById('districtSelect');
    const wardSel = document.getElementById('wardSelect');
    const saveAddrBtn = document.getElementById('saveAddressBtn');
    const addrName = document.getElementById('addressName');
    const streetAddr = document.getElementById('streetAddress');
    const modalError = document.getElementById('addressModalError');

    function showErr(msg) {
        modalError.innerText = msg;
        modalError.classList.remove('d-none');
        setTimeout(() => modalError.classList.add('d-none'), 4000);
    }

    const addModal = document.getElementById('addAddressModal');
    addModal.addEventListener('show.bs.modal', function() {
        addrName.value = ''; streetAddr.value = '';
        provinceSel.innerHTML = '<option selected disabled>-- Chọn Tỉnh / Thành phố --</option>';
        districtSel.innerHTML = '<option disabled selected>-- Chọn Quận / Huyện --</option>'; districtSel.disabled = true;
        wardSel.innerHTML = '<option disabled selected>-- Chọn Phường / Xã --</option>'; wardSel.disabled = true;
        modalError.classList.add('d-none');
        if(addressData.length === 0) loadAddressData();
        else renderProvinces();
    });

    async function loadAddressData() {
        try {
            const res = await fetch('https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json');
            if(!res.ok) throw new Error();
            addressData = await res.json();
            renderProvinces();
        } catch(e) {
            showErr('Không thể đồng bộ dữ liệu bản đồ địa chính Việt Nam');
        }
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
        wardSel.innerHTML = '<option disabled selected>-- Chọn Phường / Xã --</option>'; wardSel.disabled = true;
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

        if(!name) return showErr('Nhập tên phân loại địa chỉ');
        if(!province || province.includes('Chọn')) return showErr('Chọn Tỉnh/TP');
        if(!district || district.includes('Chọn')) return showErr('Chọn Quận/Huyện');
        if(!ward || ward.includes('Chọn')) return showErr('Chọn Phường/Xã');
        if(!street) return showErr('Vui lòng điền số nhà và tên đường cụ thể');

        saveAddrBtn.disabled = true;
        saveAddrBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i> Đang xử lý...';

        try {
            const resp = await fetch(ctx + '/addAdressAdmin', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: new URLSearchParams({ name, street, commune: ward, district, province, userId: '${user.id}' })
            });
            if(resp.ok) {
                location.reload();
            } else {
                showErr('Lưu thất bại từ hệ thống.');
                saveAddrBtn.disabled = false; saveAddrBtn.innerHTML = '<i class="fas fa-save me-1"></i>Lưu lại';
            }
        } catch(e) {
            showErr('Mất kết nối mạng internet.');
            saveAddrBtn.disabled = false; saveAddrBtn.innerHTML = '<i class="fas fa-save me-1"></i>Lưu lại';
        }
    });
</script>
</body>
</html>