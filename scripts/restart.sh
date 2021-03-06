#!/usr/bin/env bash
# Author: yulinzhihou <yulinzhihou@gmail.com>
# Forum:  https://gsgamesahre.com
# Project: https://github.com/yulinzhihou/gs_tl_env.git
# Date :  2021-02-01
# Notes:  GS_TL_Env for CentOS/RedHat 7+ Debian 10+ and Ubuntu 18+
# comment: 一键命令重启命令所有
# 颜色代码
if [ -f ./color.sh ]; then
  . /root/.tlgame/scripts/color.sh
else
  . /usr/local/bin/color
fi

while :; do
  echo
  echo -e "${CBLUE}正在进行重启操作，请选择以下选项中的一项：${CEND}"
  echo -e "\t${CGREEN}1${CEND}. 直接重启当前容器，如果有角色在线，建议下线！可能会造成数据丢失！！"
  echo -e "\t${CGREEN}0${CEND}. 退出！"
  read -e -p "请输入 : (默认 1 按回车) " option
  option=${option:-1}
  if [[ ! ${option} =~ ^[0-1]$ ]]; then
    echo -e "${CRED} 输入错误！请输入 0 或者 1 ${CEND}"
  else
    if [ ${option} == 1 ]; then
      for ((time = 10; time > 0; time--)); do
        echo -ne "\r在准备正行重启操作！！，剩余 ${CYELLOW}$time${CEND} 秒，可以在计时结束前，按 CTRL+C 退出！\r"
        sleep 1
      done
      cd ~/.tlgame && docker-compose restart
      if [ $? == 0 ]; then
        echo -e "${CBLUE} 服务端已经重启成功，如果需要重新开服，请运行【runtlbb】命令 ${CEND}"
      else
        echo -e "${CRED} 服务端已经重启失败！可能需要重装系统或者环境了！${CEND}"
      fi
      break
    elif [ ${option} == 0 ]; then
      break
    fi
  fi
done