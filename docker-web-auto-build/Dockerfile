FROM dlri093/tomcat8-node10

# 強行修改DNS
# WORKDIR /etc
# RUN echo "nameserver 8.8.8.8" > resolv.conf.override

# 前往tomcate資料夾
WORKDIR /usr/local/tomcat

# 製作打包網頁的腳本
RUN echo "git clone \$1 \$2 -b \$3" > buildCode.sh
# 將resolve.conf複製出來 並增加8.8.8.8 再覆蓋回resolv.conf (因無法直接變動resolv.conf)
RUN echo "cp /etc/resolv.conf /etc/resolv.conf.override" >> buildCode.sh
RUN echo "sed -i '1i nameserver 8.8.8.8' resolv.conf.override" >> buildCode.sh
RUN echo "cp /etc/resolv.conf.override /etc/resolv.conf" >> buildCode.sh
RUN echo "cd \$2" >> buildCode.sh
RUN echo "npm install --silent" >> buildCode.sh
RUN echo "npm run deploy" >> buildCode.sh
RUN echo "mkdir /usr/local/tomcat/webapps/\$2" >> buildCode.sh
RUN echo "mv ./dist/* /usr/local/tomcat/webapps/\$2" >> buildCode.sh
RUN echo "/usr/local/tomcat/bin/startup.sh" >> buildCode.sh

# 外部輸入的變數(下方為預設數值)
ENV GIT_URL https://github.com/HsunTsai/react-startkit-domain-directory
ENV APP_NAME react-startkit-domain-directory
ENV BRANCH master

# 執行sh 透過外部參數執行下載原始碼及打包 並於執行後維持啟動狀態不關閉
CMD bash buildCode.sh $GIT_URL $APP_NAME $BRANCH && sleep infinity

# docker build -t dlri093/docker-web-auto-build:latest -t dlri093/docker-web-auto-build:0.0.1 .
# docker push dlri093/docker-web-auto-build
