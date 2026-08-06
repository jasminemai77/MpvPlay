# v0.6 Windows 手动验收记录

本清单用于真实 Windows 桌面验收，自动化测试不能替代系统媒体面板、硬件媒体键和托盘视觉行为验证。

## 环境

- Windows：当前桌面环境；系统面板/硬件键逐项验收尚未完成
- Flutter/Dart：Flutter 3.44.8 / Dart 3.12.2
- Application：0.6.0+7
- Test time：2026-08-06（自动启动/退出检查）
- Release：`apps/player_app/build/windows/x64/runner/Release`
- Release exe SHA-256：`D9DC245FE1DC727071117D9B42EB1BD68CBAC93CFE50CD6C3F3B9AC1C01CE60F`

- Windows 版本：
- Flutter/Dart 版本：
- 应用版本：0.6.0+7
- 测试时间：
- 测试曲目/文件：
- Release 包路径：

每项填写 `PASS`、`FAIL` 或 `NOT_SUPPORTED`，并附截图或文字证据。未执行项目不得标记 PASS。

## SMTC 系统媒体面板

| 检查项 | 结果 | 证据/备注 |
|---|---|---|
| 应用启动且可播放 |  |  |
| 系统媒体面板显示 |  |  |
| 标题、艺术家、专辑正确 |  |  |
| 封面显示正确（若曲目有封面） |  |  |
| Play/Pause 有效 |  |  |
| Previous/Next 有效 |  |  |
| Stop 有效 |  |  |
| 键盘媒体键在窗口失焦时有效 |  |  |
| 耳机/硬件媒体键有效 |  |  |
| 播放状态随 Runtime 刷新 |  |  |
| 时间轴 position/duration 正确 |  |  |
| 系统 Seek 明确记录为 `NOT_SUPPORTED`（当前 SMTC 适配器不产生 Seek 事件） |  |  |

## 托盘与窗口生命周期

| 检查项 | 结果 | 证据/备注 |
|---|---|---|
| 托盘图标存在 |  |  |
| 托盘标题随当前曲目更新 |  |  |
| 托盘 Play/Pause 文案动态变化 |  |  |
| Previous/Next 有效 |  |  |
| Show 显示并激活窗口 |  |  |
| Hide 隐藏窗口但播放继续 |  |  |
| `hideToTray`：窗口关闭后进入托盘且可通过 Show 恢复 |  |  |
| `exitApplication`：窗口关闭后进程结束 |  |  |
| Tray Quit 后进程真正结束 |  |  |
| 应用重新启动后不会残留幽灵托盘图标 |  |  |

## 故障降级与证据

记录 SMTC、Tray 或 Window 初始化失败时的日志/行为：播放主体应仍可启动；Tray 不可用时 `hideToTray` 应回退为退出。记录重复 Quit、窗口关闭与 Tray Quit 同时触发时进程只退出一次。

最终将本文件中的结果复制到 v0.6 测试报告，并保留截图、日志和 Release 包校验信息。
