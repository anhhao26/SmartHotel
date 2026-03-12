<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.smarthotel.service.CustomerService" %>
<%@ page import="com.smarthotel.model.Customer" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SmartHotel - Guest Portal</title>
    <meta content="Manage your SmartHotel profile and book your next stay." name="description"/>
    <link href="https://fonts.googleapis.com" rel="preconnect"/>
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#2563EB", 
                        secondary: "#D97706", 
                        "background-light": "#F3F4F6",
                        "background-dark": "#111827",
                        "surface-light": "#FFFFFF",
                        "surface-dark": "#1F2937",
                        "text-light": "#1F2937",
                        "text-dark": "#F9FAFB",
                        "accent-gold": "#F59E0B",
                    },
                    fontFamily: {
                        sans: ["Inter", "sans-serif"],
                        display: ["Playfair Display", "serif"],
                    },
                    borderRadius: { DEFAULT: "0.5rem", },
                },
            },
        };
    </script>
    <style>
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background-color: #cbd5e1; border-radius: 20px; }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark text-text-light dark:text-text-dark font-sans transition-colors duration-300 min-h-screen flex flex-col">

<%
  Object o = session.getAttribute("acc");
  if (o == null) { response.sendRedirect(request.getContextPath()+"/login.jsp"); return; }
  Integer cid = (Integer) session.getAttribute("CUST_ID");
  if (cid == null) { response.sendRedirect(request.getContextPath()+"/login.jsp"); return; }

  CustomerService cs = new CustomerService();
  Customer cus = cs.getById(cid);
  if (cus == null) { out.println("<div class='p-4 text-center text-red-500 font-bold'>Không tìm thấy thông tin khách!</div>"); return; }
  
  boolean isVip = cus.getMemberType() != null && cus.getMemberType().toUpperCase().contains("VIP");
%>

<nav class="sticky top-0 z-50 bg-primary shadow-lg dark:border-b dark:border-gray-700">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">
            <a href="<%=request.getContextPath()%>/” class="flex items-center gap-2">
                <span class="material-icons-round text-white text-3xl">domain</span>
                <span class="font-display font-bold text-2xl text-white tracking-wide">SmartHotel</span>
            </a>
            <div class="flex items-center gap-4">
                <div class="hidden md:flex items-center gap-2 text-white/90 text-sm">
                    <span>Welcome, <%= cus.getFullName() %></span>
                </div>
                <a href="<%=request.getContextPath()%>/logout" class="bg-white/10 hover:bg-white/20 text-white px-4 py-2 rounded-md text-sm font-medium transition-colors border border-white/20">
                    Sign Out
                </a>
            </div>
        </div>
    </div>
</nav>

<main class="flex-grow max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 w-full">
    <div class="mb-8">
        <h1 class="text-3xl font-display font-bold text-gray-900 dark:text-white">Guest Portal</h1>
        <p class="text-gray-500 dark:text-gray-400 mt-1">Quản lý thông tin cá nhân và lịch sử đặt phòng của bạn.</p>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
        <div class="lg:col-span-4 space-y-6">
            <div class="bg-surface-light dark:bg-surface-dark rounded-xl shadow-md border border-gray-100 dark:border-gray-700 overflow-hidden">
                <div class="relative h-24 bg-gradient-to-r from-primary to-blue-600">
                    <div class="absolute -bottom-10 left-1/2 transform -translate-x-1/2">
                        <div class="w-20 h-20 rounded-full bg-surface-light dark:bg-surface-dark border-4 border-surface-light dark:border-surface-dark flex items-center justify-center shadow-md">
                            <span class="material-icons-round text-4xl text-gray-400 dark:text-gray-500">person</span>
                        </div>
                    </div>
                </div>
                <div class="pt-12 pb-6 px-6 text-center">
                    <h2 class="text-xl font-bold text-primary dark:text-blue-400"><%= cus.getFullName() %></h2>
                    
                    <div class="mt-2 inline-flex items-center px-3 py-1 rounded-full text-xs font-medium <%= isVip ? "bg-secondary text-white" : "bg-gray-200 text-gray-700" %> shadow-sm">
                        <span class="material-icons-round text-sm mr-1"><%= isVip ? "stars" : "badge" %></span> 
                        <%= cus.getMemberType() != null ? cus.getMemberType() : "Standard Member" %>
                    </div>
                    
                    <div class="mt-6 grid grid-cols-2 gap-4 border-t border-gray-100 dark:border-gray-700 pt-6">
                        <div class="text-center">
                            <p class="text-sm text-gray-500 dark:text-gray-400">Điểm thưởng</p>
                            <p class="text-2xl font-bold text-green-600 dark:text-green-400"><%= cus.getPoints() %> Pts</p>
                        </div>
                        <div class="text-center">
                            <p class="text-sm text-gray-500 dark:text-gray-400">Tổng chi tiêu</p>
                            <p class="text-lg font-bold text-red-500 dark:text-red-400"><%= String.format("%,.0f", cus.getTotalSpending()) %> ₫</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="bg-accent-gold/10 dark:bg-accent-gold/5 rounded-xl border border-accent-gold/30 p-6 text-center">
                <span class="material-icons-round text-4xl text-accent-gold mb-2">hotel</span>
                <h3 class="text-lg font-bold text-gray-900 dark:text-white mb-2">Sẵn sàng cho kỳ nghỉ mới?</h3>
                <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">Khám phá các hạng phòng cao cấp và tận hưởng kỳ nghỉ của bạn.</p>
                <a href="<%=request.getContextPath()%>/rooms" class="w-full bg-accent-gold hover:bg-yellow-600 text-white font-medium py-2 px-4 rounded shadow-md transition-colors flex items-center justify-center gap-2">
                    <span class="material-icons-round text-sm">search</span> Khám Phá Phòng
                </a>
                <a href="<%=request.getContextPath()%>/guest/history.jsp" class="w-full mt-3 bg-white dark:bg-gray-800 hover:bg-gray-50 dark:hover:bg-gray-700 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 font-medium py-2 px-4 rounded shadow-sm transition-colors flex items-center justify-center">
                    Xem Lịch Sử Đặt Phòng
                </a>
            </div>
        </div>

        <div class="lg:col-span-8">
            <div class="bg-surface-light dark:bg-surface-dark rounded-xl shadow-md border border-gray-100 dark:border-gray-700 overflow-hidden min-h-[500px]">
                <div class="border-b border-gray-200 dark:border-gray-700">
                    <nav class="-mb-px flex">
                        <button class="w-full py-4 px-1 text-center border-b-2 border-primary text-primary font-medium text-sm flex items-center justify-center gap-2 bg-primary/5">
                            <span class="material-icons-round text-lg">badge</span> Chi Tiết Hồ Sơ
                        </button>
                    </nav>
                </div>
                
                <div class="p-6 sm:p-8">
                    <form action="${pageContext.request.contextPath}/updateProfile" method="post" class="space-y-6">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">Họ và Tên</label>
                                <input name="fullName" value="<%= cus.getFullName() %>" class="mt-1 block w-full rounded-md border-gray-300 dark:border-gray-600 bg-gray-50 dark:bg-gray-800 text-gray-900 dark:text-white shadow-sm focus:border-primary focus:ring-primary sm:text-sm py-2 px-3 font-bold" type="text" required/>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">CCCD / Passport</label>
                                <input name="cccd" value="<%= cus.getCccdPassport()!=null?cus.getCccdPassport():"" %>" class="mt-1 block w-full rounded-md border-gray-300 dark:border-gray-600 dark:bg-gray-800 text-gray-900 dark:text-white shadow-sm focus:border-primary focus:ring-primary sm:text-sm py-2 px-3" type="text"/>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">Số Điện Thoại</label>
                                <div class="mt-1 relative rounded-md shadow-sm">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none"><span class="material-icons-round text-gray-400 text-sm">phone</span></div>
                                    <input name="phone" value="<%= cus.getPhone()!=null?cus.getPhone():"" %>" class="block w-full pl-10 rounded-md border-gray-300 dark:border-gray-600 dark:bg-gray-800 text-gray-900 dark:text-white focus:border-primary focus:ring-primary sm:text-sm py-2 px-3" type="text"/>
                                </div>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">Email</label>
                                <div class="mt-1 relative rounded-md shadow-sm">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none"><span class="material-icons-round text-gray-400 text-sm">email</span></div>
                                    <input name="email" value="<%= cus.getEmail()!=null?cus.getEmail():"" %>" class="block w-full pl-10 rounded-md border-gray-300 dark:border-gray-600 dark:bg-gray-800 text-gray-900 dark:text-white focus:border-primary focus:ring-primary sm:text-sm py-2 px-3" type="email"/>
                                </div>
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">Địa chỉ</label>
                            <input name="address" value="<%= cus.getAddress()!=null?cus.getAddress():"" %>" class="mt-1 block w-full rounded-md border-gray-300 dark:border-gray-600 dark:bg-gray-800 text-gray-900 dark:text-white shadow-sm focus:border-primary focus:ring-primary sm:text-sm py-2 px-3" type="text"/>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">Quốc tịch</label>
                                <input name="nationality" value="<%= cus.getNationality()!=null?cus.getNationality():"" %>" class="mt-1 block w-full rounded-md border-gray-300 dark:border-gray-600 dark:bg-gray-800 text-gray-900 dark:text-white shadow-sm focus:border-primary focus:ring-primary sm:text-sm py-2 px-3" type="text"/>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">Ngày sinh</label>
                                <input name="dob" value="<%= (cus.getDateOfBirth()!=null)? new java.text.SimpleDateFormat("yyyy-MM-dd").format(cus.getDateOfBirth()) : "" %>" class="mt-1 block w-full rounded-md border-gray-300 dark:border-gray-600 dark:bg-gray-800 text-gray-900 dark:text-white shadow-sm focus:border-primary focus:ring-primary sm:text-sm py-2 px-3" type="date"/>
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">Sở thích / Yêu cầu (Preferences)</label>
                            <textarea name="preferences" class="mt-1 block w-full rounded-md border-gray-300 dark:border-gray-600 dark:bg-gray-800 text-gray-900 dark:text-white shadow-sm focus:border-primary focus:ring-primary sm:text-sm py-2 px-3" rows="3"><%= cus.getPreferences()!=null?cus.getPreferences():"" %></textarea>
                        </div>
                        <div class="flex justify-end pt-4">
                            <button type="submit" class="bg-green-600 hover:bg-green-700 text-white font-medium py-2 px-6 rounded shadow-md transition-colors flex items-center gap-2">
                                <span class="material-icons-round text-sm">save</span> Lưu Thay Đổi
                            </button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</main>

<footer class="bg-surface-light dark:bg-surface-dark border-t border-gray-200 dark:border-gray-700 mt-auto py-6">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center text-sm text-gray-500 dark:text-gray-400">
        <p>© 2026 SmartHotel Management System. All rights reserved.</p>
    </div>
</footer>
                        <!-- Nút nổi mở Chat Box -->
<button id="chatbot-toggle" class="fixed bottom-6 right-6 bg-primary text-white p-4 rounded-full shadow-lg hover:bg-blue-700 transition z-50 flex items-center justify-center">
    <span class="material-icons-round">chat</span>
</button>

<!-- Khung Chat Box (Ẩn mặc định) -->
<div id="chatbot-window" class="fixed bottom-24 right-6 w-[360px] bg-white dark:bg-gray-800 rounded-lg shadow-2xl border border-gray-200 dark:border-gray-700 hidden flex-col overflow-hidden z-50 h-[500px]">
    <!-- Header -->
    <div class="bg-primary text-white p-3 flex justify-between items-center rounded-t-lg shadow-sm z-10">
        <span class="font-bold flex items-center gap-2"><span class="material-icons-round text-lg">smart_toy</span> SmartHotel AI</span>
        <button id="chatbot-close" class="text-white hover:text-gray-200 transition-colors"><span class="material-icons-round text-sm">close</span></button>
    </div>
    <!-- Body chứa nội dung chat -->
    <div id="chat-messages" class="flex-1 overflow-y-auto p-4 flex flex-col gap-4 bg-gray-50/50 dark:bg-gray-900/50">
        <!-- AI Greeting -->
        <div class="flex gap-2 w-full flex-row">
            <div class="flex-shrink-0 w-8 h-8 rounded-full flex items-center justify-center bg-secondary text-white shadow-sm mt-1">
                <span class="material-icons-round text-[18px]">smart_toy</span>
            </div>
            <div class="p-3 rounded-xl text-sm max-w-[80%] break-words whitespace-pre-wrap bg-white dark:bg-gray-800 text-gray-800 dark:text-gray-100 rounded-tl-none shadow-sm border border-gray-100 dark:border-gray-700 leading-relaxed font-medium">Xin chào! Tôi là trợ lý ảo thông minh của SmartHotel. Tôi có thể giúp gì cho quý khách hôm nay?</div>
        </div>
    </div>
    <!-- Input Area -->
    <div class="p-3 border-t border-gray-200 dark:border-gray-700 flex gap-2 bg-white dark:bg-gray-800">
        <input type="text" id="chat-input" class="flex-1 border border-gray-300 dark:border-gray-600 rounded-md px-3 py-2 text-sm focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:text-white" placeholder="Nhập tin nhắn...">
        <button id="chat-send" class="bg-primary text-white px-3 py-2 rounded-md hover:bg-blue-700 flex items-center justify-center">
            <span class="material-icons-round text-sm">send</span>
        </button>
    </div>
</div>
<script>
    const toggleBtn = document.getElementById('chatbot-toggle');
    const closeBtn = document.getElementById('chatbot-close');
    const chatWindow = document.getElementById('chatbot-window');
    const sendBtn = document.getElementById('chat-send');
    const chatInput = document.getElementById('chat-input');
    const messagesDiv = document.getElementById('chat-messages');

    // Đóng/Mở Chat Box
    toggleBtn.addEventListener('click', () => { chatWindow.classList.toggle('hidden'); chatWindow.classList.toggle('flex'); });
    closeBtn.addEventListener('click', () => { chatWindow.classList.add('hidden'); chatWindow.classList.remove('flex'); });

    // Nối tin nhắn UI
    function appendMessage(text, isUser) {
        const msgContainer = document.createElement('div');
        msgContainer.className = 'flex gap-2 w-full mt-2 ' + (isUser ? 'flex-row-reverse' : 'flex-row');
        
        // Avatar
        const avatar = document.createElement('div');
        avatar.className = 'flex-shrink-0 w-8 h-8 rounded-full flex items-center justify-center shadow-sm mt-1 ' + (isUser ? 'bg-primary text-white' : 'bg-secondary text-white');
        avatar.innerHTML = '<span class="material-icons-round text-[18px]">' + (isUser ? 'person' : 'smart_toy') + '</span>';
        
        // Bong bóng chat
        const bubble = document.createElement('div');
        bubble.className = 'p-3 text-sm max-w-[80%] break-words whitespace-pre-wrap leading-relaxed shadow-sm ' + (isUser ? 'bg-primary text-white rounded-2xl rounded-tr-sm font-medium' : 'bg-white dark:bg-gray-800 text-gray-800 dark:text-gray-100 rounded-2xl rounded-tl-sm border border-gray-100 dark:border-gray-700');
        
        // Parse format cơ bản (In đậm, In nghiêng) an toàn với XSS
        let safeText = text.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
        let formattedText = safeText.replace(/\*\*(.*?)\*\*/g, '<b>$1</b>').replace(/\*(.*?)\*/g, '<i>$1</i>');
        bubble.innerHTML = formattedText;
        
        msgContainer.appendChild(avatar);
        msgContainer.appendChild(bubble);
        messagesDiv.appendChild(msgContainer);
        
        // Cuộn mượt mà
        messagesDiv.scrollTo({ top: messagesDiv.scrollHeight, behavior: 'smooth' });
    }

    // Gửi tin nhắn qua API Python (đang chạy ở cổng 5000)
    sendBtn.addEventListener('click', async () => {
        const text = chatInput.value.trim();
        if (!text) return;
        
        appendMessage(text, true); // Hiện tin nhắn người dùng
        chatInput.value = '';

        try {
            // Gọi Python Flask đang chạy ở cổng 5000 chứ không phải 8000
            const response = await fetch('http://localhost:5000/api/chat', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ message: text })
            });
            const data = await response.json();
            if (data.status === 'success') {
                appendMessage(data.reply, false); // Hiện tin nhắn AI
            } else {
                appendMessage("Lỗi từ AI: " + data.message, false);
            }
        } catch (error) {
            appendMessage("Lỗi kết nối đến Server AI (Hãy chắc chắn bạn đang chạy 'python app.py')", false);
        }
    });

    // Bắt sự kiện bàn phím (Bấm phím Enter để Gửi)
    chatInput.addEventListener('keypress', (e) => {
        if(e.key === 'Enter') sendBtn.click();
    });
</script>

</body>
</html>