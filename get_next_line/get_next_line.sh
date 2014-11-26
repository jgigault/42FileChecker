#!/bin/bash

COLUMNS=`tput cols`
if [ "$COLUMNS" == "" ]
then
	$COLUMNS = 80;
fi;

function display_hr
{
	echo "\033[1m"
	printf "%"$COLUMNS"s" "" | sed s/' '/"${c:=_}"/g | cut -c1-$COLUMNS
	if [ "$1" != "" ]
	then
		echo "$1\033[0m";
	else
		echo "\033[0m";
	fi;
}

function check_statics
{
	for i in $(ls -1 $1 | grep .c)
	do
		FILEN=$i
		FILEPATH=$1"/"$i
		awk -v FILEN="$FILEN" 'BEGIN \
    	{ \
        	OFS = ""
	        sub(/\.c/, "", FILEN)
	    } \
    	$0 ~ /^[a-z_]+[	 ]+\**[a-z_]*\(.*/ \
	    { \
    	    gsub (/^[a-z_]*[	 ]+\**/, "")
        	gsub (/ *\(.*$/, "")
	        if ($1 != FILEN) \
    	    { \
        	    print FILENAME, " (ligne ", NR, ") : ", $0, "() \033[31mshould be declared as \033[0;34mstatic\033[0m" \
	        } \
    	}' $FILEPATH
	done
}

clear;
echo "";
echo "\033[1m   ___ _  _ _    \033[0m";
echo "\033[1m  / __| \| | |     __    __ __    __ _  \033[0m";
echo "\033[1m | (_ | .\` | |__  /  |_||_ /  |/ |_ |_) \033[0m";
echo "\033[1m  \___|_|\_|____| \__| ||__\__|\ |__| \ \033[0m";
echo "\033[1m jgigault @ student.42.fr \033[0m";

display_hr "Fichier auteur"
cat -e auteur;

display_hr "get_next_line.c && get_next_line.h :"
echo "Verification de la presence des fichiers du projet a la racine :";
OBL="";
if [ ! -f get_next_line.c ]; 
then
	echo "get_next_line.c : \033[31mINTROUVABLE\033[0m";
	OBL=KO;
fi;
if [ ! -f get_next_line.h ];
then
	echo "get_next_line.h : \033[31mINTROUVABLE\033[0m";
	OBL=KO;
fi;
if [ "$OBL" == "" ];
then
	echo "\033[0;32mOK\033[m";
fi;

display_hr "libft :"
LIBFT=0;
if [ -d libft ];
then
	LIBFT=1;
	echo "\033[0;32mOUI\033[m";
else
	echo "\033[31mNON\033[0m";
fi;
if [ "$LIBFT" == "1" ];
then

	if [ -f libft/ft_memalloc.c -o -f libft/ft_strnew.c ];
	then
		LIBFT_SRCS="libft";
	else
		if [ -f libft/srcs/ft_memalloc.c -o -f libft/srcs/ft_strnew.c ];
		then
			LIBFT_SRCS="libft/srcs";
		else
			echo "\033[1m\nVeuillez indiquer dans quel dossier se trouvent les fichiers *.c de la libft :\033[0m\033\
[0;34m";
			read LIBFT_SRCS
			while [ ! -f $LIBFT_SRCS"/ft_memalloc.c" -o ! -f $LIBFT_SRCS"/ft_strnew.c" ]
			do
				echo "\033[0m\033[31mDossier invalide !\033[0m\n\n\033[1mVeuillez reessayer (exemple : ./libft/srcs) :\033[0m\033[0;34m";
				read LIBFT_SRCS
			done
		fi;
	fi;
	echo "\033[0m";
	echo "\033[1mVerification des fonctions auxiliaires de la libft.\033[0m";
	echo "Les fonctions auxiliaires doivent etre declarees en 'static' :";
	check_statics $LIBFT_SRCS | awk 'END {if (NR == 0) print "\033[0;32mOK\033[m"; else print $0; }';
fi;

display_hr "Norme :"
norminette get_next_line.[ch] | sed "/Norminette can't check this file/d" | sed "/Norme:/d" | awk 'BEGIN { OFS = "" } END {if (NR == 0) print "get_next_line : \033[0;32mOK\033[m"; else print "\033[31m",$0,"\033[0m";}';
if [ "$LIBFT" == "1" ];
then
	if [ -d $LIBFT_SRCS ];
	then
		norminette $LIBFT_SRCS/*.[ch] | sed "/Norminette can't check this file/d" | sed "/Norme:/d" | awk 'BEGIN { OFS = "" } END {if (NR == 0) print "'"$LIBFT_SRCS"'/*.[ch] : \033[0;32mOK\033[m"; else print "'"$LIBFT_SRCS"'/*.[ch] : \033[31m",$0,"\033[0m";}';
	fi;
	if [ -d libft/includes ];
	then
		norminette libft/includes/*.[ch] | sed "/Norminette can't check this file/d" | sed "/Norme:/d" | awk 'BEGIN { OFS = "" } END {if (NR == 0) print "libft/includes/*.[ch] : \033[0;32mOK\033[m"; else print "libft/includes/*.[ch] : \033[31m",$0,"\033[0m";}';
	fi;
	norminette libft/*.[ch] | sed "/Norminette can't check this file/d" | sed "/Norme:/d" | awk 'BEGIN { OFS = "" } END {if (NR == 0) print "libft/*.[ch] : \033[0;32mOK\033[m"; else print "libft/*.[ch] : \033[31m",$0,"\033[0m";}'; 
fi;

display_hr "Presence du macro BUFF_SIZE :"
if [ ! -f get_next_line.h ];
then
    echo "get_next_line.h : \033[31mINTROUVABLE\033[0m";
else
	cat get_next_line.h | sed -n "/define BUFF_SIZE/p" | awk 'BEGIN { OFS = "" } END {if (NR != 0) print "#define BUFF_SIZE : \033[0;32mOK\033[m"; else print "\033[31mAucune macro detectee\033[0m";}';
fi;

display_hr "Fonctions interdites (stdio.h, printf) :"
find *.[ch] | grep "stdio.h" | awk 'BEGIN { OFS = "" } END {if (NR == 0) print "stdio.h : \033[0;32mOK\033[m"; else print "\033[31m",$0,"\033[0m";}';
find *.[ch] | grep "printf" | awk 'BEGIN { OFS = "" } END {if (NR == 0) print "printf : \033[0;32mOK\033[m"; else print "\033[31m",$0,"\033[0m";}';

if [ "$LIBFT" == "1" ];
then
	display_hr "Fonctions supplementaires de la libft :"
	echo "Verifiez si une fonction de libft n'a pas ete cree specialement pour get_next_line :";
	ls -R ./libft | sed "/libft/d" | sed "/.[oa]$/d" | sed "/ft_atoi.c/d" | sed "/ft_isalnum.c/d" | sed "/ft_memset.c/d" | sed "/ft_bzero.c/d" | sed "/ft_memcpy.c/d" | sed "/ft_memccpy.c/d" | sed "/ft_memmove.c/d" | sed "/ft_memchr.c/d" | sed "/ft_memcmp.c/d" | sed "/ft_strlen.c/d" | sed "/ft_strdup.c/d" | sed "/ft_strcpy.c/d" | sed "/ft_strncpy.c/d" | sed "/ft_strcat.c/d" | sed "/ft_strncat.c/d" | sed "/ft_strlcat.c/d" | sed "/ft_strchr.c/d" | sed "/ft_strrchr.c/d" | sed "/ft_strstr.c/d" | sed "/ft_strnstr.c/d" | sed "/ft_strcmp.c/d" | sed "/ft_strncmp.c/d" | sed "/ft_atoi.c/d" | sed "/ft_isalpha.c/d" | sed "/ft_isdigit.c/d" | sed "/ft_isalnum.c/d" | sed "/ft_isascii.c/d" | sed "/ft_isprint.c/d" | sed "/ft_toupper.c/d" | sed "/ft_tolower.c/d" | sed "/ft_memalloc.c/d" | sed "/ft_putnbr_fd.c/d" | sed "/ft_putendl_fd.c/d" | sed "/ft_putstr_fd.c/d" | sed "/ft_putchar_fd.c/d" | sed "/ft_putnbr.c/d" | sed "/ft_putendl.c/d" | sed "/ft_putstr.c/d" | sed "/ft_putchar.c/d" | sed "/ft_itoa.c/d" | sed "/ft_strsplit.c/d" | sed "/ft_strtrim.c/d" | sed "/ft_strjoin.c/d" | sed "/ft_strsub.c/d" | sed "/ft_strnequ.c/d" | sed "/ft_strequ.c/d" | sed "/ft_strmapi.c/d" | sed "/ft_strmap.c/d" | sed "/ft_striteri.c/d" | sed "/ft_striter.c/d" | sed "/ft_strclr.c/d" | sed "/ft_strdel.c/d" | sed "/ft_strnew.c/d" | sed "/ft_memdel.c/d" | sed "/libft.h/d" | sed "/libft.sh/d" | sed "/ft_lstadd.c/d" | sed "/ft_lstdel.c/d" | sed "/ft_lstnew.c/d" | sed "/ft_lstdelone.c/d" | sed "/ft_lstiter.c/d" | sed "/ft_lstmap.c/d" | sed "/Makefile/d" | sed "/libt.a/d" | sed "/auteur/d" | awk 'BEGIN { OFS = "" } {print "\033[31m",$0,"\033[0m";} END {if (NR == 0) print "\033[0;32mAUCUNE FONCTION SUPPLEMENTAIRE\033[m";}';
fi;

if [ -f main_1.c -a -f main_2.c -a -f main_3.c -a -f main_4.c -a -f main_5.c -a -f main_6.c -a -f main_7.c -a -f main_8.c ];
then
	rm -f get_next_line.o main_1.o main_2.o main_3.o main_4.o main_5.o main_6.o main_7.o main_8.o;

	if [ "$LIBFT" == "1" ];
	then
		display_hr "Compilation AVEC libft."
		echo "\033[31m";
		make -C libft/ fclean > /dev/null;
		make -C libft/ > /dev/null;
		gcc -Wall -Wextra -Werror -I libft/includes/ -c get_next_line.c;
		gcc -Wall -Wextra -Werror -I libft/includes/ -c main_2.c;
		gcc -o test_gnl_2 get_next_line.o main_2.o -L libft/ -lft;
		gcc -Wall -Wextra -Werror -I libft/includes/ -c main_1.c;
		gcc -o test_gnl_1 get_next_line.o main_1.o -L libft/ -lft;
		gcc -Wall -Wextra -Werror -I libft/includes/ -c main_3.c;
		gcc -o test_gnl_3 get_next_line.o main_3.o -L libft/ -lft;
		gcc -Wall -Wextra -Werror -I libft/includes/ -c main_4.c;
		gcc -o test_gnl_4 get_next_line.o main_4.o -L libft/ -lft;
		gcc -Wall -Wextra -Werror -I libft/includes/ -c main_5.c;
		gcc -o test_gnl_5 get_next_line.o main_5.o -L libft/ -lft;
		gcc -Wall -Wextra -Werror -I libft/includes/ -c main_6.c;
		gcc -o test_gnl_6 get_next_line.o main_6.o -L libft/ -lft;
		gcc -Wall -Wextra -Werror -I libft/includes/ -c main_7.c;
		gcc -o test_gnl_7 get_next_line.o main_7.o -L libft/ -lft;
		gcc -Wall -Wextra -Werror -I libft/includes/ -c main_8.c;
		gcc -o test_gnl_8 get_next_line.o main_8.o -L libft/ -lft;
		echo "\033[0m"
	else
		display_hr "Compilation SANS libft."
		echo "\033[31m";
		gcc -Wall -Wextra -Werror -c get_next_line.c;
		gcc -Wall -Wextra -Werror -c main_2.c;
		gcc -o test_gnl_2 get_next_line.o main_2.o;
		gcc -Wall -Wextra -Werror -c main_1.c;
		gcc -o test_gnl_1 get_next_line.o main_1.o;
		gcc -Wall -Wextra -Werror -c main_3.c;
		gcc -o test_gnl_3 get_next_line.o main_3.o;
		gcc -Wall -Wextra -Werror -c main_4.c;
		gcc -o test_gnl_4 get_next_line.o main_4.o;
		gcc -Wall -Wextra -Werror -c main_5.c;
		gcc -o test_gnl_5 get_next_line.o main_5.o;
		gcc -Wall -Wextra -Werror -c main_6.c;
		gcc -o test_gnl_6 get_next_line.o main_6.o;
		gcc -Wall -Wextra -Werror -c main_7.c;
		gcc -o test_gnl_7 get_next_line.o main_7.o;
		gcc -Wall -Wextra -Werror -c main_8.c;
		gcc -o test_gnl_8 get_next_line.o main_8.o;
		echo "\033[0m"
	fi;

	display_hr "Test 1 (une seule ligne sans retour a la ligne) :"
	echo  "\033[0;34m";
	time ./test_gnl_1;
	echo "\033[0m";

	display_hr "Test 2 (lorem ipsum) :"
	echo "Simple fichier avec 5 paragraphes :";
	echo  "\033[0;34m";
	time ./test_gnl_2;
	echo "\033[0m";

	display_hr "Test 3 (entree standard 1/2) :"
	echo "Appel de l'entree standard 5 fois."
	echo "Veuillez taper du texte + ENTREE et verifiez que votre texte apparait 2 fois :"
	echo "\033[0;34m";
	time ./test_gnl_3;
	echo "\033[0m";
	echo "Appuyez sur un touche pour continuer."
	read -s -n 1 waiter

	display_hr "Test 4 (entree standard 2/2) :"
	echo "Utilise un pipe [cat test_2.txt | ./test_gnl_4] :";
	echo  "\033[0;34m";
	time cat test_2.txt | ./test_gnl_4;
	echo "\033[0m";

	display_hr "Test 5 (multi-fichiers) :"
	echo "Lecture simultanée de 2 fichiers :"
	echo  "\033[0;34m";
	time ./test_gnl_5;
	echo "\033[0m";

	display_hr "Test 6 (gros fichier) :"
	echo "Verifiez qu'il n'y ait pas de segfault !"
	echo "Veuillez patienter pendant le generation et la lecture du fichier test_6.txt..."
	echo  "\033[0;34m";
	openssl rand -out test_6.txt -base64 $((2**27 * 3/4));
	time ./test_gnl_6;
	rm -f test_6.txt;
	echo "\033[0m";

	display_hr "Test 7 (fichier vide) :"
	echo  "\033[0;34m";
	time ./test_gnl_7;
	echo "\033[0m";

	display_hr "Test 8 (plusieurs lignes vides en fin de fichier) :"
	echo  "\033[0;34m";
	time ./test_gnl_8;
	echo "\033[0m";

	rm -f get_next_line.o main_1.o main_2.o main_3.o main_4.o main_5.o main_6.o main_7.o main_8.o;
fi;

display_hr