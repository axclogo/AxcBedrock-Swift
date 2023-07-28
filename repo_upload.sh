#!/bin/bash

#【配置】
new_version="1.0.1" # 这里设置要上传的版本号
pod_sources="https://github.com/CocoaPods/Specs" # 这里设置sources


#【入参】
SRCROOT=$(dirname $0) # 本文件目录
echo $SRCROOT
PROJECT_NAME=$1 # 项目名称

#【自动脚本】
# 设置基础变量
podspec_file=${PROJECT_NAME}.podspec
cd $SRCROOT # 目录切换
ls

# 先校验
echo "准备校验"
pod lib lint ${podspec_file} --allow-warnings --sources=${pod_sources} &
pod_lib_lint=$! # 同步执行该命令
wait $pod_lib_lint # 等待线程

echo "执行完毕"

## 开始处理版本号
#echo "备份原始文件：${podspec_file}"
#cp "$podspec_file" "$podspec_file.bak"
#podspec_bak_file=${podspec_file}.bak
#echo "备份文件：${podspec_bak_file}"
## 获取老版本号
#podspec_file_content=$(cat $podspec_file)
#pattern="'([^']+)' # Auto Version"
#old_version=""
#if [[ $podspec_file_content =~ $pattern ]]; then
#   old_version="${BASH_REMATCH[1]}"
#   echo "提取的版本号为：$old_version"
#else
#   echo "无法提取版本号，请检查podspec文件中的格式"
#   exit 1
#fi
#echo "准备修改版本号${old_version} >>> ${new_version}"
#old_content="= '${old_version}' # Auto Version"
#new_content="= '${new_version}' # Auto Version"
#
## 替换文件内容
#sed "s/${old_content}/${new_content}/g" "$podspec_bak_file" > "$podspec_file"
#echo "文件修改完成，正在提交git..."
## git同步
#echo '正在切换到远端分支'
#git checkout master
#git branch
#echo '同步远端分支'
#git config pull.rebase true
#git pull
#echo "检查文件状态"
#git status -s
#echo "提交变更文件"
#git add $podspec_file # .podspec变更
#git commit -m "[repo upload]-repo上传$new_version"
#echo '同步远端分支'
#git config pull.rebase true
#git pull
#echo '推送远端分支'
#git push
#echo "打标签 - [$new_version]"
#git tag $new_version
#echo '推送到远端标签'
#git push origin $new_version
#
#echo '准备上传至cocoapods repo'
#pod repo push cocoapods ${podspec_file} --allow-warnings --sources=${pod_sources}
