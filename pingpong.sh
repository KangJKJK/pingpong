#!/bin/bash

# 색깔 변수 정의
BOLD='\033[1m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[36m'
NC='\033[0m' # No Color

echo -e "${GREEN}Pingpong 노드 설치를 시작합니다.${NC}"
echo ""

command_exists() {
    command -v "$1" &> /dev/null
}

# 도커 설치 확인
echo -e "${BOLD}${CYAN}Docker 설치 확인 중...${NC}"
if ! command_exists docker; then
    echo -e "${RED}Docker가 설치되어 있지 않습니다. Docker를 설치하는 중입니다...${NC}"
    sudo apt update && sudo apt install -y curl net-tools
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    echo -e "${GREEN}Docker가 성공적으로 설치되었습니다.${NC}"
else
    echo -e "${GREEN}Docker가 이미 설치되어 있습니다.${NC}"
fi

# pingpong 패키지 설치
echo -e "${BOLD}${CYAN}pingpong 패키지 설치 중...${NC}"
wget https://pingpong-build.s3.ap-southeast-1.amazonaws.com/linux/latest/PINGPONG

# pingpong 노드 설정 안내
echo -e "${BOLD}${CYAN}pingpong 노드를 설정 중...${NC}"
echo -e "${YELLOW}해당사이트에 방문하세요${NC}"
echo -e "${YELLOW}https://app.pingpong.build/mining/devices${NC}"
echo -e "${YELLOW}Add device를 누른 후 Device key를 복사하세요.${NC}"

# 사용자로부터 Device key를 입력받음
read -p "Device key를 입력하세요: " DEVICE_KEY

# 패키지에 실행 권한을 부여하고 실행
chmod +x ./PINGPONG
./PINGPONG --key "$DEVICE_KEY"

echo -e "${GREEN}모든 작업이 완료되었습니다. 컨트롤+A+D로 스크린을 종료해주세요.${NC}"
echo -e "${GREEN}스크립트 작성자: https://t.me/kjkresearch${NC}"
