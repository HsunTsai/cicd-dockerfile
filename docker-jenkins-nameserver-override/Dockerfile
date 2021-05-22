FROM jenkins/jenkins:2.281
USER root

# 強行修改DNS
WORKDIR /etc
RUN echo "nameserver 8.8.8.8" > resolv.conf.override

# 覆蓋nameserver
RUN echo "cp /etc/resolv.conf.override /etc/resolv.conf" > buildCode.sh
RUN echo "jenkins.sh" >> buildCode.sh

USER jenkins

# 執行sh 透過外部參數執行下載原始碼及打包 並於執行後維持啟動狀態不關閉
CMD bash -x buildCode.sh && sleep infinity

