function showAlert(message, type) {
    const alertDiv = document.createElement('div');
    alertDiv.className = 'alert-custom';

    // Thêm class theo type
    if (type === 'success') {
        alertDiv.classList.add('success');
    } else if (type === 'warning') {
        alertDiv.classList.add('warning');
    } else if (type === 'error') {
        alertDiv.classList.add('error');
    }

    // Chọn icon phù hợp
    let icon = 'bi-check-circle-fill';
    if (type === 'warning') {
        icon = 'bi-exclamation-triangle-fill';
    } else if (type === 'success') {
        icon = 'bi-check-circle-fill';
    } else if (type === 'error') {
        icon = 'bi-x-circle-fill';
    }

    alertDiv.innerHTML = `
        <div class="d-flex align-items-center">
            <i class="bi ` + icon + ` me-3" style="font-size: 24px;"></i>
            <div>
                <strong>LUXCAR</strong><br>
                <span style="font-size: 14px;">` + message + `</span>
            </div>
        </div>
        <div style="position: absolute; bottom: 0; left: 0; height: 3px; width: 100%; background: linear-gradient(90deg, var(--gold), var(--light-gold)); transform-origin: left; animation: progress 3s linear;"></div>
    `;

    // Thêm sự kiện click để đóng alert
    alertDiv.addEventListener('click', function() {
        closeAlert(alertDiv);
    });

    document.getElementById('alertContainer').appendChild(alertDiv);

    // Tự động đóng sau 3 giây
    setTimeout(() => {
        closeAlert(alertDiv);
    }, 3000);
}

function closeAlert(alertElement) {
    // Thêm animation biến mất
    alertElement.style.animation = 'slideOutRight 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55) forwards';

    // Xóa element sau khi animation kết thúc
    setTimeout(() => {
        if (alertElement && alertElement.parentNode) {
            alertElement.remove();
        }
    }, 300);
}