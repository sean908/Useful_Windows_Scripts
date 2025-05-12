<#
.DESCRIPTION
网络守护脚本（ICMP检测版）
#>
param (
    [string]$TargetIP = "223.5.5.5",
    [string]$NICName = "以太网",
    [string]$LogPath = "D:\network.log"
)

function Test-Network {
    param (
        [string]$Target,
        [int]$Timeout = 1000
    )
    try {
        $ping = New-Object System.Net.NetworkInformation.Ping
        $reply = $ping.Send($Target, $Timeout)
        return $reply.Status -eq "Success"
    } catch {
        return $false
    }
}

# 主程序（修正输出写法）
if (-not (Test-Network -Target $TargetIP)) {
    $msg = "[ERROR] 网络连接异常 $(Get-Date -Format 'HH:mm:ss')"
    Out-File -FilePath $LogPath -InputObject $msg -Append
    
    # 网卡操作保持不变
    Disable-NetAdapter -Name $NICName -Confirm:$false
    Start-Sleep -Seconds 3
    Enable-NetAdapter -Name $NICName -Confirm:$false
    
    "[INFO] 网卡已重置 $(Get-Date -Format 'HH:mm:ss')" | Out-File $LogPath -Append
} else {
    "[OK] 网络正常 $(Get-Date -Format 'HH:mm:ss')" | Out-File $LogPath -Append
}
