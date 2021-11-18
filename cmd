#!/usr/bin/env bash

if ! [ -x "$(command -v docker-compose)" ]; then
  shopt -s expand_aliases
  alias docker-compose='docker compose'
fi

UNAMEOUT="$(uname -s)"

WHITE='\033[1;37m'
NC='\033[0m'

# Verify operating system is supported...
case "${UNAMEOUT}" in
Linux*) MACHINE=linux ;;
Darwin*) MACHINE=mac ;;
*) MACHINE="UNKNOWN" ;;
esac

if [ "$MACHINE" == "UNKNOWN" ]; then
  echo "Unsupported operating system [$(uname -s)]. Extractor command supports macOS, Linux, and Windows (WSL2)." >&2

  exit 1
fi

# Function that outputs Sail is not running...
function extractor_is_not_running {
  echo -e "${WHITE}Extractor is not running.${NC}" >&2
  echo "" >&2
  echo -e "${WHITE}You may Extractor using the following commands:${NC} './extractor up -d'" >&2

  exit 1
}

export APP_SERVICE=${APP_SERVICE:-"laravel.test"}

if [ -z "$EXTRACTOR_SKIP_CHECKS" ]; then
  # Ensure that Docker is running...
  if ! docker info >/dev/null 2>&1; then
    echo -e "${WHITE}Docker is not running.${NC}" >&2

    exit 1
  fi

  # Determine if Sail is currently up...
  PSRESULT="$(docker-compose ps -q)"
  if docker-compose ps | grep $APP_SERVICE | grep 'Exit'; then
    echo -e "${WHITE}Shutting down old Extractor processes...${NC}" >&2

    docker-compose down >/dev/null 2>&1

    EXEC="no"
  elif [ -n "$PSRESULT" ]; then
    EXEC="yes"
  else
    EXEC="no"
  fi
else
  EXEC="yes"
fi

if [ $# -gt 0 ]; then
  # Proxy PHP commands to the "php" binary on the application container...
  if [ "$1" == "install" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
      docker-compose exec \
        "$APP_SERVICE" \
        composer install
      docker-compose exec \
        "$APP_SERVICE" \
        yarn install
    else
      extractor_is_not_running
    fi

  # Proxy PHP commands to the "php" binary on the application container...
  elif [ "$1" == "php" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
      docker-compose exec \
        "$APP_SERVICE" \
        php "$@"
    else
      extractor_is_not_running
    fi

  # Proxy Composer commands to the "composer" binary on the application container...
  elif [ "$1" == "composer" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
      docker-compose exec -T \
        "$APP_SERVICE" \
        composer "$@"
    else
      extractor_is_not_running
    fi

  # Proxy Node commands to the "node" binary on the application container...
  elif [ "$1" == "node" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
      docker-compose exec \
        "$APP_SERVICE" \
        node "$@"
    else
      extractor_is_not_running
    fi

  # Proxy NPM commands to the "npm" binary on the application container...
  elif [ "$1" == "npm" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
      docker-compose exec \
        "$APP_SERVICE" \
        npm "$@"
    else
      extractor_is_not_running
    fi

  # Proxy NPX commands to the "npx" binary on the application container...
  elif [ "$1" == "npx" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
      docker-compose exec -T \
        "$APP_SERVICE" \
        npx "$@"
    else
      extractor_is_not_running
    fi

  # Proxy YARN commands to the "yarn" binary on the application container...
  elif [ "$1" == "yarn" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
      docker-compose exec \
        "$APP_SERVICE" \
        yarn "$@"
    else
      extractor_is_not_running
    fi

    # Initiate a MySQL CLI terminal session within the "mysql" container...
    # Initiate a Bash shell within the application container...
  elif [ "$1" == "shell" ] || [ "$1" == "bash" ]; then
    shift 1

    if [ "$EXEC" == "yes" ]; then
      docker-compose exec \
        "$APP_SERVICE" \
        bash "$@"
    else
      extractor_is_not_running
    fi

    # Initiate a Redis CLI terminal session within the "redis" container...
  else
    docker-compose "$@"
  fi
else
  docker-compose ps
fi
