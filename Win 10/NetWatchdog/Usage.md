
# 使用场景
用来处理开机时无网络连接, 重启指定网络适配器

# 用法
1. 保存脚本文件到任意位置
2. 脚本所在目录赋权
    ```powershell
    icacls "C:\Scripts" /grant "SYSTEM:(OI)(CI)F"
    ```
3. 执行脚本
4. [可选] 开机启动  
    参照 **runOnStartup.ps1**
