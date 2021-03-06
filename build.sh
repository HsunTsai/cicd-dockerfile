# 增加版本的指令
increment_version ()
{
  declare -a part=( ${1//\./ } )
  declare    new
  declare -i carry=1

  for (( CNTR=${#part[@]}-1; CNTR>=0; CNTR-=1 )); do
    len=${#part[CNTR]}
    new=$((part[CNTR]+carry))
    [ ${#new} -gt $len ] && carry=1 || carry=0
    [ $CNTR -gt 0 ] && part[CNTR]=${new: -len} || part[CNTR]=${new}
  done
  new="${part[*]}"
  echo -e "${new// /.}"
} 

# 讀取現在版本
value=$(<version)
# 現在版本+1
newVersion=$(increment_version $value)
echo update version to from $value to $newVersion

# 將現在版本寫入檔案
echo $newVersion > version

# 讀取該dockerfile的名字
dockerfileName=$(<name)

docker build -t $dockerfileName:$newVersion -t $dockerfileName:latest .
docker push $dockerfileName:$newVersion
docker push $dockerfileName:latest

# docker build -t dlri093/tomcat8-node10:$1 -t dlri093/tomcat8-node10:latest .
# docker push dlri093/tomcat8-node10