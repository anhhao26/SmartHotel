package util;

public class VNPayConfig {
    public static String vnp_TmnCode = "09C794F4";
    
    // Sử dụng mã HashSecret mới nhất từ hình Screenshot 2026-03-04 003004.png
    public static String vnp_HashSecret = "VPP4CETHK6KY1D4CVZF4VQ2OLAQVEXRT";
    
    public static String vnp_PayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";

    // URL KOYEB (Đã deploy - Không cần ngrok nữa)
    public static String vnp_ReturnUrl= "https://damp-beatrisa-tyberos-99b62712.koyeb.app/vnpay_return";
}