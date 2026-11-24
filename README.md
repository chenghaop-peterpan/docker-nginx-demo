# 🐳 Docker Nginx 靜態網頁客製化伺服器

![Build Status](https://github.com/<你的GitHub帳號>/<專案名稱>/actions/workflows/deploy.yml/badge.svg)

這是一個 Docker 入門實戰練習專案，展示如何將自訂的 HTML/CSS 靜態網頁連同 Nginx 伺服器打包成輕量級的 Docker Image（基於 `nginx:alpine`），並透過 GitHub Actions 自動化建置與推送至 GitHub Container Registry (GHCR)。

---

## 📁 專案結構

```text
docker-nginx-demo/
├── .github/
│   └── workflows/
│       └── deploy.yml    # GitHub Actions 自動打包與推送設定
├── .dockerignore         # 排除不需要打包進 Image 的檔案
├── Dockerfile            # Docker 映像檔建置設定檔
├── index.html            # 網頁主體
├── style.css             # 網頁樣式
└── README.md             # 專案說明文件
```

---

## 🚀 快速開始與部署方式

### 方式 A：從本機原始碼建置與啟動（開發與測試）

1. **建置 Docker Image：**
   ```bash
   docker build -t my-portfolio:v1 .
   ```

2. **啟動容器（背景執行並將本機 Port 8080 對應至容器 Port 80）：**
   ```bash
   docker run -d -p 8080:80 --name web-test my-portfolio:v1
   ```
   > 啟動後請開啟瀏覽器前往：`http://localhost:8080`

3. **即時開發模式（Bind Mount 掛載本機目錄，修改網頁無需重新 Build）：**
   ```bash
   # Windows PowerShell
   docker run -d -p 8888:80 -v ${PWD}:/usr/share/nginx/html --name web-dev nginx:alpine

   # macOS / Linux
   docker run -d -p 8888:80 -v $(pwd):/usr/share/nginx/html --name web-dev nginx:alpine
   ```
   > 開啟 `http://localhost:8888`，修改本機 `index.html` 存檔後重新整理即可即時看到變化。

---

### 方式 B：從 GitHub Container Registry (GHCR) 直接部署

本專案已設定 GitHub Actions CI/CD 流程，每次推送到 `main` 分支時會自動建置最新 Image。在任何已安裝 Docker 的機器上，無需下載原始碼即可直接拉取並啟動：

```bash
docker run -d -p 8080:80 --name web-test ghcr.io/<你的GitHub帳號>/docker-nginx-demo:latest
```

---

## 🛠️ 常用 Docker 維運指令速查

### 1. 環境檢查與狀態監控 (Status & Monitoring)

* **查看運行中的容器與 Port 映射（加上 `-a` 可查看已停止的容器）：**
  ```bash
  docker ps -a
  ```
* **查看即時存取紀錄與錯誤日誌（按 `Ctrl + C` 離開）：**
  ```bash
  docker logs -f web-test
  ```
* **監控即時 CPU 與記憶體資源用量（按 `Ctrl + C` 離開）：**
  ```bash
  docker stats web-test
  ```
* **查看容器底層完整網路與掛載設定：**
  ```bash
  docker inspect web-test
  ```

### 2. 進入容器除錯 (Debugging)

* **進入容器內部終端機檢查檔案或設定：**
  ```bash
  docker exec -it web-test sh
  ```
  > 註：由於基底映像檔為輕量級 `alpine`，請使用 `sh` 而非 `bash`；輸入 `exit` 即可離開容器。

### 3. 停止與環境清理 (Stop & Cleanup)

* **僅停止容器（保留容器紀錄，之後可用 `docker start web-test` 重啟）：**
  ```bash
  docker stop web-test
  ```
* **強制停止並徹底刪除容器：**
  ```bash
  docker rm -f web-test
  ```
* **查看與刪除本機建立的 Image：**
  ```bash
  docker images
  docker rmi my-portfolio:v1
  ```
* **一鍵清理所有已停止的容器與無用快取（釋放硬碟空間）：**
  ```bash
  docker system prune -f
  ```

---

## 🧪 自我實作驗收清單

- [ ] **Port 映射驗證**：使用同一個 `my-portfolio:v1` 映像檔，額外啟動第二個容器 `web-test-2` 並映射至本機 `9090` Port（`docker run -d -p 9090:80 --name web-test-2 my-portfolio:v1`），確認 `8080` 與 `9090` 可同時運作。
- [ ] **無狀態（Stateless）特性驗證**：透過 `docker exec` 修改 `web-test` 內的 `index.html`，確認刪除容器（`docker rm -f web-test`）並重新啟動後，網頁會恢復成 Image 內的原始版本。
- [ ] **CI/CD 自動化驗證**：將程式碼 `git push` 至 GitHub `main` 分支，確認 **Actions** 執行成功且專案右側 **Packages** 出現最新打包的映像檔。