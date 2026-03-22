import sys
import re

file_path = r'd:\github\SmartHotel\Hotelll\web\WEB-INF\rooms.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    text = f.read()

btn1_old = r'<button @click=\"[\s\S]*?tiết</button>'
btn1_new = r'''<button @click=\"
                                activeRoom = {
                                    num: '${room.roomNumber}',
                                    type: '${room.roomType.typeName}',
                                    price: '${room.price}',
                                    cap: '${room.roomType.maxCapacity}',
                                    desc: '${fn:escapeXml(room.roomType.amenities)}',
                                    status: '${room.status}'
                                };
                                gallery = getRoomGallery(activeRoom.type);
                                activeImg = '${roomImg}';
                                modalOpen = true;
                                document.body.style.overflow = 'hidden';
                            \" class=\"flex-1 py-4 px-2 rounded-2xl text-hotel-text font-bold text-[11px] tracking-[0.2em] uppercase border border-hotel-gold/30 hover:bg-hotel-gold/10 hover:border-hotel-gold transition-all duration-300\">
                                                Chi Tiết
                                            </button>'''

btn2_old = r'<a href=\"\$\{empty sessionScope\.acc \? pageContext\.request\.contextPath\.concat\(\'/login\.jsp\?redirect=booking&roomId=\'\)\.concat\(room\.roomNumber\) : pageContext\.request\.contextPath\.concat\(\'/webapp/search\.jsp\?roomId=\'\)\.concat\(room\.roomNumber\)\}\"[\s\S]*?calendar_month</span>\s*?</a>'
btn2_new = r'''<a href=\"${empty sessionScope.acc ? pageContext.request.contextPath.concat('/login.jsp?redirect=booking&roomId=').concat(room.roomNumber) : pageContext.request.contextPath.concat('/webapp/search.jsp?roomId=').concat(room.roomNumber)}\"
                                                class=\"flex-[1.5] py-4 rounded-2xl bg-gradient-to-r from-hotel-gold to-[#9c8258] text-white font-bold text-[11px] tracking-[0.2em] uppercase text-center flex items-center justify-center gap-2 transition-all duration-300 shadow-[0_10px_20px_-10px_rgba(184,154,108,0.5)] hover:shadow-[0_15px_25px_-10px_rgba(184,154,108,0.6)] hover:-translate-y-1\">
                                                Đặt Ngay <span
                                                    class=\"material-symbols-outlined text-[16px]\">calendar_month</span>
                                            </a>'''

text = re.sub(btn1_old, btn1_new, text)
text = re.sub(btn2_old, btn2_new, text)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(text)
print('Done format update!')
