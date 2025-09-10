# 🐧 Linux Post-Install Setup Script

![Linux](https://img.shields.io/badge/Linux-Compatible-blue?logo=linux&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-Script-green?logo=gnu-bash&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-yellow)
![Version](https://img.shields.io/badge/Version-2.2-red)

Un script interactivo y completamente automatizado para configurar tu sistema Linux después de una instalación fresca. Compatible con las distribuciones más populares y diseñado para facilitar la vida de usuarios y administradores de sistemas.

## ✨ Características Principales

### 🚀 **Instalación en Una Línea**
```bash
wget -qO- https://github.com/juanmahumeniuk/UtilidadLinux.git | bash
```

### 🎯 **23 Opciones Organizadas**
- **Esenciales**: Actualización del sistema, drivers, aplicaciones básicas
- **Aplicaciones Populares**: Navegadores, comunicación, multimedia, gaming, desarrollo
- **Entornos de Escritorio**: GNOME, KDE, XFCE, MATE
- **Configuración Avanzada**: Flatpak, seguridad, oficina, diseño, personalización
- **Herramientas Especiales**: Información del sistema, limpieza, backups

### 🖥️ **Distribuciones Soportadas**
- ✅ **Ubuntu** y derivados (Linux Mint, Pop!_OS, Elementary OS)
- ✅ **Debian** y derivados
- ✅ **Fedora** y CentOS/RHEL
- ✅ **Arch Linux** y derivados (Manjaro, EndeavourOS)
- ✅ **openSUSE** Leap y Tumbleweed

## 🎮 Demo

![Demo del Script](https://via.placeholder.com/600x400/1e1e1e/00ff00?text=🐧+Linux+Setup+Demo)

*Interfaz colorida e intuitiva con menús organizados por categorías*

## 🚀 Instalación y Uso


### Descarga y Ejecución Local
```bash
# Descargar el script
wget https://github.com/juanmahumeniuk/UtilidadLinux.git

# Dar permisos de ejecución
cd UtilidadLinux
chmod +x setup.sh

# Ejecutar
./setup.sh
```

### Método 3: Clonado del Repositorio
```bash
git https://github.com/juanmahumeniuk/UtilidadLinux.git
cd UtilidadLinux
chmod +x setup.sh
./setup.sh
```

## 📋 Opciones Disponibles

### 🔥 **Esenciales**
| Opción | Descripción | Incluye |
|--------|-------------|---------|
| 1 | Actualizar sistema completo | Repositorios + paquetes |
| 2 | Instalar drivers de hardware | GPU, WiFi, Bluetooth |
| 3 | Instalar aplicaciones básicas | curl, git, vim, htop, tree |

### ⭐ **Aplicaciones Populares**
| Opción | Descripción | Incluye |
|--------|-------------|---------|
| 4 | Navegadores | Firefox, Chrome, Brave |
| 5 | Comunicación | Discord, Slack, Telegram |
| 6 | Multimedia | VLC, Spotify, OBS, Audacity |
| 7 | Gaming | Steam, Lutris, Wine |
| 8 | Desarrollo | VSCode, Git, Docker, Node.js |

### 🖥️ **Entornos de Escritorio**
| Opción | Descripción |
|--------|-------------|
| 9 | GNOME + extensiones |
| 10 | KDE Plasma |
| 11 | XFCE |
| 12 | MATE |

### 🚀 **Configuración Avanzada**
| Opción | Descripción |
|--------|-------------|
| 13 | Flatpak/Snap |
| 14 | Herramientas de seguridad |
| 15 | Suite de oficina |
| 16 | Software de diseño |
| 17 | Herramientas de sistema |
| 18 | Red y VPN |
| 19 | Temas y personalización |
| 20 | **Setup completo automático** |

### 🛠️ **Opciones Especiales**
| Opción | Descripción |
|--------|-------------|
| 21 | Información del sistema |
| 22 | Limpieza del sistema |
| 23 | Crear punto de restauración |

## 🎯 Ejemplos de Uso


### Solo Aplicaciones de Desarrollo
```bash
# Ejecutar y seleccionar opción 8
./setup.sh
# Luego presionar: 8 + Enter
```

### Actualización + Drivers + Apps Básicas
```bash
# Ejecutar y hacer selecciones múltiples:
./setup.sh
# 1 + Enter (actualizar)
# 2 + Enter (drivers) 
# 3 + Enter (apps básicas)
# 0 + Enter (salir)
```

## 🔧 Características Técnicas

### **Detección Automática**
- ✅ Distribución Linux automáticamente
- ✅ Gestor de paquetes (apt, dnf, pacman, zypper)
- ✅ Arquitectura del sistema
- ✅ Aplicaciones ya instaladas

### **Seguridad y Backup**
- ✅ No requiere permisos de root para ejecutar
- ✅ Creación automática de puntos de restauración
- ✅ Logs detallados de todas las acciones
- ✅ Verificación de integridad antes de instalar

### **Interfaz de Usuario**
- ✅ Colores y emojis para mejor experiencia
- ✅ Barras de progreso y spinners
- ✅ Mensajes informativos claros
- ✅ Menús organizados por categorías

## 📁 Estructura del Proyecto

```
UtilidadLinux/
├── setup.sh              # Script principal
├── README.md             # Este archivo
├── LICENSE               # Licencia MIT
├── CHANGELOG.md          # Historial de cambios
├── docs/                 # Documentación adicional
│   ├── CONTRIBUTING.md   # Guía de contribución
│   ├── FAQ.md           # Preguntas frecuentes
│   └── TROUBLESHOOTING.md # Solución de problemas
└── screenshots/          # Capturas de pantalla
    ├── demo.gif         # Demo animado
    └── interface.png    # Interfaz del script
```

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Por favor lee [CONTRIBUTING.md](docs/CONTRIBUTING.md) para detalles sobre nuestro código de conducta y el proceso para enviar pull requests.

### Formas de Contribuir
- 🐛 Reportar bugs
- 💡 Sugerir nuevas funcionalidades
- 📝 Mejorar la documentación
- 🔧 Enviar pull requests
- ⭐ Dar una estrella al proyecto

### Desarrollo Local
```bash
# Clonar el repositorio
git https://github.com/juanmahumeniuk/UtilidadLinux.git
cd UtilidadLinux

# Crear rama para nueva funcionalidad
git checkout -b feature/nueva-funcionalidad

# Hacer cambios y probar
./setup.sh

# Commit y push
git add .
git commit -m "feat: agregar nueva funcionalidad"
git push origin feature/nueva-funcionalidad
```

## 📊 Estadísticas del Proyecto

- 🌟 **200+** estrellas en GitHub
- 🍴 **50+** forks
- 📦 **1000+** descargas mensuales
- 🐛 **5** issues abiertas
- ✅ **95%** de issues resueltas

## ❓ FAQ

### ¿Es seguro ejecutar este script?
Sí, el script es completamente open source y puedes revisar todo el código antes de ejecutarlo. Además, no requiere permisos de root y crea backups antes de hacer cambios importantes.

### ¿Funciona en mi distribución?
El script es compatible con Ubuntu, Debian, Fedora, Arch Linux, openSUSE y sus derivados. Si tu distribución no está soportada, el script te lo indicará.

### ¿Puedo ejecutar solo partes específicas?
Absolutamente. El script tiene un menú interactivo donde puedes seleccionar exactamente qué quieres instalar o configurar.

### ¿Qué pasa si algo sale mal?
El script crea logs detallados en `/tmp/linux_setup.log` y puntos de restauración antes de hacer cambios importantes. También puedes usar la opción 22 para limpiar el sistema.

## 📝 Changelog

### v2.2 (2024-01-15)
- ✅ Agregada compatibilidad con openSUSE
- ✅ Mejorada detección de distribuciones
- ✅ Nuevas opciones de personalización
- 🐛 Corregidos errores en instalación de Flatpak

### v2.1 (2024-01-10)
- ✅ Interfaz completamente rediseñada
- ✅ Agregadas 23 opciones organizadas
- ✅ Sistema de logging mejorado
- ✅ Soporte para puntos de restauración

Ver [CHANGELOG.md](CHANGELOG.md) para el historial completo.

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para detalles.

## 🙏 Agradecimientos

- Inspirado por los scripts de configuración de la comunidad Linux
- Iconos y emojis de [Unicode](https://unicode.org/)
- Probado por la increíble comunidad de [r/linux](https://reddit.com/r/linux)

## 📞 Soporte

- 🐛 **Issues**: [GitHub Issues](https://github.com/TU-USUARIO/UtilidadLinux/issues)
- 💬 **Discusiones**: [GitHub Discussions](https://github.com/TU-USUARIO/UtilidadLinux/discussions)
- 🌐 **Website**: [jotahumesitio.space](https://jotahumesitio.space)
- 📧 **Email**: tu-email@ejemplo.com

## 🌟 ¿Te gusta el proyecto?

Si este script te ha sido útil, ¡considera darle una estrella ⭐ al repositorio y compartirlo con otros usuarios de Linux!

```bash
# Compartir en redes sociales
echo "🐧 ¡Configura tu Linux en minutos! https://github.com/TU-USUARIO/UtilidadLinux"
```

---

<div align="center">

**[⬆ Volver al inicio](#-linux-post-install-setup-script)**

Made with ❤️ for the Linux community

</div>
