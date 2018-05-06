# What is?


# Why?

# How?
1. Never stop the content
- Load song song tất cả các component.
- Không cho phép bất cứ script nào gây ra render-blocking (không sử dụng third party script)
- Cho phép sử dụng iframe 
2. Asset-independent layout
- HTML chỉ biết layout khi resource được load xong 
- AMP load layout trước khi resource được load - static layouting
- Có thể get toàn bộ layout bằng 1 http request
3. Inline, size-bound CSS
- Chỉ chấp nhận css inline (trong thẻ <style></style>), giảm số http requests về mức thấp nhất
- size < 50kb
→ Đòi hỏi lập trình viên cần có css-hygiene tốt
4. Efficient font triggering
- Web font có kích thuớc lớn, AMP sử dụng async js và inline style 
5. Minimize style and layput recalculations
- Các trang web sẽ cần tổ chức lại layout mỗi khi 1 resource được load, amp giảm thiểu bằng static layout.
6. GPU-accelerated animation
- Chuyển từ CPU sang xử lý tại GPU.
- Browser xử lý layout nhanh hơn bằng GPU.
7. Prioritize resource loading
- Lazy load images. ATF above the fold nhờ static layout.
- Resource sẽ được load muộn nhất khi có thể nhưng prefetch sẽ nhanh nhất có thể.
