# Shared shell helpers for dotfiles scripts.
#
# Source from another bash script:
#   source "$(dirname "${BASH_SOURCE[0]}")/_helpers.sh"
#
# Provides colors and four small loggers:
#   step    — blue arrow, section header (adds a leading blank line)
#   success — green check, completed step
#   warn    — yellow triangle, non-fatal warning
#   error   — red cross, prints message and exits 1

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

step()    { echo ""; echo -e "${BLUE}➜${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn()    { echo -e "${YELLOW}⚠${NC} $1"; }
error()   { echo -e "${RED}✗${NC} $1"; exit 1; }
