#! /bin/bash
# -*- ENCODING: UTF-8 -*-

echo "##  Script de post-instalacion de programas para Arch y derivados  ##"

echo "##  Realizado por Francisco Villalta  ##"

#  PATH=$(dirname $0)

#  BASE_DIR=$(cd $(dir $0) && pwd)

#  USUARIO="fran"


# FUNCIONES
funcion_desinstalar() {
	sudo pacman -Rn --noconfirm $1 
	if [ $? = "0" ]
	then
		return 0 #cambiar por exit
	else
		echo "Error: No se ha podido desinstalar <$1>" >> log.txt
		return 1
	fi
}

funcion_instalar() {
    
    #  Limpia la caché (alojada en tmp) para evitar fallos de instalacion
    sudo rm -rf /tmp/*
    
    #  Redimensiona la particion tmp 
    sudo mount -o remount,size=8G /tmp
    
	sudo pacman -S --noconfirm $1 
	if [ $? = "0" ]
	then
		return 0
	else
		echo "Error: No se ha podido instalar <$1>" >> log.txt
		return 1
	fi
}

funcion_instalar_AUR() {

    #  Limpia la caché (alojada en tmp) para evitar fallos de instalacion
    sudo rm -rf /tmp/*
    
    #  Redimensiona la particion tmp 
    sudo mount -o remount,size=8G /tmp
    
	yaourt -S --noconfirm $1 
	if [ $? = "0" ]
	then
		return 0
	else
		echo "Error: No se ha podido instalar <$1>" >> log.txt
		return 1
	fi
}

funcion_instalar_Spotify() {
    yaourt -S --m-arg --skippgpcheck --noconfirm libopenssl-1.0-compat
    yaourt -S --m-arg --skippgpcheck --noconfirm libcurl-openssl-1.0
    yaourt -S --noconfirm spotify 
}

funcion_config_jdk() {
    funcion_instalar_AUR jdk
    sudo archlinux-java unset
    sudo archlinux-java set java-8-jdk
}

funcion_config_mysql() {
    funcion_instalar_AUR xampp
    funcion_instalar_AUR mysql-workbench
    funcion_instalar_AUR mariadb
    
    sudo chmod -R 777 /opt/lampp
}


#
#  Actualizar SO
sudo pacman -Syu


#  Utilidades
funcion_instalar plank
funcion_instalar_AUR plank-theme-arc
funcion_instalar screenfetch
funcion_instalar_AUR etcher

# Java
funcion_config_jdk


#  Desarrollo
funcion_instalar netbeans
funcion_instalar intellij-idea-ultimate-edition
funcion_instalar_AUR sublime-text-dev
funcion_instalar_AUR brackets
funcion_instalar_AUR android-studio
funcion_instalar datagrip
funcion_config_mysql

#  Internet
funcion_instalar_AUR google-chrome

#  Juegos
funcion_instalar_AUR playonlinux
funcion_instalar_AUR wine

#  DE's y WM's
sudo pacman -S --noconfirm virtualbox virtualbox-host-dkms virtualbox-guest-iso linux-headers dkms net-tools

#  Multimedia
funcion_instalar vlc
funcion_instalar_Spotify

#  Redes sociales
funcion_instalar_AUR telegram-desktop-bin
funcion_instalar_AUR whatsie
funcion_instalar_AUR discord





