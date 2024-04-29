#!/bin/bash

# 安装 Rust 的函数
install_rust() {
    # 安装 Rust 的命令在这里
    echo "正在安装 Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    read -p "按回车键返回菜单..." enter_key
    install_environment_menu
}

# 安装 Solana 的函数
install_solana() {
    # 安装 Solana 的命令在这里
    echo "正在安装 Solana..."
    sh -c "$(curl -sSfL https://release.solana.com/stable/install)"
    read -p "按回车键返回菜单..." enter_key
    install_environment_menu
}

# 设置 Solana 环境变量的函数
set_env_variables() {
    # 设置 Solana 环境变量的命令在这里
    echo "正在设置 Solana 的环境变量..."
    export PATH="/root/.local/share/solana/install/active_release/bin:$PATH"
    read -p "按回车键返回菜单..." enter_key
    install_environment_menu
}

# 设置 Solana 环境变量的函数
reload_the_Bash_configuration_file() {
    echo "重新加载 Bash 配置文件..."
    source ~/.bashrc
    read -p "按回车键返回菜单..." enter_key
    install_environment_menu
}

# 检查 Rust Solana 是否成功安装的函数
check_solana_installation() {
    # 检查 Solana 安装的命令在这里
    echo "正在检查 Rust Solana 是否安装成功..."
    rustc --version
    solana --version
    read -p "按回车键返回菜单..." enter_key
    install_environment_menu
}


# 创建默认 Cargo 项目函数
create_default_cargo_project() {
    echo "正在创建默认 Cargo 项目..."
    cargo new my_project
    echo "需要手动修改Cargo.toml 文件中添加 Solana 客户端和 SDK 的依赖。"
    echo "需要手动修改Rust 代码到项目的 src/main.rs 文件中。"
    echo "文件代码链接https://gist.github.com/jacklevin74/b3b3709aa3e66eab8f762c0fb4de53ff"
    read -p "按回车键返回菜单..." enter_key
    create_cargo_project
}

# 创建群友修改 Cargo 项目函数
create_modified_cargo_project() {
    echo "正在创建群友修改 Cargo 项目..."
    git clone https://github.com/espoir1989/hash.git my_project_temp
    rsync -av my_project_temp/ my_project/
    rm -rf my_project_temp
    echo "代码已复制到 my_project 文件夹并替换原有内容。"
    read -p "按回车键返回菜单..." enter_key
    create_cargo_project
}


# 执行构建程序函数
execute_build_program() {
    echo "进入my_project文件夹..."
    cd my_project
    echo "正在执行构建程序..."
    cargo build
    echo "构建程序完成。"
    read -p "按回车键返回菜单..." enter_key
    building_the_program
}

# 安装 gcc 函数
install_gcc() {
    echo "进入my_project文件夹..."
    cd my_project
    echo "正在安装 gcc..."
    sudo apt install gcc
    echo "gcc安装完成。"
    read -p "按回车键返回菜单..." enter_key
    building_the_program
}

# 更新软件包函数
update_packages() {
    echo "进入my_project文件夹..."
    cd my_project
    echo "正在更新软件包..."
    sudo apt update && sudo apt upgrade -y
    echo "软件包更新完成。"
    read -p "按回车键返回菜单..." enter_key
    building_the_program
}
# 主菜单函数
main_menu() {
    clear
    echo "======= Mr.Huang ======="
    echo "========= 菜单 ========="
    echo "1. 安装环境"
    echo "2. 创建 Cargo 项目"
    echo "3. 构建程序"
    echo "4. 批量导入钱包"
    echo "5. 一键后台运行"
    echo "6. 查看所有运行会话"
    echo "7. 一键结束所有运行会话"
    echo "8. 退出菜单"
    read -p "请输入您的选择： " choice
    case $choice in
        1) install_environment_menu ;;
        2) create_cargo_project ;;
        3) building_the_program ;;
        4) import_wallets ;;
        5) one_click_background_run ;;
        6) view_running_sessions ;;
        7) end_all_running_sessions ;;
        8) echo "退出菜单"; exit 0 ;;  # 退出菜单
        *)
            echo "无效选项，请重新选择"
            read -p "按回车键返回菜单..." enter_key
            main_menu ;;  # 返回主菜单
    esac
}

# 安装环境子菜单函数
install_environment_menu() {
    clear
    echo "=== 安装环境 ==="
    echo "1. 安装 Rust"
    echo "2. 安装 Solana"
    echo "3. 设置 Solana 环境变量"
    echo "4. 重新加载 Bash 配置文件"
    echo "5. 检查 Solana 安装情况"
    echo "6. 返回主菜单"
    read -p "请输入您的选择： " env_choice
    case $env_choice in
        1) install_rust ;;
        2) install_solana ;;
        3) set_env_variables ;;
        4) reload_the_Bash_configuration_file ;;
        5) check_solana_installation ;;
        6) main_menu ;;
        *) echo "无效的选择，请重试。" 
        read -p "按回车键返回菜单..." enter_key
            install_environment_menu ;;  # 返回安装环境子菜单
    esac
}

# 其他菜单选项的函数占位符
# 创建 Cargo 项目函数
create_cargo_project() {
    clear
    echo "=== 创建 Cargo 项目 ==="
    echo "1. 创建默认 Cargo 项目"
    echo "2. 创建群友修改 Cargo 项目"
    echo "3. 返回主菜单"
    read -p "请输入您的选择： " cargo_choice
    case $cargo_choice in
        1) create_default_cargo_project ;;
        2) create_modified_cargo_project ;;
        3) main_menu ;;
        *) echo "无效的选择，请重试。" 
           read -p "按回车键返回菜单..." enter_key
           create_cargo_project ;;  # 返回创建 Cargo 项目子菜单
    esac
}

# 构建程序函数
building_the_program() {
    clear
    echo "=== 构建程序 ==="
    echo "1. 执行构建程序"
    echo "2. 安装 gcc"
    echo "3. 更新软件包"
    echo "4. 返回主菜单"
    read -p "请输入您的选择： " build_choice
    case $build_choice in
        1) execute_build_program ;;
        2) install_gcc ;;
        3) update_packages ;;
        4) main_menu ;;
        *) echo "无效的选择，请重试。" 
           read -p "按回车键返回菜单..." enter_key
           building_the_program ;;  # 返回构建程序子菜单
    esac
}


# 导入钱包函数
import_wallets() {
    echo "正在进行批量导入钱包..."
    read -p "请输入起始的钱包 ID：" start_id
    if [ -z "$start_id" ]; then
        echo "起始的钱包 ID 不能为空，请重新输入"
        import_wallets
        return
    fi

    read -p "请输入要创建的钱包数量：" wallet_count
    if [ -z "$wallet_count" ]; then
        echo "要创建的钱包数量不能为空，请重新输入"
        import_wallets
        return
    fi

    for ((id = start_id; id < start_id + wallet_count; id++)); do
        read -p "请输入钱包 ID $id 的内容：" wallet_content
        if [ -z "$wallet_content" ]; then
            echo "钱包内容不能为空，请重新输入"
            ((id--))  # 回退一步，重新输入该钱包内容
            continue
        fi
        echo "$wallet_content" > ~/.config/solana/id$id.json
        echo "钱包 ID $id 已成功导入并保存到 ~/.config/solana/id$id.json"
    done
}

# 一键后台运行函数
one_click_background_run() {
    echo "进入my_project文件夹..."
    cd my_project
    echo "正在进行一键后台运行..."
    screen -S my_project_session -dm bash -c 'while true; do cargo run; done'
    echo "已启动后台运行程序。"
    read -p "按回车键返回菜单..." enter_key
    main_menu
}

view_running_sessions() {
    echo "正在查看所有运行会话..."
    screen -list
    read -p "按回车键返回菜单..." enter_key
    main_menu
}

end_all_running_sessions() {
    echo "正在结束所有运行会话..."
    screen -ls | grep Detached | cut -d. -f1 | awk '{print $1}' | xargs -I {} screen -X -S {} quit
    echo "已结束所有运行会话..."
    read -p "按回车键返回菜单..." enter_key
    main_menu
}

# 开始主菜单
main_menu
