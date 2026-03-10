<%-- Document : predict-revenue Created on : Mar 10, 2026, 1:17:01 AM Author : ntpho --%>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>AI Prediction Dashboard | SmartHotel</title>
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                :root {
                    --primary-color: #2c3e50;
                    --secondary-color: #34495e;
                    --accent-color: #3498db;
                    --background-color: #f4f7f6;
                    --card-bg: #ffffff;
                    --text-color: #333333;
                    --text-muted: #7f8c8d;
                    --hotel-gold: #f1c40f;
                }

                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background-color: var(--background-color);
                    color: var(--text-color);
                    line-height: 1.6;
                }

                /* Header Styling */
                .header {
                    background-color: var(--primary-color);
                    color: white;
                    padding: 20px 40px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                    position: sticky;
                    top: 0;
                    z-index: 100;
                }

                .header-title {
                    font-size: 24px;
                    font-weight: 600;
                    display: flex;
                    align-items: center;
                    gap: 10px;
                }

                .header-title i {
                    color: var(--hotel-gold);
                }

                /* Button Back to Dashboard */
                .btn-back {
                    background-color: transparent;
                    color: white;
                    border: 1px solid rgba(255, 255, 255, 0.5);
                    padding: 10px 20px;
                    border-radius: 5px;
                    text-decoration: none;
                    font-weight: 500;
                    display: flex;
                    align-items: center;
                    gap: 8px;
                    transition: all 0.3s ease;
                }

                .btn-back:hover {
                    background-color: rgba(255, 255, 255, 0.1);
                    border-color: white;
                    transform: translateY(-2px);
                }

                /* Main Content Area */
                .main-content {
                    padding: 40px 20px;
                    max-width: 1200px;
                    margin: 0 auto;
                }

                .page-description {
                    text-align: center;
                    margin-bottom: 40px;
                    color: var(--text-muted);
                    font-size: 16px;
                }

                /* Chart Containers */
                .chart-card {
                    background: var(--card-bg);
                    border-radius: 12px;
                    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
                    padding: 30px;
                    margin-bottom: 40px;
                    transition: transform 0.3s ease, box-shadow 0.3s ease;
                }

                .chart-card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 12px 25px rgba(0, 0, 0, 0.1);
                }

                .card-header {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    margin-bottom: 25px;
                    border-bottom: 2px solid #f1f2f6;
                    padding-bottom: 15px;
                }

                .card-title {
                    font-size: 20px;
                    color: var(--primary-color);
                    display: flex;
                    align-items: center;
                    gap: 10px;
                }

                .card-title .icon-revenue {
                    color: #27ae60;
                }

                .card-title .icon-booking {
                    color: #8e44ad;
                }

                .card-subtitle {
                    font-size: 14px;
                    color: var(--text-muted);
                    font-style: italic;
                    background: #f8f9fa;
                    padding: 5px 15px;
                    border-radius: 20px;
                }

                .chart-wrapper {
                    position: relative;
                    height: 450px;
                    width: 100%;
                }

                /* Error Message Styling */
                .error-alert {
                    background-color: #fdeaea;
                    border-left: 5px solid #e74c3c;
                    color: #c0392b;
                    padding: 15px 20px;
                    border-radius: 4px;
                    margin-bottom: 25px;
                    display: flex;
                    align-items: center;
                    gap: 15px;
                    font-weight: 500;
                    animation: slideIn 0.5s ease;
                }

                @keyframes slideIn {
                    from {
                        opacity: 0;
                        transform: translateY(-10px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                /* Responsive */
                @media (max-width: 768px) {
                    .header {
                        flex-direction: column;
                        gap: 15px;
                        padding: 15px 20px;
                    }

                    .chart-wrapper {
                        height: 300px;
                    }

                    .card-header {
                        flex-direction: column;
                        align-items: flex-start;
                        gap: 10px;
                    }
                }
            </style>
        </head>

        <body>
            <!-- Tiêu đề trang & Nút Quay lại -->
            <header class="header">
                <div class="header-title">
                    <i class="fa-solid fa-robot"></i>
                    AI Prediction System
                </div>
                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn-back">
                    <i class="fa-solid fa-arrow-left"></i> Về Dashboard
                </a>
            </header>

            <main class="main-content">
                <p class="page-description">Hệ thống phân tích và dự báo chuỗi thời gian áp dụng thuật toán Học Máy
                    (Machine Learning) dựa trên dữ liệu lịch sử của khách sạn.</p>

                <!-- Biểu đồ 1: Doanh Thu -->
                <div class="chart-card" id="revenueContainer">
                    <div class="card-header">
                        <h2 class="card-title">
                            <i class="fa-solid fa-chart-line icon-revenue"></i>
                            Dự báo Doanh Thu (12 Tháng Tới)
                        </h2>
                        <span class="card-subtitle">Mô hình: Linear Regression</span>
                    </div>
                    <!-- JS sẽ chèn thông báo lỗi vào đây nếu có -->
                    <div class="chart-wrapper">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>

                <!-- Biểu đồ 2: Số Lượng Phòng -->
                <div class="chart-card" id="bookingContainer">
                    <div class="card-header">
                        <h2 class="card-title">
                            <i class="fa-solid fa-bed icon-booking"></i>
                            Dự báo Nhu Cầu Phòng Đặt (12 Tháng Tới)
                        </h2>
                        <span class="card-subtitle">Xu hướng & Mùa vụ</span>
                    </div>
                    <!-- JS sẽ chèn thông báo lỗi vào đây nếu có -->
                    <div class="chart-wrapper">
                        <canvas id="bookingChart"></canvas>
                    </div>
                </div>
            </main>

            <script>
                // Data lấy từ Servlet
                const rawRevenueData = <%= request.getAttribute("revenueData") != null && !request.getAttribute("revenueData").toString().isEmpty() ? request.getAttribute("revenueData") : "{}" %>;
                const rawBookingData = <%= request.getAttribute("bookingData") != null && !request.getAttribute("bookingData").toString().isEmpty() ? request.getAttribute("bookingData") : "{}" %>;

                // Hàm hiển thị lỗi giao diện đẹp hơn
                function displayError(containerId, message) {
                    const container = document.getElementById(containerId);
                    if (container) {
                        const errorDiv = document.createElement('div');
                        errorDiv.className = 'error-alert';
                        errorDiv.innerHTML = '<i class="fa-solid fa-triangle-exclamation" style="font-size: 24px;"></i> <div><strong>Cảnh báo Dữ liệu / Kết nối:</strong><br>' + message + '</div>';

                        // Chèn vào ngay dưới card-header
                        const cardHeader = container.querySelector('.card-header');
                        cardHeader.insertAdjacentElement('afterend', errorDiv);

                        // Xóa luôn thẻ canvas biểu đồ vì không có data để vẽ
                        const chartWrapper = container.querySelector('.chart-wrapper');
                        if (chartWrapper) chartWrapper.style.display = 'none';
                    }
                }

                // --------- BIỂU ĐỒ DOANH THU ---------
                if (rawRevenueData.status === "error") {
                    displayError('revenueContainer', rawRevenueData.message);
                } else if (rawRevenueData.data) {
                    const dataRev = rawRevenueData.data;
                    const ctxRev = document.getElementById('revenueChart').getContext('2d');

                    // Cấu hình Gradient cho vùng Area Chart Đẹp
                    const gradientRev = ctxRev.createLinearGradient(0, 0, 0, 400);
                    gradientRev.addColorStop(0, 'rgba(46, 204, 113, 0.5)'); // Xanh lá mạ nhạt
                    gradientRev.addColorStop(1, 'rgba(46, 204, 113, 0.0)');

                    const gradientPred = ctxRev.createLinearGradient(0, 0, 0, 400);
                    gradientPred.addColorStop(0, 'rgba(52, 152, 219, 0.5)'); // Xanh dương nhạt
                    gradientPred.addColorStop(1, 'rgba(52, 152, 219, 0.0)');

                    new Chart(ctxRev, {
                        type: 'line',
                        data: {
                            labels: dataRev.labels,
                            datasets: [
                                {
                                    label: 'Lịch sử Thực tế',
                                    data: dataRev.actual_revenue,
                                    borderColor: '#2ecc71', // Xanh lá
                                    backgroundColor: gradientRev,
                                    borderWidth: 3,
                                    fill: true,
                                    tension: 0.4,
                                    pointRadius: 5,
                                    pointHoverRadius: 7,
                                    pointBackgroundColor: 'white'
                                },
                                {
                                    label: 'AI Dự báo Tương lai',
                                    data: dataRev.predicted_revenue,
                                    borderColor: '#3498db', // Xanh dương
                                    backgroundColor: gradientPred,
                                    borderWidth: 3,
                                    borderDash: [5, 5],
                                    fill: true,
                                    tension: 0.4,
                                    pointRadius: 5,
                                    pointHoverRadius: 7,
                                    pointBackgroundColor: 'white'
                                }
                            ]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: { position: 'top', labels: { font: { family: 'Segoe UI', size: 13 } } },
                                tooltip: {
                                    mode: 'index', intersect: false,
                                    callbacks: {
                                        label: function (context) {
                                            let label = context.dataset.label || '';
                                            if (label) { label += ': '; }
                                            if (context.parsed.y !== null) {
                                                label += new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(context.parsed.y);
                                            }
                                            return label;
                                        }
                                    }
                                }
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    grid: { color: 'rgba(0,0,0,0.05)' },
                                    ticks: {
                                        font: { family: 'Segoe UI' },
                                        callback: function (value) { return new Intl.NumberFormat('vi-VN').format(value) + ' ₫'; }
                                    }
                                },
                                x: { grid: { display: false }, ticks: { font: { family: 'Segoe UI' } } }
                            }
                        }
                    });
                }

                // --------- BIỂU ĐỒ SỐ LƯỢNG PHÒNG ---------
                if (rawBookingData.status === "error") {
                    displayError('bookingContainer', rawBookingData.message);
                } else if (rawBookingData.data) {
                    const dataBook = rawBookingData.data;
                    const ctxBook = document.getElementById('bookingChart').getContext('2d');
                    new Chart(ctxBook, {
                        type: 'bar',
                        data: {
                            labels: dataBook.labels,
                            datasets: [
                                {
                                    label: 'Lịch sử Thực tế',
                                    data: dataBook.actual_bookings,
                                    backgroundColor: '#9b59b6', // Tím
                                    borderRadius: 6,
                                    borderWidth: 0
                                },
                                {
                                    label: 'AI Dự báo Tương lai',
                                    data: dataBook.predicted_bookings,
                                    backgroundColor: 'rgba(155, 89, 182, 0.2)', // Tím nhạt
                                    borderColor: '#9b59b6',
                                    borderWidth: 2,
                                    borderDash: [5, 5],
                                    borderRadius: 6
                                }
                            ]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: { position: 'top', labels: { font: { family: 'Segoe UI', size: 13 } } },
                                tooltip: {
                                    mode: 'index', intersect: false,
                                    callbacks: {
                                        label: function (context) {
                                            return context.dataset.label + ': ' + context.parsed.y + ' phòng';
                                        }
                                    }
                                }
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    grid: { color: 'rgba(0,0,0,0.05)', borderDash: [5, 5] },
                                    ticks: { font: { family: 'Segoe UI' }, stepSize: 1 }
                                },
                                x: { grid: { display: false }, ticks: { font: { family: 'Segoe UI' } } }
                            }
                        }
                    });
                }
            </script>
        </body>

        </html>