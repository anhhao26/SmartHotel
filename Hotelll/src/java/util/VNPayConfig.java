package util;

public class VNPayConfig {
    public static String vnp_TmnCode = "KCFAU4DC";
    
    // Sử dụng mã HashSecret mới nhất từ hình Screenshot 2026-03-04 003004.png
    public static String vnp_HashSecret = "UO29Z84GTRUJFZIYZQV09KB5O33G1QQF";
    
    public static String vnp_PayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";

    // URL callback khi VNPay trả về kết quả thanh toán - trỏ vào Koyeb production
    public static String vnp_ReturnUrl = "https://damp-beatrisa-tyberos-99b62712.koyeb.app/vnpay_return";
}