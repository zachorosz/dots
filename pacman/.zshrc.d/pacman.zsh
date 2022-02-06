# List orphaned packages
alias pacol="sudo pacman -Qqtd"
# Remove orphaned packages
alias pacor="sudo pacman -Rns $(pacman -Qqtd)"