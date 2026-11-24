# 1. 選擇輕量級的官方 Nginx 映像檔作為基底 (Alpine Linux 版本體積只有約 40MB)
FROM nginx:alpine

# 2. 移除 Nginx 預設的歡迎頁面
RUN rm -rf /usr/share/nginx/html/*

# 3. 將本機的網頁檔案複製到容器內的 Nginx 網頁根目錄
COPY index.html style.css /usr/share/nginx/html/

# 4. 宣告容器運作時監聽的連接埠（說明文件性質，預設即為 80）
EXPOSE 80