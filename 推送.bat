@echo off
chcp 65001 >nul

set max_retry=100
set delay=10

echo 开始尝试推送代码...

for /l %%i in (1,1,%max_retry%) do (
    echo.
    echo 尝试 %%i/%max_retry%...
    git push
    
    if not errorlevel 1 (
        echo.
        echo 推送成功！
        pause
        exit /b 0
    )
    
    if %%i lss %max_retry% (
        echo 等待 %delay% 秒后重试...
        timeout /t %delay% /nobreak >nul
    )
)

echo.
echo 推送失败，已尝试 %max_retry% 次
pause
exit /b 1