package util;

public class VNPayConfig {
    public static String vnp_TmnCode = "CYGIZFZ8";
    
    // Sử dụng mã HashSecret mới nhất từ hình Screenshot 2026-03-04 003004.png
    public static String vnp_HashSecret = "TY1CAS9E0YGBXYGNQTZTCBPNHM877078";
    
    public static String vnp_PayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";

    // PHẢI SỬA DÒNG NÀY THEO LINK NGROK ĐANG CHẠY
    public static String vnp_ReturnUrl = "https://genitival-unrepudiative-erline.ngrok-free.dev/SmartHotel/vnpay_return";
}