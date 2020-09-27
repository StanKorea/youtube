####### RStan Installation #######
# Stan 설치 안내: https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
# Mac 사용자 C++ toolchain 설치:
# https://github.com/stan-dev/rstan/wiki/Installing-RStan-from-source-on-a-Mac

# 1. 기존 rstan이 설치되었는지 확인
library(rstan)
remove.packages("rstan")

# 2. "rstan" 패키지 설치
install.packages("rstan", repos = "https://cloud.r-project.org/", dependencies = TRUE)

# 3. C++ compiler Rtools 가 있는지 확인
pkgbuild::has_build_tools(debug = TRUE)
 
# 4. 없다면, Rtools 설치 진행
## "TRUE" 면 바로 # 7. library(rstan) 실행

# 5. 설치가 완료되면 R 종료 후 다시 실행

# 6. "# 3."을 다시 확인 
pkgbuild::has_build_tools(debug = TRUE) # TRUE 면 준비 완료!

# 7. 
library(rstan)
