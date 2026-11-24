# docker-nginx-demo

1. 靜態網頁客製化伺服器（入門：理解 Image 建置與 Port 映射）
專案內容：寫一個簡單的 HTML + CSS 個人名片或履歷網頁，透過 Nginx 伺服器對外提供服務。

練習重點：

撰寫第一個 Dockerfile（使用 FROM nginx:alpine）。

練習使用 COPY 指令把網頁檔案放進容器。

熟悉 docker build 打包與 docker run -p 對應連接埠。

完成標準：別人只要 clone 你的專案並執行一行 docker run，就能在瀏覽器看到你的網頁。