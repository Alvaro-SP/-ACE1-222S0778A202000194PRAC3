
@echo off
echo %~dp0
git remote add all https://github.com/Alvaro-SP/-ACE1-222S0778A202000194PRAC3.git

SET /P NOMBRE=WRITE COMMIT:
git add .
git commit -m "%NOMBRE%"
git push
git push https://Alvaro-SP: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@github.com/Alvaro-SP/-ACE1-222S0778A202000194PRAC3.git
pause


