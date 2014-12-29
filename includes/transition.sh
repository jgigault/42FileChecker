#!/bin/bash

if [ "$FILECHECKER_SH" == "1" ]
then

	function display_header_transition
	{
		tput civis
		clear
		#printf $C_BLUE
		display_center "|"
		echo ""
		sleep 0.006s
		clear
		display_center "|"
		display_center "|"
		echo ""
		sleep 0.006s
		clear
		display_center "|"
		display_center "|"
		display_center "|"
		echo ""
		sleep 0.006s
		clear
		display_center "|"
		display_center "|"
		display_center "|"
		display_center "|"
		echo ""
		sleep 0.006s
		clear
		display_center "|"
		display_center "|"
		display_center "|"
		display_center "|"
		display_center "|"
		echo ""
		sleep 0.006s
		clear
		display_center "|"
		display_center "|"
		display_center "|"
		display_center "|"
		display_center "|"
		display_center "|"
		echo ""
		sleep 0.006s
		clear
		echo ""
		display_center "|"
		display_center "|"
		display_center "|"
		display_center "|"
		display_center "|"
		display_center "|"
		echo ""
		sleep 0.006s
		clear
		echo ""
		display_center " _|"
		display_center "| |"
		display_center "| |"
		display_center "|_|"
		display_center "  |"
		display_center "  |"
		echo ""
		sleep 0.006s
		clear
		echo ""
		display_center " _  _|"
		display_center "| || |"
		display_center "| || |"
		display_center "|__  |"
		display_center "   |_|"
		display_center "   jg|"
		echo ""
		sleep 0.006s
		clear
		echo ""
		display_center " _  _  _|"
		display_center "| || ||_|"
		display_center "| || |_ |"
		display_center "|__   _/|"
		display_center "   |_||_|"
		display_center "   jgiga|"
		echo ""
		sleep 0.006s
		clear
		echo ""
		display_center " _  _  ____  _|"
		display_center "| || ||___ \| |"
		display_center "| || |_ __) | |"
		display_center "|__   _/ __/| |"
		display_center "   |_||_____|_|"
		display_center "   jgigault @ |"
		echo ""
		sleep 0.006s
		clear
		echo ""
		display_center " _  _  ____  ____|"
		display_center "| || ||___ \|  __|"
		display_center "| || |_ __) | |_ |"
		display_center "|__   _/ __/|  _||"
		display_center "   |_||_____|_|  |"
		display_center "   jgigault @ stu|"
		echo ""
		sleep 0.006s
		clear
		echo ""
		display_center " _  _  ____  _____ _|"
		display_center "| || ||___ \|  ___(_|"
		display_center "| || |_ __) | |_  | |"
		display_center "|__   _/ __/|  _| | |"
		display_center "   |_||_____|_|   |_|"
		display_center "   jgigault @ studen|"
		echo ""
		sleep 0.006s
		clear
		echo ""
		display_center " _  _  ____  _____ _ _ |"
		display_center "| || ||___ \|  ___(_) ||"
		display_center "| || |_ __) | |_  | | ||"
		display_center "|__   _/ __/|  _| | | ||"
		display_center "   |_||_____|_|   |_|_||"
		display_center "   jgigault @ student.4|"
		echo ""
		sleep 0.006s
		clear
		echo ""
		display_center " _  _  ____  _____ _ _    |"
		display_center "| || ||___ \|  ___(_) | __|"
		display_center "| || |_ __) | |_  | | |/ _|"
		display_center "|__   _/ __/|  _| | | |  _|"
		display_center "   |_||_____|_|   |_|_|\__|"
		display_center "   jgigault @ student.42.f|"
		echo ""
		sleep 0.012s
		clear
		echo ""
		display_center " _  _  ____  _____ _ _       |"
		display_center "| || ||___ \|  ___(_) | ___ /|"
		display_center "| || |_ __) | |_  | | |/ _ \ |"
 		display_center "|__   _/ __/|  _| | | |  __/ |"
		display_center "   |_||_____|_|   |_|_|\___|\|"
		display_center "   jgigault @ student.42.fr  |"
		echo ""
		sleep 0.018s
		clear
		echo ""
		display_center " _  _  ____  _____ _ _       ___|"
		display_center "| || ||___ \|  ___(_) | ___ / __|"
		display_center "| || |_ __) | |_  | | |/ _ \ |  |"
		display_center "|__   _/ __/|  _| | | |  __/ |__|"
		display_center "   |_||_____|_|   |_|_|\___|\___|"
		display_center "   jgigault @ student.42.fr     |"
		echo ""
		sleep 0.024s
		clear
		echo ""
		display_center " _  _  ____  _____ _ _       ____ _|"
		display_center "| || ||___ \|  ___(_) | ___ / ___| |"
		display_center "| || |_ __) | |_  | | |/ _ \ |   | |"
		display_center "|__   _/ __/|  _| | | |  __/ |___| |"
		display_center "   |_||_____|_|   |_|_|\___|\____|_|"
		display_center "   jgigault @ student.42.fr        |"
		echo ""
		sleep 0.03s
		clear
		echo ""
		display_center " _  _  ____  _____ _ _       ____ _   |"
		display_center "| || ||___ \|  ___(_) | ___ / ___| |__|"
		display_center "| || |_ __) | |_  | | |/ _ \ |   | '_ |"
		display_center "|__   _/ __/|  _| | | |  __/ |___| | ||"
		display_center "   |_||_____|_|   |_|_|\___|\____|_| ||"
		display_center "   jgigault @ student.42.fr           |"
		echo ""
		sleep 0.036s
		clear
		echo ""
		display_center " _  _  ____  _____ _ _       ____ _      |"
		display_center "| || ||___ \|  ___(_) | ___ / ___| |__   |"
		display_center "| || |_ __) | |_  | | |/ _ \ |   | '_ \ /|"
		display_center "|__   _/ __/|  _| | | |  __/ |___| | | | |"
		display_center "   |_||_____|_|   |_|_|\___|\____|_| |_|\|"
		display_center "   jgigault @ student.42.fr              |"
		echo ""
		sleep 0.042s
		clear
		echo ""
		display_center " _  _  ____  _____ _ _       ____ _         |"
		display_center "| || ||___ \|  ___(_) | ___ / ___| |__   ___|"
		display_center "| || |_ __) | |_  | | |/ _ \ |   | '_ \ / _ |"
		display_center "|__   _/ __/|  _| | | |  __/ |___| | | |  __|"
		display_center "   |_||_____|_|   |_|_|\___|\____|_| |_|\___|"
		display_center "   jgigault @ student.42.fr                 |"
		echo ""
		sleep 0.05s
		clear
		echo ""
		display_center " _  _  ____  _____ _ _       ____ _            |"
		display_center "| || ||___ \|  ___(_) | ___ / ___| |__   ___  _|"
		display_center "| || |_ __) | |_  | | |/ _ \ |   | '_ \ / _ \/ |"
		display_center "|__   _/ __/|  _| | | |  __/ |___| | | |  __/ (|"
		display_center "   |_||_____|_|   |_|_|\___|\____|_| |_|\___|\_|"
		display_center "   jgigault @ student.42.fr                    |"
		echo ""
		sleep 0.056s
		clear
		echo ""
		display_center " _  _  ____  _____ _ _       ____ _               |"
		display_center "| || ||___ \|  ___(_) | ___ / ___| |__   ___  ___||"
		display_center "| || |_ __) | |_  | | |/ _ \ |   | '_ \ / _ \/ __||"
		display_center "|__   _/ __/|  _| | | |  __/ |___| | | |  __/ (__||"
		display_center "   |_||_____|_|   |_|_|\___|\____|_| |_|\___|\___||"
		display_center "   jgigault @ student.42.fr                    06 |"
		echo ""
		sleep 0.062s
		clear
		echo ""
		display_center " _  _  ____  _____ _ _       ____ _               _  |"
		display_center "| || ||___ \|  ___(_) | ___ / ___| |__   ___  ___| | |"
		display_center "| || |_ __) | |_  | | |/ _ \ |   | '_ \ / _ \/ __| |/|"
		display_center "|__   _/ __/|  _| | | |  __/ |___| | | |  __/ (__|   |"
		display_center "   |_||_____|_|   |_|_|\___|\____|_| |_|\___|\___|_|\|"
		display_center "   jgigault @ student.42.fr                    06 51 |"
		echo ""
		sleep 0.068s
		clear
		echo ""
		display_center " _  _  ____  _____ _ _       ____ _               _     |"
		display_center "| || ||___ \|  ___(_) | ___ / ___| |__   ___  ___| | ___|"
		display_center "| || |_ __) | |_  | | |/ _ \ |   | '_ \ / _ \/ __| |/ / |"
		display_center "|__   _/ __/|  _| | | |  __/ |___| | | |  __/ (__|   <  |"
		display_center "   |_||_____|_|   |_|_|\___|\____|_| |_|\___|\___|_|\_\_|"
		display_center "   jgigault @ student.42.fr                    06 51 15 |"
		echo ""
		sleep 0.072s
		clear
		echo ""
		display_center " _  _  ____  _____ _ _       ____ _               _        |"
		display_center "| || ||___ \|  ___(_) | ___ / ___| |__   ___  ___| | _____ |"
		display_center "| || |_ __) | |_  | | |/ _ \ |   | '_ \ / _ \/ __| |/ / _ \|"
		display_center "|__   _/ __/|  _| | | |  __/ |___| | | |  __/ (__|   <  __/|"
		display_center "   |_||_____|_|   |_|_|\___|\____|_| |_|\___|\___|_|\_\___||"
		display_center "   jgigault @ student.42.fr                    06 51 15 98 |"
		echo ""
		sleep 0.076s
		clear
		echo ""
		display_center " _  _  ____  _____ _ _       ____ _               _           |"
		display_center "| || ||___ \|  ___(_) | ___ / ___| |__   ___  ___| | _____ _ _|"
		display_center "| || |_ __) | |_  | | |/ _ \ |   | '_ \ / _ \/ __| |/ / _ \ '_|"
		display_center "|__   _/ __/|  _| | | |  __/ |___| | | |  __/ (__|   <  __/ | |"
		display_center "   |_||_____|_|   |_|_|\___|\____|_| |_|\___|\___|_|\_\___|_| |"
		display_center "   jgigault @ student.42.fr                    06 51 15 98 82 |"
		echo ""
		sleep 0.078s
		clear
		echo ""
		display_center "   _  _  ____  _____ _ _       ____ _               _              |"
		display_center "  | || ||___ \|  ___(_) | ___ / ___| |__   ___  ___| | _____ _ __  |"
		display_center "  | || |_ __) | |_  | | |/ _ \ |   | '_ \ / _ \/ __| |/ / _ \ '__| |"
		display_center "  |__   _/ __/|  _| | | |  __/ |___| | | |  __/ (__|   <  __/ |    |"
		display_center "     |_||_____|_|   |_|_|\___|\____|_| |_|\___|\___|_|\_\___|_|    |"
		display_center "     jgigault @ student.42.fr                    06 51 15 98 82    |"
		echo ""
		sleep 0.08s
		clear
		echo ""
		display_center "   _  _  ____  _____ _ _       ____ _               _               "
		display_center "  | || ||___ \|  ___(_) | ___ / ___| |__   ___  ___| | _____ _ __  |"
		display_center "  | || |_ __) | |_  | | |/ _ \ |   | '_ \ / _ \/ __| |/ / _ \ '__| |"
		display_center "  |__   _/ __/|  _| | | |  __/ |___| | | |  __/ (__|   <  __/ |    |"
		display_center "     |_||_____|_|   |_|_|\___|\____|_| |_|\___|\___|_|\_\___|_|    |"
		display_center "     jgigault @ student.42.fr                    06 51 15 98 82     "
		echo ""
		sleep 0.08s
		clear
		echo ""
		display_center "   _  _  ____  _____ _ _       ____ _               _               "
		display_center "  | || ||___ \|  ___(_) | ___ / ___| |__   ___  ___| | _____ _ __   "
		display_center "  | || |_ __) | |_  | | |/ _ \ |   | '_ \ / _ \/ __| |/ / _ \ '__| |"
		display_center "  |__   _/ __/|  _| | | |  __/ |___| | | |  __/ (__|   <  __/ |    |"
		display_center "     |_||_____|_|   |_|_|\___|\____|_| |_|\___|\___|_|\_\___|_|     "
		display_center "     jgigault @ student.42.fr                    06 51 15 98 82     "
		echo ""
		sleep 0.08s
		clear
		echo ""
		display_center "   _  _  ____  _____ _ _       ____ _               _               "
		display_center "  | || ||___ \|  ___(_) | ___ / ___| |__   ___  ___| | _____ _ __   "
		display_center "  | || |_ __) | |_  | | |/ _ \ |   | '_ \ / _ \/ __| |/ / _ \ '__| ."
		display_center "  |__   _/ __/|  _| | | |  __/ |___| | | |  __/ (__|   <  __/ |     "
		display_center "     |_||_____|_|   |_|_|\___|\____|_| |_|\___|\___|_|\_\___|_|     "
		display_center "     jgigault @ student.42.fr                    06 51 15 98 82     "
		echo ""
		sleep 0.08s
		clear
		echo ""
		display_center "   _  _  ____  _____ _ _       ____ _               _               "
		display_center "  | || ||___ \|  ___(_) | ___ / ___| |__   ___  ___| | _____ _ __   "
		display_center "  | || |_ __) | |_  | | |/ _ \ |   | '_ \ / _ \/ __| |/ / _ \ '__|  "
		display_center "  |__   _/ __/|  _| | | |  __/ |___| | | |  __/ (__|   <  __/ |     "
		display_center "     |_||_____|_|   |_|_|\___|\____|_| |_|\___|\___|_|\_\___|_|     "
		display_center "     jgigault @ student.42.fr                    06 51 15 98 82     "
		echo ""
		sleep 0.08s

		printf $C_CLEAR
	}

fi;