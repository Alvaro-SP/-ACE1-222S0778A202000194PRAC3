
@echo off
echo %~dp0
git remote add all https://github.com/Alvaro-SP/-ACE1-222S0778A202000194PRAC3.git

SET /P NOMBRE=WRITE COMMIT:
git add .
git commit -m "%NOMBRE%"
git push
git push https://Alvaro-SP:QONUnDpelSsf4gjaakj4YP904QVM9MsCdA3NBHRFAes@github.com/Alvaro-SP/-ACE1-222S0778A202000194PRAC3.git
pause


