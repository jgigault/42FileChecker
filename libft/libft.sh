#!/bin/bash



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
echo "\033[1m  _    ___ ___ ___ _____  \033[0m";
echo "\033[1m | |  |_ _| _ ) __|_   _|  __    __ __    __ _  \033[0m";
echo "\033[1m | |__ | || _ \ _|  | |   /  |_||_ /  |/ |_ |_) \033[0m";
echo "\033[1m |____|___|___/_|   |_|   \__| ||__\__|\ |__| \ \033[0m";
echo "\033[1m jgigault @ student.42.fr \033[0m";
echo "";
echo "\033[1m------------------------------------------------\033[0m";
echo "\033[1mFichier auteur :\033[0m"
if [ ! -f auteur ]; 
then echo "\033[31mFICHIER AUTEUR ABSENT\033[0m";
else cat -e auteur;
fi;

echo "";
echo "\033[1m------------------------------------------------\033[0m";
echo "\033[1mNorme :\033[0m";
norminette *.[ch] | sed -n "/Error/p" | awk 'END {if (NR == 0) print "\033[0;32mOK\033[m"; else print "\033[31m",$0,"\033[0m";}';


echo "";
echo "\033[1m------------------------------------------------\033[0m";
echo "\033[1mVerification des fonctions 'static' :\033[0m";
check_statics . | awk 'END {if (NR == 0) print "\033[0;32mOK\033[m"; else print $0; }';

echo "";
echo "\033[1m------------------------------------------------\033[0m";
echo "\033[1mFonctions interdites (stdio.h, printf) :\033[0m";
cat *.[ch] | grep "stdio.h" | awk 'END {if (NR == 0) print "stdio.h : \033[0;32mOK\033[m"; else print "\033[31m",$0,"\033[0m";}';
cat *.[ch] | grep "printf" | awk 'END {if (NR == 0) print "printf : \033[0;32mOK\033[m"; else print "\033[31m",$0,"\033[0m";}';


echo "";
echo "\033[1m------------------------------------------------\033[0m";
echo "\033[1mFonctions obligatoires :\033[0m";
OBL="";
if [ ! -f ft_memset.c ]; then echo "ft_memset.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_bzero.c ]; then echo "ft_bzero.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_memcpy.c ]; then echo "ft_memcpy.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_memccpy.c ]; then echo "ft_memccpy.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_memmove.c ]; then echo "ft_memmove.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_memchr.c ]; then echo "ft_memchr.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_memcmp.c ]; then echo "ft_memcmp.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strlen.c ]; then echo "ft_strlen.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strdup.c ]; then echo "ft_strdup.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strcpy.c ]; then echo "ft_strcpy.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strncpy.c ]; then echo "ft_strncpy.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strcat.c ]; then echo "ft_strcat.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strncat.c ]; then echo "ft_strncat.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strlcat.c ]; then echo "ft_strlcat.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strchr.c ]; then echo "ft_strchr.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strrchr.c ]; then echo "ft_strrchr.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strstr.c ]; then echo "ft_strstr.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strnstr.c ]; then echo "ft_strnstr.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strcmp.c ]; then echo "ft_strcmp.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strncmp.c ]; then echo "ft_strncmp.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_atoi.c ]; then echo "ft_atoi.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_isalpha.c ]; then echo "ft_isalpha.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_isdigit.c ]; then echo "ft_isdigit.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_isalnum.c ]; then echo "ft_isalnum.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_isascii.c ]; then echo "ft_isascii.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_isprint.c ]; then echo "ft_isprint.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_toupper.c ]; then echo "ft_toupper.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_tolower.c ]; then echo "ft_tolower.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_memalloc.c ]; then echo "ft_memalloc.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_memdel.c ]; then echo "ft_memdel.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strnew.c ]; then echo "ft_strnew.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strdel.c ]; then echo "ft_strdel.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strclr.c ]; then echo "ft_strclr.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_striter.c ]; then echo "ft_striter.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_striteri.c ]; then echo "ft_striteri.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strmap.c ]; then echo "ft_strmap.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strmapi.c ]; then echo "ft_strmapi.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strequ.c ]; then echo "ft_strequ.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strnequ.c ]; then echo "ft_strnequ.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strsub.c ]; then echo "ft_strsub.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strjoin.c ]; then echo "ft_strjoin.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strtrim.c ]; then echo "ft_strtrim.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_strsplit.c ]; then echo "ft_strsplit.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_itoa.c ]; then echo "ft_itoa.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_putchar.c ]; then echo "ft_putchar.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_putchar_fd.c ]; then echo "ft_putchar_fd.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_putstr.c ]; then echo "ft_putstr.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_putstr_fd.c ]; then echo "ft_putstr_fd.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_putendl.c ]; then echo "ft_putendl.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_putendl_fd.c ]; then echo "ft_putendl_fd.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_putnbr.c ]; then echo "ft_putnbr.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ ! -f ft_putnbr_fd.c ]; then echo "ft_putnbr_fd.c : \033[31mABSENT\033[0m"; OBL=KO; fi;
if [ "$OBL" == "" ]; then
echo "\033[0;32mOK\033[m"; fi;

echo "";
echo "\033[1m------------------------------------------------\033[0m";
echo "\033[1mBonus :\033[0m";
if [ -f ft_lstadd.c ]; 
then echo "ft_lstadd.c : \033[0;32mOK\033[m";
else echo "ft_lstadd.c : \033[31mNON\033[0m"; fi;
if [ -f ft_lstnew.c ];
then echo "ft_lstnew.c : \033[0;32mOK\033[m";
else echo "ft_lstnew.c : \033[31mNON\033[0m"; fi;
if [ -f ft_lstdel.c ];
then echo "ft_lstdel.c : \033[0;32mOK\033[m";
else echo "ft_lstdel.c : \033[31mNON\033[0m"; fi;
if [ -f ft_lstdelone.c ];
then echo "ft_lstdelone.c : \033[0;32mOK\033[m";
else echo "ft_lstdelone.c : \033[31mNON\033[0m"; fi;
if [ -f ft_lstiter.c ];
then echo "ft_lstiter.c : \033[0;32mOK\033[m";
else echo "ft_lstiter.c : \033[31mNON\033[0m"; fi;
if [ -f ft_lstmap.c ];
then echo "ft_lstmap.c : \033[0;32mOK\033[m";
else echo "ft_lstmap.c : \033[31mNON\033[0m"; fi;


echo "";
echo "\033[1m------------------------------------------------\033[0m";
echo "\033[1mFichiers supplementaires :\033[0m";
ls | sed "/.[oa]$/d" | sed "/ft_atoi.c/d" | sed "/ft_isalnum.c/d" | sed "/ft_memset.c/d" | sed "/ft_bzero.c/d" | sed "/ft_memcpy.c/d" | sed "/ft_memccpy.c/d" | sed "/ft_memmove.c/d" | sed "/ft_memchr.c/d" | sed "/ft_memcmp.c/d" | sed "/ft_strlen.c/d" | sed "/ft_strdup.c/d" | sed "/ft_strcpy.c/d" | sed "/ft_strncpy.c/d" | sed "/ft_strcat.c/d" | sed "/ft_strncat.c/d" | sed "/ft_strlcat.c/d" | sed "/ft_strchr.c/d" | sed "/ft_strrchr.c/d" | sed "/ft_strstr.c/d" | sed "/ft_strnstr.c/d" | sed "/ft_strcmp.c/d" | sed "/ft_strncmp.c/d" | sed "/ft_atoi.c/d" | sed "/ft_isalpha.c/d" | sed "/ft_isdigit.c/d" | sed "/ft_isalnum.c/d" | sed "/ft_isascii.c/d" | sed "/ft_isprint.c/d" | sed "/ft_toupper.c/d" | sed "/ft_tolower.c/d" | sed "/ft_memalloc.c/d" | sed "/ft_putnbr_fd.c/d" | sed "/ft_putendl_fd.c/d" | sed "/ft_putstr_fd.c/d" | sed "/ft_putchar_fd.c/d" | sed "/ft_putnbr.c/d" | sed "/ft_putendl.c/d" | sed "/ft_putstr.c/d" | sed "/ft_putchar.c/d" | sed "/ft_itoa.c/d" | sed "/ft_strsplit.c/d" | sed "/ft_strtrim.c/d" | sed "/ft_strjoin.c/d" | sed "/ft_strsub.c/d" | sed "/ft_strnequ.c/d" | sed "/ft_strequ.c/d" | sed "/ft_strmapi.c/d" | sed "/ft_strmap.c/d" | sed "/ft_striteri.c/d" | sed "/ft_striter.c/d" | sed "/ft_strclr.c/d" | sed "/ft_strdel.c/d" | sed "/ft_strnew.c/d" | sed "/ft_memdel.c/d" | sed "/libft.h/d" | sed "/libft.sh/d" | sed "/ft_lstadd.c/d" | sed "/ft_lstdel.c/d" | sed "/ft_lstnew.c/d" | sed "/ft_lstdelone.c/d" | sed "/ft_lstiter.c/d" | sed "/ft_lstmap.c/d" | sed "/Makefile/d" | sed "/m1/d" | sed "/m2/d" | sed "/m3/d" | sed "/m4/d" | sed "/libft.a/d" | sed "/auteur/d" | awk 'END {if (NR == 0) print "[Aucune fonction supplementaire]"; else print "",$0,"";}';

echo "";
echo "\033[1m------------------------------------------------\033[0m";
echo "\033[1mmake :\033[0m";
make > /dev/null;
ls | grep "\.o" | tr "\n" " ";
ls | grep "\.a";

echo "";
echo "\033[1m------------------------------------------------\033[0m";
echo "\033[1mmake :\033[0m";
make > /dev/null;
ls | grep "\.o" | tr "\n" " ";
ls | grep "\.a";

echo "";
echo "\033[1m------------------------------------------------\033[0m";
echo "\033[1mmake re :\033[0m";
make re > /dev/null;
ls | grep "\.o" | tr "\n" " ";
ls | grep "\.a";

echo "";
echo "\033[1m------------------------------------------------\033[0m";
echo "\033[1mmake clean :\033[0m";
make clean > /dev/null;
ls | grep "\.o" | tr "\n" " ";
ls | grep "\.a";

echo "";
echo "\033[1m------------------------------------------------\033[0m";
echo "\033[1mmake fclean :\033[0m";
make fclean > /dev/null;
ls | grep "\.o" | tr "\n" " ";
ls | grep "\.a";

echo "";
echo "\033[1m------------------------------------------------\033[0m";
echo "\033[1mmake && make clean\033[0m";
make > /dev/null && make clean > /dev/null;

if [ ! -f libft.a ];
then
echo "\n\033[31mERREUR : libft.a n'a pas ete cree, le script s'arrete la.\033[0m";

else



echo "";
echo "\033[1m------------------------------------------------\033[0m";
echo "\033[1mMouli-nator (mvaude@student.42.fr) :\033[0m";
if [ -f m1/Mouli-nator ];
then
make -C m1;
else
echo "\033[31mm1/Mouli-nator est introuvable\033[0m";
fi;

echo "";
echo "\033[1m------------------------------------------------\033[0m";
echo "\033[1mmain.c :\033[0m";
if [ -f m2/main.c ];
then
gcc -Wall -Werror -Wextra m2/main.c -L./ -lft -o m2/a.out;
./m2/a.out;
else
echo "\033[31mm2/main.c est introuvable\033[0m";
fi;

echo "";
echo "\033[1m------------------------------------------------\033[0m";
echo "\033[1mm3/main.c :\033[0m";
if [ -f m3/main.c ];
then
gcc -Wall -Werror -Wextra m3/main.c -L./ -lft -o m3/a.out;
./m3/a.out;
else
echo "\033[31mm3/main.c est introuvable\033[0m";
fi;

echo "";
echo "\033[1m------------------------------------------------\033[0m";
echo "\033[1mm4/main.c :\033[0m";
if [ -f m4/main.c ];
then
gcc -Wall -Werror -Wextra m4/main.c -L./ -lft -o m4/a.out;
./m4/a.out;
else
echo "\033[31mm4/main.c est introuvable\033[0m";
fi;

fi;

echo "";
echo "\033[1m------------------------------------------------\033[0m";




