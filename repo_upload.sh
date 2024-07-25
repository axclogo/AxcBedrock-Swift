#!/bin/bash

#【配置】
new_version="1.1.5" # 这里设置要上传的版本号
pod_sources="https://github.com/CocoaPods/Specs" # 这里设置sources


#【入参】
# 设置基础变量
src_root_dir=$(dirname $0) # 本文件目录
project_name="" # 项目名称

#【开始】
cd $src_root_dir # 目录切换
ls

while true; do
read -p "Target: [FrameworkMaker]是否已经通过编译？[y/n]：" answer
    if [[ $answer == "y" || $answer == "Y" ]]; then
        echo "执行下一步"
        break  # 结束循环
    elif [[ $answer == "n" || $answer == "N" ]]; then
        echo "退出"
        exit
    else
        echo "无效的输入"
    fi
done

#【校验】
# 查找所有的.podspec文件
podspec_files=( $(find . -type f -name "*.podspec") )
# 获取文件数量
file_count=${#podspec_files[@]}
# 如果只有一个文件，则获取文件名
if [ "$file_count" -eq 1 ]; then
    file_name=${podspec_files[0]##*/}
    file_name=${file_name%.*}
    project_name=$file_name
    echo "要上传的项目名：[$project_name]"
else # 如果没有文件或多个，则报错返回
    echo "❌错误：未找到或存在多个.podspec文件"
    exit 1
fi

# 检查设置的版本是否和远端的tag列表重复
if git rev-parse $new_version >/dev/null 2>&1; then
  echo "❌错误！version $new_version 已存在于本地仓库！"
  exit 1
fi

podspec_file=${project_name}.podspec

# 设置信号，当接收来自pod命令失败时自身也退出
trap "exit" ERR

# 先校验
echo "准备校验"
pod lib lint ${podspec_file} --allow-warnings --sources=${pod_sources} --verbose &
pod_lib_lint=$! # 同步执行该命令
wait $pod_lib_lint # 等待线程

echo "🍺 repo校验成功！🎉🎉🎉🎉🎉🎉"

# git同步
echo '正在切换到远端分支'
git checkout master
git branch
echo '同步远端分支'
git config pull.rebase true
git pull
# ===================
# 开始处理版本号
echo "备份原始文件：${podspec_file}"
cp "$podspec_file" "$podspec_file.bak"
podspec_bak_file=${podspec_file}.bak
echo "备份文件：${podspec_bak_file}"
# 获取老版本号
podspec_file_content=$(cat $podspec_file)
pattern="'([^']+)' # Auto Version"
old_version=""
if [[ $podspec_file_content =~ $pattern ]]; then
   old_version="${BASH_REMATCH[1]}"
   echo "提取的版本号为：$old_version"
else
   echo "无法提取版本号，请检查podspec文件中的格式"
   exit 1
fi
echo "准备修改版本号${old_version} >>> ${new_version}"
old_content="= '${old_version}' # Auto Version"
new_content="= '${new_version}' # Auto Version"
sed "s/${old_content}/${new_content}/g" "$podspec_bak_file" > "$podspec_file"
# ===================
echo "检查文件状态"
git status -s
# 如果有文件变动，则提交掉
if [ -n "$(git status --porcelain)" ]; then
    echo "检测到变更，正在提交变更文件"
    git add -A
    git commit -m "[repo upload]-$new_version"
    echo '同步远端分支'
    git config pull.rebase true
    git pull
    echo '推送远端分支'
    git push
fi

echo "打标签 - [$new_version]"
git tag $new_version
echo '推送到远端标签'
git push origin $new_version

echo '准备上传至cocoapods repo'
pod trunk push ${podspec_file} --allow-warnings &
pod_repo_push=$! # 同步执行该命令
wait $pod_repo_push # 等待线程

echo "🎉cocoapods repo推送完成！"
