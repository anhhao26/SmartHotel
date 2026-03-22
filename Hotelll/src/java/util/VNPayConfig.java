package util;

public class VNPayConfig {
    // Thông tin Sandbox mới nhất từ email VNPAY (09C794F4)
    public static String vnp_TmnCode = "09C794F4";
    
    public static String vnp_HashSecret = "VPP4CETHK6KY1D4CVZF4VQ2OLAQVEXRT";
    
    public static String vnp_PayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";

    // URL callback về web Koyeb sau khi thanh toán xong
    public static String vnp_ReturnUrl = "https://damp-beatrisa-tyberos-99b62712.koyeb.app/Hotelll/vnpay_return";
}