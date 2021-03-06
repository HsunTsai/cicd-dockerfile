git clone $1
cd $2
npm install
npm run deploy
mv ./$2/dist /usr/local/tomcat/webapps/$2