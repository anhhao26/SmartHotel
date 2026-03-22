<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>SmartHotel BI - Trung Tâm Phân Tích Kinh Doanh</title>

        <!-- Premium Fonts -->
        <link
            href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Inter:wght@300;400;500;600;700&family=Be+Vietnam+Pro:wght@100;300;400;500;700;900&display=swap"
            rel="stylesheet">
        <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
            rel="stylesheet" />

        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            hotel: {
                                gold: "#B89A6C",
                                cream: "#FAF9F6",
                                bone: "#FDFCFB",
                                text: "#2C2722",
                                muted: "#70685F",
                                chocolate: "#4A4238",
                            },
                            accent: {
                                emerald: "#4F7942",
                                ruby: "#8B0000"
                            }
                        },
                        fontFamily: {
                            serif: ["Cormorant Garamond", "serif"],
                            sans: ["Inter", "Be Vietnam Pro", "sans-serif"],
                        }
                    },
                },
            }
        </script>
        <style>
            .card-elegant {
                background: #FFFFFF;
                border: 1px solid rgba(184, 154, 108, 0.1);
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.02);
                transition: all 0.5s cubic-bezier(0.23, 1, 0.32, 1);
            }

            .card-elegant:hover {
                transform: translateY(-5px);
                border-color: rgba(184, 154, 108, 0.3);
                box-shadow: 0 20px 60px rgba(184, 154, 108, 0.08);
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
    </head>

    <body class="font-sans antialiased bg-hotel-cream text-hotel-text min-h-screen flex overflow-hidden">

        <jsp:include page="/common/neural_shell_top.jspf">
            <jsp:param name="active" value="ai" />
        </jsp:include>

        <!-- AI Intelligence Content -->
        <div class="flex-1 h-screen overflow-y-auto pb-32">
            <div class="max-w-7xl mx-auto px-12 animate-[fadeIn_0.8s_ease-out]">

                <!-- Header Section -->
                <div class="flex flex-col md:flex-row md:items-end justify-between gap-6 py-12">
                    <div class="space-y-4">
                        <div
                            class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-hotel-gold/5 border border-hotel-gold/20 text-hotel-gold text-sm font-bold uppercase tracking-[0.3em]">
                            Trí Tuệ Doanh Nghiệp v8.0
                        </div>
                        <h2
                            class="text-6xl font-serif font-bold text-hotel-text tracking-tight leading-tight uppercase">
                            Dự Báo<br /><span class="text-hotel-gold italic">Tăng Trưởng.</span>
                        </h2>
                        <p class="text-hotel-muted text-lg font-medium italic max-w-2xl opacity-80">
                            Hệ thống mô phỏng chuỗi thời gian dựa trên các thuật toán phân tích xu hướng cao cấp và dữ
                            liệu thực tế từ hệ thống lõi SmartHotel.
                        </p>
                    </div>
                    <div class="flex gap-4">
                        <div
                            class="card-elegant px-8 py-5 rounded-[2rem] flex items-center gap-5 relative overflow-hidden group">
                            <div
                                class="absolute inset-0 bg-hotel-gold/5 opacity-0 group-hover:opacity-100 transition-opacity">
                            </div>
                            <span
                                class="material-symbols-outlined text-hotel-gold text-4xl group-hover:scale-110 transition-transform">insights</span>
                            <div>
                                <p
                                    class="text-sm font-bold text-hotel-muted uppercase tracking-[0.3em] mb-1 opacity-60">
                                    CƠ CHẾ PHÂN TÍCH</p>
                                <p
                                    class="text-xl font-serif font-bold text-hotel-text tracking-widest uppercase italic">
                                    Prophet BI</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="grid grid-cols-1 gap-12">

                    <!-- Revenue Prediction Card -->
                    <div class="card-elegant rounded-[3rem] p-12 flex flex-col group relative overflow-hidden"
                        id="revenueContainer">
                        <div
                            class="absolute inset-0 bg-gradient-to-br from-hotel-gold/[0.02] to-transparent pointer-events-none">
                        </div>
                        <div class="flex items-center justify-between mb-12 relative">
                            <div class="flex items-center gap-5">
                                <div
                                    class="w-16 h-16 rounded-[1.5rem] bg-hotel-gold/10 flex items-center justify-center text-hotel-gold border border-hotel-gold/20 group-hover:scale-110 transition-transform">
                                    <span class="material-symbols-outlined text-3xl">trending_up</span>
                                </div>
                                <div>
                                    <h3 class="text-2xl font-serif font-bold text-hotel-text tracking-tight uppercase">
                                        Dự Báo Doanh Thu</h3>
                                    <p
                                        class="text-sm text-hotel-muted font-bold uppercase tracking-[0.3em] mt-1 italic opacity-50">
                                        Chu kỳ 12 tháng kế tiếp</p>
                                </div>
                            </div>
                            <span
                                class="text-xs font-bold text-hotel-gold bg-hotel-gold/10 px-4 py-1.5 rounded-full border border-hotel-gold/20 uppercase tracking-[0.4em]">Time
                                Series</span>
                        </div>

                        <div class="flex-1 relative min-h-[600px]">
                            <canvas id="revenueChart"></canvas>
                        </div>
                    </div>

                    <!-- Booking Prediction Card -->
                    <div class="card-elegant rounded-[3rem] p-12 flex flex-col group relative overflow-hidden"
                        id="bookingContainer">
                        <div
                            class="absolute inset-0 bg-gradient-to-br from-hotel-chocolate/[0.02] to-transparent pointer-events-none">
                        </div>
                        <div class="flex items-center justify-between mb-12 relative">
                            <div class="flex items-center gap-5">
                                <div
                                    class="w-16 h-16 rounded-[1.5rem] bg-hotel-chocolate/10 flex items-center justify-center text-hotel-chocolate border border-hotel-chocolate/20 group-hover:scale-110 transition-transform">
                                    <span class="material-symbols-outlined text-3xl">bed</span>
                                </div>
                                <div>
                                    <h3 class="text-2xl font-serif font-bold text-hotel-text tracking-tight uppercase">
                                        Dự Báo Nhu Cầu</h3>
                                    <p
                                        class="text-sm text-hotel-muted font-bold uppercase tracking-[0.3em] mt-1 italic opacity-50">
                                        Xu hướng mùa vụ cao cấp</p>
                                </div>
                            </div>
                            <span
                                class="text-xs font-bold text-hotel-chocolate bg-hotel-chocolate/10 px-4 py-1.5 rounded-full border border-hotel-chocolate/20 uppercase tracking-[0.4em]">Capacity
                                Plan</span>
                        </div>

                        <div class="flex-1 relative min-h-[600px]">
                            <canvas id="bookingChart"></canvas>
                        </div>
                    </div>

                </div>

                <!-- Logic Protocol Detail -->
                <div
                    class="card-elegant rounded-[3rem] p-14 border-dashed mt-16 group relative overflow-hidden bg-hotel-bone/50">
                    <div class="absolute inset-0 bg-hotel-gold/[0.01] pointer-events-none"></div>
                    <div class="flex items-start gap-10 relative">
                        <div
                            class="w-20 h-20 rounded-[2rem] bg-white flex items-center justify-center text-hotel-gold border border-hotel-gold/10 shadow-sm">
                            <span
                                class="material-symbols-outlined text-4xl group-hover:rotate-12 transition-transform duration-500">description</span>
                        </div>
                        <div class="space-y-6">
                            <h4 class="text-sm font-bold text-hotel-muted uppercase tracking-[0.5em] opacity-60">Cơ
                                sở dữ liệu phân tích hệ thống</h4>
                            <p
                                class="text-hotel-muted text-base font-medium leading-relaxed max-w-5xl italic uppercase tracking-widest opacity-80">
                                Thuật toán sử dụng dữ liệu lịch sử từ cơ sở dữ liệu SmartHotel, kết xuất qua mô hình trí
                                tuệ nhân tạo.
                                Các chỉ số bao gồm độ lệch chuẩn và xu hướng tăng trưởng được tính toán để thực thi
                                chính sách tối ưu giá phòng
                                (Dynamic Pricing) và điều phối tài nguyên vận hành hiệu quả nhất.
                            </p>
                            <div class="flex items-center gap-8 pt-4">
                                <div class="flex items-center gap-3">
                                    <span class="w-2 h-2 rounded-full bg-accent-emerald"></span>
                                    <span
                                        class="text-sm font-bold text-hotel-muted uppercase tracking-widest opacity-60">Model
                                        Balanced</span>
                                </div>
                                <div class="flex items-center gap-3">
                                    <span class="w-2 h-2 rounded-full bg-hotel-gold"></span>
                                    <span
                                        class="text-sm font-bold text-hotel-muted uppercase tracking-widest opacity-60">Real-time
                                        Stream</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Data Injection Blocks -->
        <script id="revenue-data" type="application/json">
        <%= request.getAttribute("revenueData") != null ? request.getAttribute("revenueData") : "{}" %>
    </script>
        <script id="booking-data" type="application/json">
        <%= request.getAttribute("bookingData") != null ? request.getAttribute("bookingData") : "{}" %>
    </script>

        <jsp:include page="/common/neural_shell_bottom.jspf" />

        <script>
                (function () {
                    // Data acquisition from JSON blocks
                    let rawRevenueData = {};
                    let rawBookingData = {};

                    try {
                        rawRevenueData = JSON.parse(document.getElementById('revenue-data').textContent);
                        rawBookingData = JSON.parse(document.getElementById('booking-data').textContent);
                    } catch (e) {
                        console.error("Failed to parse analytics data", e);
                    }

                    function displayError(containerId, message) {
                        const container = document.getElementById(containerId);
                        if (container) {
                            const canvas = container.querySelector('canvas');
                            if (canvas) canvas.style.display = 'none';
                            const errorDiv = document.createElement('div');
                            errorDiv.className = 'p-20 flex flex-col items-center justify-center space-y-6 text-center h-full min-h-[600px] border-2 border-dashed border-hotel-gold/20 rounded-[3rem] mt-10 bg-hotel-gold/[0.02]';
                            errorDiv.innerHTML = `
                        <span class="material-symbols-outlined text-6xl text-hotel-gold opacity-50">analytics</span>
                        <div>
                            <p class="text-base font-bold text-hotel-text uppercase tracking-[0.4em] mb-2">Lỗi Kết Nối Trung Tâm Phân Tích</p>
                            <p class="text-xs font-medium text-hotel-muted italic leading-relaxed max-w-xs uppercase tracking-widest">${message}</p>
                        </div>
                        <button onclick="location.reload()" class="px-10 py-4 rounded-xl bg-white border border-hotel-gold/20 text-sm font-bold uppercase tracking-widest hover:bg-hotel-gold hover:text-white transition-all shadow-sm">Cập nhật dữ liệu</button>
                    `;
                            container.appendChild(errorDiv);
                        }
                    }

                    Chart.defaults.color = '#70685F';
                    Chart.defaults.font.family = "'Inter', 'Be Vietnam Pro', sans-serif";
                    Chart.defaults.font.weight = '500';

                    // Revenue Chart Implementation
                    if (rawRevenueData.status === "error") {
                        displayError('revenueContainer', rawRevenueData.message);
                    } else if (rawRevenueData.data) {
                        const ctx = document.getElementById('revenueChart').getContext('2d');
                        const gActual = ctx.createLinearGradient(0, 0, 0, 400);
                        gActual.addColorStop(0, 'rgba(184, 154, 108, 0.2)');
                        gActual.addColorStop(1, 'rgba(184, 154, 108, 0)');

                        const gPred = ctx.createLinearGradient(0, 0, 0, 400);
                        gPred.addColorStop(0, 'rgba(74, 66, 56, 0.1)');
                        gPred.addColorStop(1, 'rgba(74, 66, 56, 0)');

                        new Chart(ctx, {
                            type: 'line',
                            data: {
                                labels: rawRevenueData.data.labels,
                                datasets: [
                                    {
                                        label: 'Lịch sử Thực tế',
                                        data: rawRevenueData.data.actual_revenue,
                                        borderColor: '#B89A6C',
                                        backgroundColor: gActual,
                                        borderWidth: 4,
                                        fill: true,
                                        tension: 0.4,
                                        pointRadius: 0,
                                        pointHoverRadius: 8,
                                        pointHoverBackgroundColor: '#B89A6C',
                                        pointHoverBorderColor: '#FFFFFF',
                                        pointHoverBorderWidth: 3,
                                    },
                                    {
                                        label: 'Dự báo Tăng trưởng',
                                        data: rawRevenueData.data.predicted_revenue,
                                        borderColor: '#4A4238',
                                        backgroundColor: gPred,
                                        borderWidth: 2,
                                        borderDash: [8, 4],
                                        fill: true,
                                        tension: 0.4,
                                        pointRadius: 0,
                                    }
                                ]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                interaction: { mode: 'index', intersect: false },
                                plugins: {
                                    legend: {
                                        position: 'bottom',
                                        labels: {
                                            padding: 40,
                                            boxWidth: 12,
                                            usePointStyle: true,
                                            font: { size: 10, weight: 'bold' }
                                        }
                                    }
                                },
                                scales: {
                                    y: {
                                        grid: { color: 'rgba(184, 154, 108, 0.05)', drawBorder: false },
                                        ticks: {
                                            font: { size: 10 },
                                            callback: (v) => (v / 1000000).toFixed(1) + 'M'
                                        }
                                    },
                                    x: { grid: { display: false }, ticks: { font: { size: 10 } } }
                                }
                            }
                        });
                    }

                    // Booking Chart Implementation
                    if (rawBookingData.status === "error") {
                        displayError('bookingContainer', rawBookingData.message);
                    } else if (rawBookingData.data) {
                        const ctx = document.getElementById('bookingChart').getContext('2d');
                        new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: rawBookingData.data.labels,
                                datasets: [
                                    {
                                        label: 'Thực tế',
                                        data: rawBookingData.data.actual_bookings,
                                        backgroundColor: '#B89A6C',
                                        borderRadius: 8,
                                        maxBarThickness: 30
                                    },
                                    {
                                        label: 'Dự báo Mùa vụ',
                                        data: rawBookingData.data.predicted_bookings,
                                        backgroundColor: 'rgba(74, 66, 56, 0.05)',
                                        borderColor: 'rgba(74, 66, 56, 0.3)',
                                        borderWidth: 1,
                                        borderDash: [5, 5],
                                        borderRadius: 8,
                                        maxBarThickness: 30
                                    }
                                ]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                plugins: {
                                    legend: {
                                        position: 'bottom',
                                        labels: {
                                            padding: 40,
                                            boxWidth: 12,
                                            usePointStyle: true,
                                            font: { size: 10, weight: 'bold' }
                                        }
                                    }
                                },
                                scales: {
                                    y: { grid: { color: 'rgba(184, 154, 108, 0.05)', drawBorder: false }, ticks: { font: { size: 10 } } },
                                    x: { grid: { display: false }, ticks: { font: { size: 10 } } }
                                }
                            }
                        });
                    }
                })();
        </script>
    </body>

    </html>