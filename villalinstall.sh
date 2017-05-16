#! /bin/bash
# -*- ENCODING: UTF-8 -*-

echo "##  Script de post-instalacion de programas para Arch y derivados  ##"

echo "##  Realizado por Francisco Villalta  ##"

PATCH=$(dirname $0)
USUARIO="fran"


# FUNCIONES
funcion_desinstalar() {
	sudo pacman -Rn --noconfirm $1 
	if [ $? = "0" ]
	then
		return 0
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



#  Actualizar SO
sudo pacman -Syu


#  Utilidades
funcion_instalar plank

# Java
funcion_config_jdk


#  Desarrollo
funcion_instalar netbeans
funcion_instalar intellij-idea-community-edition
funcion_instalar_AUR sublime-text-dev
funcion_instalar_AUR brackets
funcion_instalar_AUR android-studio


#  Internet
funcion_instalar_AUR google-chrome

#  Juegos
funcion_instalar_AUR playonlinux
funcion_instalar_AUR wine

#  DE's y WM's
funcion_instalar_AUR virtualbox-ext-oracle

#  Multimedia
funcion_instalar vlc
funcion_instalar_Spotify


#  Productividad
funcion_desinstalar libreoffice
funcion_instalar_AUR wps-office


#  Personalizacion





