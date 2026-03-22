<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>SmartHotel - Đăng Ký Hội Viên</title>

        <link
            href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400&family=Inter:wght@300;400;500;600;700&family=Be+Vietnam+Pro:wght@100;300;400;500;700;900&display=swap"
            rel="stylesheet">
        <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
            rel="stylesheet" />

        <script src="https://cdn.tailwindcss.com"></script>
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
            body {
                background-color: #FAF9F6;
                color: #2C2722;
                overflow-x: hidden;
                font-family: 'Inter', sans-serif;
            }

            .input-elegant {
                background: #FFFFFF;
                border: 1px solid rgba(184, 154, 108, 0.1);
                color: #2C2722;
                transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
                font-family: 'Inter', sans-serif;
            }

            .input-elegant:focus {
                border-color: #B89A6C;
                background: #FFFFFF;
                box-shadow: 0 15px 30px -10px rgba(184, 154, 108, 0.1);
                transform: translateY(-2px);
                outline: none;
            }

            .label-premium {
                font-family: 'Inter', sans-serif;
                font-size: 10px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.25em;
                color: #70685F;
                margin-bottom: 0.75rem;
                display: block;
                opacity: 0.8;
            }

            .step-inactive {
                display: none;
            }

            .step-transition {
                animation: fadeInScale 0.6s ease-out forwards;
            }

            @keyframes fadeInScale {
                from {
                    opacity: 0;
                    transform: translateY(10px) scale(0.98);
                }

                to {
                    opacity: 1;
                    transform: translateY(0) scale(1);
                }
            }

            .progress-line {
                transition: width 0.8s cubic-bezier(0.65, 0, 0.35, 1);
            }

            ::-webkit-scrollbar {
                width: 3px;
            }

            ::-webkit-scrollbar-track {
                background: transparent;
            }

            ::-webkit-scrollbar-thumb {
                background: #B89A6C;
                border-radius: 10px;
            }
        </style>
    </head>

    <body class="antialiased min-h-screen relative flex">
        <%@ include file="/common/toast.jspf" %>

            <div class="hidden lg:flex w-[40%] relative overflow-hidden bg-hotel-chocolate">
                <div class="absolute inset-0 bg-hotel-chocolate/30 z-10"></div>
                <img src="https://images.unsplash.com/photo-1571896349842-33c89424de2d?q=80&w=2080"
                    class="absolute inset-0 w-full h-full object-cover opacity-80" alt="Luxury Resort">

                <div class="relative z-20 flex flex-col justify-end p-20 h-full">
                    <h1 class="text-7xl font-serif font-bold text-white leading-tight mb-8 italic">
                        Tuyệt Tác <br />
                        <span class="not-italic text-hotel-gold">Nghỉ Dưỡng.</span>
                    </h1>
                    <p class="text-white/60 text-sm font-medium uppercase tracking-widest max-w-md leading-relaxed">
                        Đăng ký hội viên để bắt đầu hành trình trải nghiệm sự sang trọng và ấm cúng độc bản tại
                        SmartHotel.
                    </p>
                </div>
            </div>

            <div class="w-full lg:w-[60%] flex flex-col bg-hotel-cream relative shadow-2xl overflow-y-auto">

                <div class="p-10 flex justify-between items-center border-b border-hotel-gold/10">
                    <a href="${pageContext.request.contextPath}/" class="flex items-center gap-4 group">
                        <div
                            class="w-10 h-10 rounded-sm bg-hotel-gold/5 border border-hotel-gold/20 flex items-center justify-center">
                            <span class="material-symbols-outlined text-hotel-gold text-2xl">hotel</span>
                        </div>
                        <span
                            class="font-serif font-bold text-xl tracking-tight text-hotel-text uppercase">SmartHotel</span>
                    </a>
                    <div class="flex items-center gap-8">
                        <a href="${pageContext.request.contextPath}/login.jsp"
                            class="text-[10px] font-bold text-hotel-muted hover:text-hotel-gold tracking-widest uppercase transition-all">
                            ĐÃ CÓ TÀI KHOẢN?
                        </a>
                        <a href="${pageContext.request.contextPath}/login.jsp"
                            class="px-8 py-3 bg-hotel-gold text-white text-[10px] font-bold tracking-widest uppercase rounded-sm hover:bg-hotel-text transition-all shadow-lg flex items-center gap-2">
                            ĐĂNG NHẬP <span class="material-symbols-outlined text-lg">login</span>
                        </a>
                    </div>
                </div>

                <div class="px-12 lg:px-24 mt-12 mb-16">
                    <div class="flex justify-between items-end mb-4">
                        <div class="space-y-1">
                            <span id="stepCounter"
                                class="text-[9px] font-bold text-hotel-gold uppercase tracking-widest">BƯỚC
                                01 / 04</span>
                            <h2 id="stepTitle" class="text-4xl font-serif font-bold text-hotel-text tracking-tight">
                                Thông Tin
                                Tài Khoản</h2>
                        </div>
                        <div class="text-[9px] font-bold text-hotel-muted uppercase tracking-widest opacity-60">DỮ LIỆU
                            ĐƯỢC BẢO
                            MẬT</div>
                    </div>
                    <div class="h-1 w-full bg-hotel-gold/10 rounded-full overflow-hidden">
                        <div id="progressBar" class="h-full bg-hotel-gold progress-line" style="width: 25%"></div>
                    </div>
                </div>

                <div class="flex-1 px-12 lg:px-24 pb-20">
                    <form id="onboardingForm" action="${pageContext.request.contextPath}/register" method="post"
                        class="max-w-xl">

                        <% String err=(String) request.getAttribute("err"); if (err !=null) { %>
                            <script>
                                window.onload = () => { showToast("<%= err %>", "error"); };
                            </script>
                            <% } %>

                                <div id="step1" class="step-transition space-y-10">
                                    <div class="space-y-8">
                                        <div class="space-y-1 group">
                                            <label class="label-premium ml-1">Tên Đăng Nhập</label>
                                            <input type="text" name="username" required
                                                class="w-full h-20 px-8 rounded-xl input-elegant font-bold text-xl text-hotel-text placeholder:text-hotel-muted/20"
                                                placeholder="Nhập tên đăng nhập hội viên..." />
                                        </div>
                                        <div class="space-y-1 group">
                                            <label class="label-premium ml-1">Mật Khẩu</label>
                                            <input type="password" name="password" required
                                                class="w-full h-20 px-8 rounded-xl input-elegant font-bold text-xl text-hotel-text tracking-[0.4em] placeholder:tracking-normal placeholder:text-hotel-muted/20"
                                                placeholder="••••••••••••" />
                                        </div>
                                    </div>
                                </div>

                                <div id="step2" class="step-inactive step-transition space-y-10">
                                    <div class="grid grid-cols-1 gap-10">
                                        <div class="space-y-1 group">
                                            <label class="label-premium ml-1">Danh xưng hội viên</label>
                                            <input type="text" name="fullName" required
                                                class="w-full h-22 px-8 rounded-xl input-elegant font-serif font-bold text-3xl text-hotel-text italic border-hotel-gold/20"
                                                placeholder="NGUYỄN VĂN A" />
                                        </div>
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                                            <div class="space-y-1 group">
                                                <label class="label-premium ml-1">Thư điện tử (Email)</label>
                                                <input type="email" name="email" required
                                                    pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$"
                                                    title="Vui lòng nhập đúng định dạng (Ví dụ: ten@domain.com)"
                                                    class="w-full h-20 px-8 rounded-xl input-elegant font-semibold text-hotel-text text-[15px] tracking-wide"
                                                    placeholder="example@mail.com" />
                                            </div>
                                            <div class="space-y-1 group">
                                                <label class="label-premium ml-1">Đường dây liên hệ</label>
                                                <input type="tel" name="phone" required
                                                    pattern="\d{10}"
                                                    title="Số điện thoại phải bao gồm chính xác 10 chữ số"
                                                    class="w-full h-20 px-8 rounded-xl input-elegant font-bold text-hotel-text text-[17px] tracking-widest"
                                                    placeholder="0912345678" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div id="step3" class="step-inactive step-transition space-y-8">
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                                        <div class="space-y-1 group">
                                            <label class="label-premium ml-1">Định danh pháp lý (CCCD/Passport)</label>
                                            <input type="text" name="cccd" required
                                                pattern="\d{12}"
                                                title="CCCD phải bao gồm chính xác 12 chữ số"
                                                class="w-full h-20 px-8 rounded-xl input-elegant font-bold text-hotel-text text-lg tracking-[0.3em]"
                                                placeholder="012345678912" />
                                        </div>
                                        <div class="space-y-1 group">
                                            <label class="label-premium ml-1">Giới tính</label>
                                            <div class="relative">
                                                <select name="gender" required
                                                    class="w-full h-20 px-8 rounded-xl input-elegant font-bold text-hotel-text appearance-none cursor-pointer text-[13px] tracking-widest uppercase">
                                                    <option value="">LỰA CHỌN</option>
                                                    <option value="Male">NAM GIỚI (MALE)</option>
                                                    <option value="Female">NỮ GIỚI (FEMALE)</option>
                                                </select>
                                                <span
                                                    class="material-symbols-outlined absolute right-6 top-1/2 -translate-y-1/2 text-hotel-gold/40 pointer-events-none">expand_more</span>
                                            </div>
                                        </div>
                                        <div class="space-y-1 group">
                                            <label class="label-premium ml-1">Niên san (DOB)</label>
                                            <input id="dobInput" type="date" name="dob" required
                                                class="w-full h-20 px-8 rounded-xl input-elegant font-bold text-hotel-muted text-[13px] uppercase tracking-widest" />
                                        </div>
                                        <div class="space-y-1 group">
                                            <label class="label-premium ml-1">Bản quán (Nationality)</label>
                                            <input type="text" name="nationality" required
                                                class="w-full h-20 px-8 rounded-xl input-elegant font-bold text-hotel-text uppercase tracking-widest placeholder:text-hotel-muted/20"
                                                placeholder="VIỆT NAM" />
                                        </div>
                                        <div class="md:col-span-2 space-y-1 group">
                                            <label class="label-premium ml-1">Địa chỉ thường trú</label>
                                            <input type="text" name="address" required
                                                class="w-full h-20 px-8 rounded-xl input-elegant font-semibold text-hotel-text text-[15px]"
                                                placeholder="Số nhà, Tên đường, Thành phố..." />
                                        </div>
                                    </div>
                                </div>

                                <div id="step4" class="step-inactive step-transition space-y-10">
                                    <div class="space-y-1 group">
                                        <label class="label-premium ml-1">Tâm đắc & Yêu cầu riêng biệt</label>
                                        <textarea name="preferences" rows="4"
                                            class="w-full p-8 rounded-2xl input-elegant font-medium text-hotel-text text-[13px] resize-none leading-relaxed placeholder:text-hotel-muted/20"
                                            placeholder="Vui lòng chia sẻ các sở thích đặc biệt như phòng hướng biển, tầng cao, yêu cầu trà xanh..."></textarea>
                                    </div>
                                    <div
                                        class="p-8 rounded-sm bg-hotel-gold/5 border border-hotel-gold/10 flex items-start gap-5">
                                        <span class="material-symbols-outlined text-hotel-gold text-3xl">verified</span>
                                        <div class="space-y-1">
                                            <h4 class="text-[10px] font-bold text-hotel-text uppercase tracking-widest">
                                                Chính
                                                sách hội viên</h4>
                                            <p
                                                class="text-[10px] font-medium text-hotel-muted leading-relaxed uppercase tracking-wider">
                                                Bằng cách đăng ký, quý khách đồng ý gia nhập cộng đồng hội viên tinh hoa
                                                của
                                                SmartHotel.
                                                Dữ liệu được bảo mật tối đa theo chuẩn quốc tế.
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <div class="pt-16 flex items-center justify-between">
                                    <button type="button" id="prevBtn"
                                        class="px-10 h-16 rounded-xl border border-hotel-gold/10 text-[11px] font-bold text-hotel-gold uppercase tracking-[0.3em] hover:bg-hotel-gold hover:text-white transition-all opacity-0 pointer-events-none active:scale-95 shadow-sm">
                                        QUAY LẠI
                                    </button>
                                    <button type="button" id="nextBtn"
                                        class="px-16 h-18 rounded-xl bg-hotel-gold text-white font-bold text-[14px] tracking-[0.3em] uppercase hover:bg-hotel-text transition-all flex items-center gap-4 active:scale-95 shadow-xl shadow-hotel-gold/20">
                                        TIẾP TỤC <span class="material-symbols-outlined text-xl">east</span>
                                    </button>
                                    <button type="submit" id="submitBtn"
                                        class="hidden px-20 h-18 rounded-xl bg-hotel-gold text-white font-bold text-[14px] tracking-[0.3em] uppercase hover:bg-hotel-text transition-all flex items-center justify-center gap-4 active:scale-95 shadow-xl shadow-hotel-gold/30">
                                        KHÁNH THÀNH HỒ SƠ <span
                                            class="material-symbols-outlined text-xl">verified</span>
                                    </button>
                                </div>

                    </form>
                </div>

                <div class="p-10 border-t border-hotel-gold/10 flex justify-between items-center opacity-40">
                    <div class="flex items-center gap-4">
                        <span class="w-1.5 h-1.5 rounded-full bg-hotel-gold"></span>
                        <span class="text-[8px] font-bold text-hotel-muted uppercase tracking-[0.4em]">HỆ THỐNG
                            SMARTCHANCE BẢO
                            MẬT</span>
                    </div>
                    <span class="text-[8px] font-bold text-hotel-muted uppercase tracking-[0.4em]">PHIÊN BẢN
                        2026.1</span>
                </div>
            </div>

            <script>
                document.addEventListener('DOMContentLoaded', () => {
                    // --- ĐOẠN SCRIPT CHẶN NGÀY SINH TƯƠNG LAI ---
                    const dobInput = document.getElementById('dobInput');
                    if (dobInput) {
                        const today = new Date().toISOString().split('T')[0];
                        dobInput.setAttribute('max', today);
                    }
                    // --------------------------------------------

                    let currentStep = 1;
                    const totalSteps = 4;
                    const steps = [
                        { title: "Thông Tin Tài Khoản", progress: 25 },
                        { title: "Hồ Sơ Cá Nhân", progress: 50 },
                        { title: "Định Danh & Cư Trú", progress: 75 },
                        { title: "Yêu Cầu Đặc Biệt", progress: 100 }
                    ];

                    const nextBtn = document.getElementById('nextBtn');
                    const prevBtn = document.getElementById('prevBtn');
                    const submitBtn = document.getElementById('submitBtn');
                    const bar = document.getElementById('progressBar');
                    const counter = document.getElementById('stepCounter');
                    const stepTitle = document.getElementById('stepTitle');
                    const formContainer = document.querySelector('.overflow-y-auto');

            function updateUI() {
                // Hide all steps
                for (let i = 1; i <= totalSteps; i++) {
                    const stepDiv = document.getElementById('step' + i);
                    if (stepDiv) {
                        stepDiv.style.display = 'none';
                        stepDiv.classList.remove('step-transition');
                    }
                }

                // Show current step
                const currentEl = document.getElementById('step' + currentStep);
                if (currentEl) {
                    currentEl.style.display = 'block';
                    currentEl.classList.add('step-transition');
                }

                if (currentStep === 1) {
                    prevBtn.style.opacity = '0';
                    prevBtn.style.pointerEvents = 'none';
                } else {
                    prevBtn.style.opacity = '1';
                    prevBtn.style.pointerEvents = 'auto';
                }

                if (currentStep === totalSteps) {
                    nextBtn.classList.add('hidden');
                    submitBtn.classList.remove('hidden');
                } else {
                    nextBtn.classList.remove('hidden');
                    submitBtn.classList.add('hidden');
                }

                bar.style.width = steps[currentStep - 1].progress + '%';
                counter.innerText = "BƯỚC 0" + currentStep + " / 0" + totalSteps;
                stepTitle.innerText = steps[currentStep - 1].title;

                // Scroll to top of form area
                const scrollTarget = document.getElementById('stepCounter');
                if (scrollTarget) {
                    scrollTarget.scrollIntoView({ behavior: 'smooth' });
                }
            }

            nextBtn.addEventListener('click', (e) => {
                e.preventDefault();
                if (currentStep < totalSteps) {
                    const currentStepDiv = document.getElementById('step' + currentStep);
                    const requiredFields = currentStepDiv.querySelectorAll('[required]');
                    let allValid = true;
                    
                    requiredFields.forEach(f => {
                        if (!f.checkValidity()) {
                            f.style.borderColor = "#B89A6C";
                            f.style.backgroundColor = "rgba(184, 154, 108, 0.05)";
                            allValid = false;
                        } else {
                            f.style.borderColor = "rgba(184, 154, 108, 0.15)";
                            f.style.backgroundColor = "#FFFFFF";
                        }
                    });

                    if (!allValid) {
                        if (window.showToast) {
                            showToast("Vui lòng nhập đúng định dạng các thông tin bắt buộc.", "warning");
                        } else {
                            alert("Vui lòng nhập đúng định dạng các thông tin bắt buộc.");
                        }
                        // Trigger native validation popup so user sees what is wrong
                        document.getElementById('onboardingForm').reportValidity();
                        return;
                    }

                    currentStep++;
                    updateUI();
                }
            });

                    prevBtn.addEventListener('click', () => {
                        if (currentStep > 1) {
                            currentStep--;
                            updateUI();
                        }
                    });

                    // Prevent enter key from submitting except on last step
                    document.getElementById('onboardingForm').addEventListener('keydown', (e) => {
                        if (e.key === 'Enter' && currentStep < totalSteps) {
                            e.preventDefault();
                            nextBtn.click();
                        }
                    });

                    // Initialize UI
                    updateUI();
                });
            </script>
            <script>
                // No-op for removed toast include at bottom
            </script>
    </body>

    </html>