#!/bin/bash

# ════════════════════════════════════════════════════════════════════════════════
# 🐧 LINUX POST-INSTALL SETUP SCRIPT v2.2
# ════════════════════════════════════════════════════════════════════════════════
# Autor: JotaHume - https://jotahumesitio.space
# Uso: curl -sSL https://jotahumesitio.space/setup.sh | bash
# ════════════════════════════════════════════════════════════════════════════════

# Colores y estilos
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'

# Símbolos
CHECK="✅"
CROSS="❌"
ROCKET="🚀"
GEAR="⚙️"
PACKAGE="📦"
DESKTOP="🖥️"
DRIVER="🔧"
FIRE="🔥"
STAR="⭐"
ARROW="➤"

# Variables globales
DISTRO=""
PACKAGE_MANAGER=""
INSTALL_CMD=""
UPDATE_CMD=""
LOG_FILE="/tmp/linux_setup.log"

print_banner() {
    clear
    echo -e "${CYAN}${BOLD}"
    cat << 'BANNER'
╔══════════════════════════════════════════════════════════════════════╗
║                                                                      ║
║    🐧 LINUX POST-INSTALL CONFIGURATION WIZARD 🐧                    ║
║                                                                      ║
║    ┌─────────────────────────────────────────────────────────┐      ║
║    │  Configura tu sistema Linux de manera fácil y rápida   │      ║
║    │  ✨ Instala drivers, aplicaciones y entornos          │      ║
║    │  🚀 Automatizado y compatible con múltiples distros   │      ║
║    └─────────────────────────────────────────────────────────┘      ║
║                                                                      ║
║    📡 https://jotahumesitio.space/setup.sh                          ║
╚══════════════════════════════════════════════════════════════════════╝
BANNER
    echo -e "${NC}"
    echo -e "${DIM}v2.2 - Script de configuración post-instalación by JotaHume${NC}"
    echo ""
}

print_section() {
    echo -e "\n${BOLD}${BLUE}╔══════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}${BLUE}║${NC} ${WHITE}${BOLD}$1${NC}"
    echo -e "${BOLD}${BLUE}╚══════════════════════════════════════════════════════════════════════╝${NC}\n"
}

print_step() {
    echo -e "${CYAN}${ARROW}${NC} ${BOLD}$1${NC}"
}

print_success() {
    echo -e "${GREEN}${CHECK}${NC} $1"
}

print_error() {
    echo -e "${RED}${CROSS}${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠️${NC} $1"
}

log_action() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "Este script no debe ejecutarse como root. Usa tu usuario normal."
        exit 1
    fi
}

detect_distro() {
    print_step "Detectando distribución Linux..."
    
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
    elif type lsb_release >/dev/null 2>&1; then
        DISTRO=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
    else
        print_error "No se pudo detectar la distribución"
        exit 1
    fi

    case $DISTRO in
        ubuntu|debian|linuxmint|pop|elementary)
            PACKAGE_MANAGER="apt"
            INSTALL_CMD="sudo apt install -y"
            UPDATE_CMD="sudo apt update && sudo apt upgrade -y"
            ;;
        fedora|rhel|centos)
            PACKAGE_MANAGER="dnf"
            INSTALL_CMD="sudo dnf install -y"
            UPDATE_CMD="sudo dnf update -y"
            ;;
        arch|manjaro|endeavouros)
            PACKAGE_MANAGER="pacman"
            INSTALL_CMD="sudo pacman -S --noconfirm"
            UPDATE_CMD="sudo pacman -Syu --noconfirm"
            ;;
        opensuse*)
            PACKAGE_MANAGER="zypper"
            INSTALL_CMD="sudo zypper install -y"
            UPDATE_CMD="sudo zypper update -y"
            ;;
        *)
            print_error "Distribución no soportada: $DISTRO"
            exit 1
            ;;
    esac

    print_success "Distribución detectada: ${BOLD}${GREEN}$DISTRO${NC} (usando $PACKAGE_MANAGER)"
    log_action "Distribución detectada: $DISTRO"
}

show_menu() {
    echo -e "${BOLD}${WHITE}¿Qué quieres configurar hoy?${NC}\n"
    
    echo -e "${YELLOW}${FIRE} ESENCIALES${NC}"
    echo -e "  ${BOLD}1)${NC} ${GEAR} Actualizar sistema completo"
    echo -e "  ${BOLD}2)${NC} ${DRIVER} Instalar drivers de hardware"
    echo -e "  ${BOLD}3)${NC} ${PACKAGE} Instalar aplicaciones básicas"
    echo ""
    
    echo -e "${PURPLE}${STAR} APLICACIONES POPULARES${NC}"
    echo -e "  ${BOLD}4)${NC} 🌐 Navegadores (Chrome, Firefox, Brave)"
    echo -e "  ${BOLD}5)${NC} 💬 Comunicación (Discord, Slack, Telegram)"
    echo -e "  ${BOLD}6)${NC} 🎵 Multimedia (VLC, Spotify, OBS)"
    echo -e "  ${BOLD}7)${NC} 🎮 Gaming (Steam, Lutris)"
    echo -e "  ${BOLD}8)${NC} 💻 Desarrollo (VSCode, Git, Docker)"
    echo ""
    
    echo -e "${BLUE}${DESKTOP} ENTORNOS DE ESCRITORIO${NC}"
    echo -e "  ${BOLD}9)${NC} 🎨 GNOME y extensiones"
    echo -e "  ${BOLD}10)${NC} 🔧 KDE Plasma"
    echo -e "  ${BOLD}11)${NC} ⚡ XFCE"
    echo -e "  ${BOLD}12)${NC} 🌿 MATE"
    echo ""
    
    echo -e "${GREEN}${ROCKET} CONFIGURACIÓN AVANZADA${NC}"
    echo -e "  ${BOLD}13)${NC} 🔐 Configurar Flatpak/Snap"
    echo -e "  ${BOLD}14)${NC} 🛡️ Herramientas de seguridad"
    echo -e "  ${BOLD}15)${NC} 📋 Suite de oficina"
    echo -e "  ${BOLD}16)${NC} 🎨 Software de diseño"
    echo -e "  ${BOLD}17)${NC} 🖥️ Herramientas de sistema"
    echo -e "  ${BOLD}18)${NC} 🌐 Red y VPN"
    echo -e "  ${BOLD}19)${NC} 🔧 Temas y personalización"
    echo -e "  ${BOLD}20)${NC} 🎯 Setup completo (automático)"
    echo ""
    
    echo -e "${RED}${ROCKET} OPCIONES ESPECIALES${NC}"
    echo -e "  ${BOLD}21)${NC} 📊 Información del sistema"
    echo -e "  ${BOLD}22)${NC} 🧹 Limpieza del sistema"
    echo -e "  ${BOLD}23)${NC} 💾 Crear punto de restauración"
    echo ""
    
    echo -e "  ${BOLD}0)${NC} 🚪 Salir"
    echo ""
}

update_system() {
    print_section "🔄 ACTUALIZANDO SISTEMA"
    print_step "Actualizando repositorios y paquetes..."
    $UPDATE_CMD
    print_success "Sistema actualizado correctamente"
    log_action "Sistema actualizado"
}

install_drivers() {
    print_section "🔧 INSTALANDO DRIVERS DE HARDWARE"
    
    case $PACKAGE_MANAGER in
        apt)
            print_step "Instalando drivers adicionales..."
            sudo ubuntu-drivers autoinstall 2>/dev/null || true
            $INSTALL_CMD linux-firmware 2>/dev/null || true
            ;;
        dnf)
            print_step "Habilitando repositorios RPM Fusion..."
            sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 2>/dev/null || true
            ;;
        pacman)
            print_step "Instalando drivers para Arch Linux..."
            $INSTALL_CMD linux-firmware mesa xf86-video-amdgpu nvidia 2>/dev/null || true
            ;;
    esac
    
    print_success "Drivers instalados (reinicio recomendado)"
    log_action "Drivers instalados"
}

install_basic_apps() {
    print_section "📦 INSTALANDO APLICACIONES BÁSICAS"
    
    local apps=""
    case $PACKAGE_MANAGER in
        apt)
            apps="curl wget git vim neofetch htop tree unzip p7zip-full"
            ;;
        dnf)
            apps="curl wget git vim neofetch htop tree unzip p7zip"
            ;;
        pacman)
            apps="curl wget git vim neofetch htop tree unzip p7zip base-devel"
            ;;
    esac
    
    print_step "Instalando herramientas esenciales..."
    $INSTALL_CMD $apps
    print_success "Aplicaciones básicas instaladas"
    log_action "Aplicaciones básicas instaladas"
}

install_browsers() {
    print_section "🌐 INSTALANDO NAVEGADORES"
    
    case $PACKAGE_MANAGER in
        apt)
            print_step "Instalando Firefox..."
            $INSTALL_CMD firefox
            ;;
        dnf)
            print_step "Instalando Firefox..."
            $INSTALL_CMD firefox
            ;;
        pacman)
            print_step "Instalando Firefox..."
            $INSTALL_CMD firefox
            ;;
    esac
    
    print_success "Navegadores instalados"
    log_action "Navegadores instalados"
}

install_communication() {
    print_section "💬 INSTALANDO APPS DE COMUNICACIÓN"
    
    case $PACKAGE_MANAGER in
        apt)
            $INSTALL_CMD telegram-desktop
            ;;
        dnf)
            $INSTALL_CMD telegram-desktop
            ;;
        pacman)
            $INSTALL_CMD telegram-desktop discord
            ;;
    esac
    
    print_success "Aplicaciones de comunicación instaladas"
    log_action "Apps de comunicación instaladas"
}

install_multimedia() {
    print_section "🎵 INSTALANDO APLICACIONES MULTIMEDIA"
    
    case $PACKAGE_MANAGER in
        apt)
            $INSTALL_CMD vlc audacity gimp
            ;;
        dnf)
            $INSTALL_CMD vlc audacity gimp
            ;;
        pacman)
            $INSTALL_CMD vlc audacity gimp obs-studio
            ;;
    esac
    
    print_success "Aplicaciones multimedia instaladas"
    log_action "Apps multimedia instaladas"
}

install_gaming() {
    print_section "🎮 CONFIGURANDO ENTORNO GAMING"
    
    case $PACKAGE_MANAGER in
        apt)
            $INSTALL_CMD steam
            ;;
        dnf)
            $INSTALL_CMD steam
            ;;
        pacman)
            $INSTALL_CMD steam lutris
            ;;
    esac
    
    print_success "Entorno gaming configurado"
    log_action "Gaming setup completado"
}

install_development() {
    print_section "💻 INSTALANDO HERRAMIENTAS DE DESARROLLO"
    
    case $PACKAGE_MANAGER in
        apt)
            $INSTALL_CMD nodejs npm python3-pip
            ;;
        dnf)
            $INSTALL_CMD nodejs npm python3-pip
            ;;
        pacman)
            $INSTALL_CMD nodejs npm python-pip docker
            ;;
    esac
    
    print_success "Herramientas de desarrollo instaladas"
    log_action "Dev tools instaladas"
}

install_desktop_environment() {
    local de=$1
    print_section "🖥️ INSTALANDO ENTORNO DE ESCRITORIO: $de"
    
    case $de in
        "gnome")
            case $PACKAGE_MANAGER in
                apt) $INSTALL_CMD ubuntu-gnome-desktop ;;
                dnf) $INSTALL_CMD @gnome-desktop-environment ;;
                pacman) $INSTALL_CMD gnome gnome-extra ;;
            esac
            ;;
        "kde")
            case $PACKAGE_MANAGER in
                apt) $INSTALL_CMD kde-plasma-desktop ;;
                dnf) $INSTALL_CMD @kde-desktop-environment ;;
                pacman) $INSTALL_CMD plasma kde-applications ;;
            esac
            ;;
        "xfce")
            case $PACKAGE_MANAGER in
                apt) $INSTALL_CMD xfce4 ;;
                dnf) $INSTALL_CMD @xfce-desktop-environment ;;
                pacman) $INSTALL_CMD xfce4 xfce4-goodies ;;
            esac
            ;;
        "mate")
            case $PACKAGE_MANAGER in
                apt) $INSTALL_CMD ubuntu-mate-desktop ;;
                dnf) $INSTALL_CMD @mate-desktop-environment ;;
                pacman) $INSTALL_CMD mate mate-extra ;;
            esac
            ;;
    esac
    
    print_success "Entorno $de instalado"
    log_action "Desktop Environment $de instalado"
}

setup_flatpak() {
    print_section "🔐 CONFIGURANDO FLATPAK"
    
    case $PACKAGE_MANAGER in
        apt|dnf|pacman)
            $INSTALL_CMD flatpak
            ;;
    esac
    
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo 2>/dev/null || true
    print_success "Flatpak configurado"
    log_action "Flatpak configurado"
}

install_security_tools() {
    print_section "🛡️ INSTALANDO HERRAMIENTAS DE SEGURIDAD"
    
    case $PACKAGE_MANAGER in
        apt)
            $INSTALL_CMD ufw clamav
            sudo ufw enable
            ;;
        dnf)
            $INSTALL_CMD firewalld
            sudo systemctl enable firewalld
            ;;
        pacman)
            $INSTALL_CMD ufw clamav
            sudo ufw enable
            ;;
    esac
    
    print_success "Herramientas de seguridad instaladas"
    log_action "Security tools instaladas"
}

install_office_suite() {
    print_section "📋 INSTALANDO HERRAMIENTAS DE OFICINA"
    
    case $PACKAGE_MANAGER in
        apt|dnf|pacman)
            $INSTALL_CMD libreoffice
            ;;
    esac
    
    print_success "Suite de oficina instalada"
    log_action "Office suite instalada"
}

install_design_software() {
    print_section "🎨 INSTALANDO SOFTWARE DE DISEÑO"
    
    case $PACKAGE_MANAGER in
        apt|dnf|pacman)
            $INSTALL_CMD gimp inkscape
            ;;
    esac
    
    print_success "Software de diseño instalado"
    log_action "Design software instalado"
}

install_system_tools() {
    print_section "🖥️ INSTALANDO HERRAMIENTAS DE SISTEMA"
    
    case $PACKAGE_MANAGER in
        apt)
            $INSTALL_CMD gparted synaptic
            ;;
        dnf)
            $INSTALL_CMD gparted
            ;;
        pacman)
            $INSTALL_CMD gparted
            ;;
    esac
    
    print_success "Herramientas de sistema instaladas"
    log_action "System tools instaladas"
}

setup_network_vpn() {
    print_section "🌐 CONFIGURANDO RED Y VPN"
    
    case $PACKAGE_MANAGER in
        apt)
            $INSTALL_CMD network-manager-openvpn
            ;;
        dnf)
            $INSTALL_CMD NetworkManager-openvpn
            ;;
        pacman)
            $INSTALL_CMD networkmanager-openvpn
            ;;
    esac
    
    print_success "Red y VPN configurados"
    log_action "Network y VPN configurados"
}

setup_themes_customization() {
    print_section "🔧 INSTALANDO TEMAS Y PERSONALIZACIÓN"
    
    case $PACKAGE_MANAGER in
        apt|dnf|pacman)
            $INSTALL_CMD gnome-tweaks 2>/dev/null || true
            ;;
    esac
    
    print_success "Temas configurados"
    log_action "Themes configurados"
}

show_system_info() {
    print_section "📊 INFORMACIÓN DEL SISTEMA"
    
    echo -e "${BOLD}${CYAN}Sistema:${NC} $(uname -a)"
    echo -e "${BOLD}${CYAN}CPU:${NC} $(nproc) cores"
    echo -e "${BOLD}${CYAN}RAM:${NC} $(free -h | grep '^Mem:' | awk '{print $2}')"
    echo -e "${BOLD}${CYAN}Disco:${NC} $(df -h / | awk 'NR==2 {print $4}') libre"
    
    log_action "Información del sistema mostrada"
}

cleanup_system() {
    print_section "🧹 LIMPIEZA DEL SISTEMA"
    
    case $PACKAGE_MANAGER in
        apt)
            sudo apt autoremove -y
            sudo apt autoclean
            ;;
        dnf)
            sudo dnf autoremove -y
            sudo dnf clean all
            ;;
        pacman)
            sudo pacman -Rns $(pacman -Qtdq) --noconfirm 2>/dev/null || true
            ;;
    esac
    
    print_success "Sistema limpio"
    log_action "System cleanup completado"
}

create_backup_point() {
    print_section "💾 CREANDO PUNTO DE RESTAURACIÓN"
    
    BACKUP_DIR="$HOME/linux_setup_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    cp -r ~/.config "$BACKUP_DIR/" 2>/dev/null || true
    cp ~/.bashrc "$BACKUP_DIR/" 2>/dev/null || true
    
    print_success "Backup creado en: $BACKUP_DIR"
    log_action "Backup creado"
}

full_setup() {
    print_section "🎯 CONFIGURACIÓN COMPLETA AUTOMÁTICA"
    
    create_backup_point
    update_system
    install_drivers
    install_basic_apps
    install_browsers
    install_communication
    install_multimedia
    install_development
    setup_flatpak
    install_security_tools
    cleanup_system
    
    print_success "¡Setup completo terminado!"
    log_action "Setup completo finalizado"
}

show_final_report() {
    print_section "📋 RESUMEN FINAL"
    
    echo -e "${GREEN}${CHECK} Proceso completado exitosamente${NC}"
    echo -e "${BLUE}${ARROW}${NC} Log: ${BOLD}$LOG_FILE${NC}"
    echo -e "${BLUE}${ARROW}${NC} Sistema: ${BOLD}$DISTRO${NC}"
    echo -e "${YELLOW}⚠️${NC} ${BOLD}Se recomienda reiniciar${NC}"
    
    echo -e "\n${PURPLE}${STAR} ¡Gracias por usar el script!${NC}"
    echo -e "${DIM}https://jotahumesitio.space${NC}\n"
    
    echo -en "${BOLD}¿Reiniciar ahora? (s/N): ${NC}"
    read -r reboot_choice
    if [[ $reboot_choice =~ ^[SsYy]$ ]]; then
        sudo reboot
    fi
}

main() {
    print_banner
    check_root
    detect_distro
    
    while true; do
        show_menu
        echo -en "${BOLD}${WHITE}Selecciona [0-23]: ${NC}"
        read -r choice
        
        case $choice in
            1) update_system ;;
            2) install_drivers ;;
            3) install_basic_apps ;;
            4) install_browsers ;;
            5) install_communication ;;
            6) install_multimedia ;;
            7) install_gaming ;;
            8) install_development ;;
            9) install_desktop_environment "gnome" ;;
            10) install_desktop_environment "kde" ;;
            11) install_desktop_environment "xfce" ;;
            12) install_desktop_environment "mate" ;;
            13) setup_flatpak ;;
            14) install_security_tools ;;
            15) install_office_suite ;;
            16) install_design_software ;;
            17) install_system_tools ;;
            18) setup_network_vpn ;;
            19) setup_themes_customization ;;
            20) full_setup ;;
            21) show_system_info ;;
            22) cleanup_system ;;
            23) create_backup_point ;;
            0) 
                show_final_report
                break
                ;;
            *)
                print_error "Opción inválida. Selecciona 0-23."
                ;;
        esac
        
        echo -e "\n${DIM}Presiona Enter para continuar...${NC}"
        read -r
    done
}

# Ejecutar script
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi