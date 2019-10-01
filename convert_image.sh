#!/bin/bash

len_unique_num=0
start_num=0


help_func(){
	echo "--help|-h - dispalay helpful information about program"
	echo "--unique_num|-un *int* - the number of digits in the unique number"
	echo "--start_num|-sn *int* - the initial value in the unique number"
}

check_un_sn(){
	if [ "$#" -ge 4 ]; then 
		if [ "$3" = "-un" ] || [ "$3" = "--unique_num" ]; then 
			len_max_count=$4
		elif [ "$3" = "-sn" ] || [ "$3" = "--start_num" ]; then
			start_num=$4
		fi
	fi

	if [ "$#" -ge 6 ]; then
		if [ "$5" = "-un" ] || [ "$5" = "--unique_num" ]; then 
			len_max_count=$6
		elif [ "$5" = "-sn" ] || [ "$5" = "--start_num" ]; then
			start_num=$6
		fi
	fi
}

convert_image(){
	check_un_sn "$@"
	
	imagefile=$(find . -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.gif' -o -name '*.bmp')
	
	

	for x in $imagefile;
	do
		# check length of unique num 
		if [ "${#num_count}" -le $len_unique_num ]; then
			year=$(date -r $x +"%Y")
			month=$(date -r $x +"%m")
			day=$(date -r $x +"%d")
			sec=$(date -r $x +"%S")
			min=$(date -r $x +"%M")
			hour=$(date -r $x +"%H")

			name="$year-$month-$day-$hour-$min-$sec-$start_num"
			magick convert $x $name.jpeg

			start_num=$(($start_num + 1))
		else
			echo "ERROR: Too many files"
			exit 1
		fi
	done
	return 0
}

main(){
	if [ "$1" = "-dir" ]; then
		if [ -d "$2" ]; then 
			cd $2
			convert_image "$@"
		else
			echo "ERROR: The specified directory does not exist"
			exit 1
		fi

	elif [ "-h" = "$1" ] || [ "--help" = "$1" ]; then 
		help_func
	fi 
	
	return 0 	 
}

main "$@"
exit 0