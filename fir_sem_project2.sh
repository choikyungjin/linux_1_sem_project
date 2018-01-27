declare -a directory_ary          #디렉토리 저장 배열
declare -a file_ary               #일반, 실행파일 저장 배열
declare -a special_ary            #특수파일 저장 배열
declare -a all_ary                #현재 디렉토리내 모든 항목 저장 배열
declare -a copy_ary               #복사할 파일 저장하는 배열
declare -a move_are               #이동할 파일 저장하는 배열

clear
#초기 화면 DISPLAY
main_display()
{
	tput cup 0 0
	for((i=0; i<=100; i++))
	do
	echo -n "-"
	done
	echo ""
	
	for((j=1; j<=30; j++))
	do
	tput cup $j 0
	echo -n "|"
	tput cup $j 20
	echo -n "|"
	tput cup $j 100
	echo "|"
	done

	tput cup 30 0
	for((i=0; i<45; i++))
	do
	echo -n "-"
	done
	echo -n "information"
	for((i=0; i<45; i++))
	do
	echo -n "-"
	done

	for((j=30; j<=39; j++))
	do
	tput cup $j 0
	echo -n "|"
	tput cup $j 100
	echo "|"
	done

	tput cup 37 0
	for((i=0; i<45; i++))
        do
        echo -n "-"
        done
	echo -n "information"
	for((i=0; i<45; i++))
        do
        echo -n "-"
        done

	tput cup 37 0; echo -n "|"
	tput cup 37 100; echo -n "|"
	tput cup 38 0; echo -n "|"
	tput cup 38 100; echo -n "|"

	tput cup 39 0
	for((i=0; i<=100; i++))
	do
	echo -n "-"
	done
	echo ""
}

#1번레이블 츨력 함수(상위 디렉토리 목록)
print_high_rank_list()
{
for ((l=1; l<=20; l++))
do
tput cup $l 1
echo -n "            "
done
tput cup 38 20; tput el
tput cup 38 100; echo "|"

current_pwd=`pwd`
cd ..

redeclare
assignment

tput cup 1 1
echo [31m ".."
if [ $p -gt 20 ]
then
for ((k=1; k<20; k++))
do
if [ "`file -b ${all_ary[$k]}`" = "directory" ]
then
	tput cup `expr $k + 1` 1
	echo [34m "`stat --printf=%n ${all_ary[$k]} | cut -c -10`"[0m
elif [ "`ls -l ${all_ary[$k]} | cut -c 1`" = "-" ]
then
        if [ "`ls -l ${all_ary[$k]} | cut -c -10 | grep [x]`" ]
        then
        tput cup `expr $k + 1` 1
	echo [31m "`stat --printf=%n ${all_ary[$k]} | cut -c -10`"[0m
        else
        tput cup `expr $k + 1` 1
	echo [0m "`stat --printf=%n ${all_ary[$k]} | cut -c -10`"
        fi
else
	tput cup `expr $k + 1` 1
	echo [32m "`stat --printf=%n ${all_ary[$k]} | cut -c -10`"[0m
fi
done

else
for ((k=1; k<$p; k++))
do
if [ "`file -b ${all_ary[$k]}`" = "directory" ]
then
        tput cup `expr $k + 1` 1
        echo [34m "`stat --printf=%n ${all_ary[$k]} | cut -c -10`"[0m
elif [ "`ls -l ${all_ary[$k]} | cut -c 1`" = "-" ]
then
        if [ "`ls -l ${all_ary[$k]} | cut -c -10 | grep [x]`" ]
        then
        tput cup `expr $k + 1` 1
        echo [31m "`stat --printf=%n ${all_ary[$k]} | cut -c -10`"[0m
        else
        tput cup `expr $k + 1` 1
        echo [0m "`stat --printf=%n ${all_ary[$k]} | cut -c -10`"
        fi
else
        tput cup `expr $k + 1` 1
        echo [32m "`stat --printf=%n ${all_ary[$k]} | cut -c -10`"[0m
fi
done
fi
cd $current_pwd
}

#일반디렉토리 GUI
normal_directory_GUI()
{
tput cup $2 $1
echo [34m "     __"
tput cup `expr $2 + 1` $1
echo [34m "/---/ |"
tput cup `expr $2 + 2` $1
echo [34m "|  d  |"
tput cup `expr $2 + 3` $1
echo [34m "-------"
tput cup `expr $2 + 4` $1
echo [34m "`stat --printf=%n $element | cut -c -10`"; tput sgr0
echo [0m
}
#..디렉토리 GUI
excution_directory_GUI()
{
tput cup $2 $1
echo [31m "     __"
tput cup `expr $2 + 1` $1
echo [31m "/---/ |"
tput cup `expr $2 + 2` $1
echo [31m "|  d  |"
tput cup `expr $2 + 3` $1
echo [31m "-------"
tput cup `expr $2 + 4` $1
echo [31m ".."; tput sgr0
echo [0m
}
#일반파일 GUI
normal_file_GUI()
{
tput cup $2 $1 
echo " _______"
tput cup `expr $2 + 1` $1
echo " |     |"
tput cup `expr $2 + 2` $1
echo " |  o  |"
tput cup `expr $2 + 3` $1
echo " -------"
tput cup `expr $2 + 4` $1
echo " `stat --printf=%n $element | cut -c -10`"; tput sgr0
echo ""
}
#특수파일 GUI
special_file_GUI()
{
tput cup $2 $1
echo [32m "_______"
tput cup `expr $2 + 1` $1
echo [32m "|     |"
tput cup `expr $2 + 2` $1
echo [32m "|  s  |"
tput cup `expr $2 + 3` $1
echo [32m "-------"
tput cup `expr $2 + 4` $1
echo [32m "`stat --printf=%n $element | cut -c -10`"; tput sgr0
echo [0m
}
#실행파일 GUI
excution_file_GUI()
{
tput cup $2 $1
echo [31m "_______"
tput cup `expr $2 + 1` $1
echo [31m "|     |"
tput cup `expr $2 + 2` $1
echo [31m "|  x  |"
tput cup `expr $2 + 3` $1
echo [31m "-------"
tput cup `expr $2 + 4` $1
echo [31m "`stat --printf=%n $element | cut -c -10`"; tput sgr0
echo [0m
}

#파일정보 출력 함수
file_info()
{	
for((erase_info=31; erase_info<=36; erase_info++))
do
tput cup $erase_info 20
tput el
done

tput cup 31 20
echo "File name : `stat --printf=%n $element`"
tput cup 32 20
if [ $all_ary_index -eq 0 ]
then
	echo [31m"File type : `stat --printf=%F $element`"
else
	if [ "`file -b $element`" = "directory" ]
	then
		echo [34m"File type : `stat --printf=%F $element`"
	elif [ "`ls -l $element | cut -c 1`" = "-" ]
	then
		if [ "`ls -l $element | cut -c -10 | grep [x]`" ]
		then
		echo [31m"File type : `stat --printf=%F $element`"
		else
		echo [0m"File type : `stat --printf=%F $element`"
		fi
	else
	echo [32m"File type : `stat --printf=%F $element`"
	fi
fi
tput cup 33 20
echo [0m"File size : `stat --printf=%s $element`"
tput cup 34 20
echo "Time of last data modification : `stat --printf=%y $element`"
tput cup 35 20
echo "Permission : `stat --printf=%a $element`"
tput cup 36 20
echo "Absolute path : `pwd $element`"

for((erase_info=31; erase_info<=36; erase_info++))
do
tput cup $erase_info 100
echo "|"
done
}


#재정의
redeclare()
{
unset directory_ary
unset file_ary
unset special_ary
unset all_ary

declare -a directory_ary
declare -a file_ary
declare -a special_ary
declare -a all_ary

d=0                               #특수파일 저장 배열의 인덱스
f=0                               #일반, 실행파일 저장 인덱스
s=0                               #특수파일 저장 인덱스
p=1                               #현재 디렉토리 모든 항목 저장 인덱스
}

#할당
assignment()
{
#..디렉토리 찾는 소스
counting_link_element=0
link_element=link
for hide_list in `ls -a`
do
if [ $counting_link_element -lt 2 ]
then
link_element=$hide_list
counting_link_element=`expr $counting_link_element + 1`
fi
done

#디렉토리,일반,실행,특수파일 구분하여 배열에 할당하는  작업
for item in `ls --group-directories-first`
do
	if [ "`file -b $item`" = "directory" ]
	then
		directory_ary[$d]=$item
		d=`expr $d + 1`
	elif [ "`ls -l $item | cut -c 1`" = "-" ]
	then
		file_ary[$f]=$item
		f=`expr $f + 1`

	else
		special_ary[$s]=$item
		s=`expr $s + 1`
	fi
done
#하나의 배열에 디렉토리,일반파일,특수파일의 요소를 할당해주는 작업
#배열의 첫번째는 ..디렉토리(상위디렉토리로 갈 수 있는 디렉토리)
all_ary[0]=$link_element
for dir_item in ${directory_ary[*]}
do
	all_ary[$p]=$dir_item
	p=`expr $p + 1`
done
for file_item in ${file_ary[*]}
do
	all_ary[$p]=$file_item
	p=`expr $p + 1`
done
for special_item in ${special_ary[*]}
do
	all_ary[$p]=$special_item
	p=`expr $p + 1`
done
}

#GUI출력함수
print_element()
{
if [ $p -ge 25 ]
then
for ((indx=1; indx<25; indx++))
do
element=${all_ary[$indx]}
if [ "`file -b $element`" = "directory" ]
then
        normal_directory_GUI $x $y
        line_setting
elif [ "`ls -l $element | cut -c 1`" = "-" ]
then
        if [ "`ls -l $element | cut -c -10 | grep [x]`" ]
        then
        excution_file_GUI $x $y
        line_setting
        else
        normal_file_GUI $x $y
        line_setting
        fi
else
        special_file_GUI $x $y
        line_setting
fi
done

elif [ $p -gt 1 ] && [ $p -lt 25 ]
then
for ((indx=1; indx<$p; indx++))
do
element=${all_ary[$indx]}
if [ "`file -b $element`" = "directory" ]
then
        normal_directory_GUI $x $y
        line_setting
elif [ "`ls -l $element | cut -c 1`" = "-" ]
then
        if [ "`ls -l $element | cut -c -10 | grep [x]`" ]
        then
        excution_file_GUI $x $y
        line_setting
        else
        normal_file_GUI $x $y
        line_setting
        fi
else
        special_file_GUI $x $y
        line_setting
fi
done
fi
}

#스크롤 기능 수행 함수, 처음 인덱스가 있는 값의 줄부터 마지막 인덱스가 있는 줄까지 정해줌
scroll()
{
element_end=`expr $2 \* 5`
element_end=`expr $element_end + 24`

if [ $element_end -ge $p ]
then
for ((scroll_indx=$1; scroll_indx<$p; scroll_indx++))
do
element=${all_ary[$scroll_indx]}
if [ "`file -b $element`" = "directory" ]
then
        normal_directory_GUI $x $y
        line_setting
elif [ "`ls -l $element | cut -c 1`" = "-" ]
then
        if [ "`ls -l $element | cut -c -10 | grep [x]`" ]
        then
        excution_file_GUI $x $y
        line_setting
        else
        normal_file_GUI $x $y
        line_setting
        fi
else
        special_file_GUI $x $y
        line_setting
fi
done
else
for ((scroll_indx=$1; scroll_indx<=$element_end; scroll_indx++))
do
element=${all_ary[$scroll_indx]}
if [ "`file -b $element`" = "directory" ]
then
        normal_directory_GUI $x $y
        line_setting
elif [ "`ls -l $element | cut -c 1`" = "-" ]
then
        if [ "`ls -l $element | cut -c -10 | grep [x]`" ]
        then
        excution_file_GUI $x $y
        line_setting
        else
        normal_file_GUI $x $y
        line_setting
        fi
else
        special_file_GUI $x $y
        line_setting
fi
done
fi
}

list_count=1      #처음 줄 초기화
x=36              #아이콘이 시작되는 x위치
y=1               #아이콘이 시작되는 y위치

#4번 레이블 출력
all_species_size()
{
tput cup 38 20
echo -n "`expr $p - 1` total"
tput cup 38 30
echo -n "$d dir"
tput cup 38 38
echo -n "$f file"
tput cup 38 48
echo -n "$s Sfile"
tput cup 38 60
#총용량 계산
total_size=0
declare -i ts
for list_size in `ls -l | cut -c 31-36`
do
ts=$list_size
total_size=`expr $total_size + $ts`
done
echo -n "$total_size byte"
}

#5개씩 출력하기 위한 셋팅
line_setting()
{
list_count=`expr $list_count + 1`
if [ `expr $list_count % 5` -eq 0 ] 
then
	y=`expr $y + 5`
	x=21
else
	x=`expr $x + 15`
fi

}

#반전시키기
reverse()
{
if [ $all_ary_index -eq 0 ]
then
	tput rev
	excution_directory_GUI $cursor_x $cursor_y
	file_info
else
if [ "`file -b $element`" = "directory" ]
then
	tput rev
	normal_directory_GUI $cursor_x $cursor_y
	elif [ "`ls -l $element | cut -c 1`" = "-" ]
	then
		if [ "`ls -l $element | cut -c -10 | grep [x]`" ]
		then
		tput rev
		excution_file_GUI $cursor_x $cursor_y
		else
		tput rev
		normal_file_GUI $cursor_x $cursor_y
		fi
	else
	tput rev
	special_file_GUI $cursor_x $cursor_y
fi
fi
file_info
}
cursor_x=22
cursor_y=1             #초기 커서 위치
main_display           #초기 화면 출력
all_ary_index=0        #현재 디렉토리 안의 디렉토리, 파일을 저장한 배열 인덱스
start=0                #화면상 처음 출력하고자 하는 값이 있는 줄
end=0                  #화면상 마지막으로 출력하고자 하는 값이 있는 줄
scroll_line_count=0

#이동하면 처음 출력하고자하는 배열의 인덱스를 바꾸는 함수
move()
{
if [ $start -lt 5 ]
then
excution_directory_GUI 21 1
fi
if [ $all_ary_index -ge 0 ] && [ $all_ary_index -lt 25 ]
then
        element=${all_ary[ $all_ary_index ]}
        reverse
elif [ $all_ary_index -ge 25 ] && [ $all_ary_index -lt $p ]
then
        element=${all_ary[ $all_ary_index ]}
        reverse
else
for((erase_line=31; erase_line<=36; erase_line++))
do
        tput cup $erase_line 20
        tput el
        tput cup $erase_line 100
        echo "|"
done
fi
tput sgr0
tput cup $cursor_y $cursor_x
}

copy_index=0
move_index=0
copy_pwd=`pwd`           #복사하려는 대상의 경로
move_pwd=`pwd`           #이동하려는 대상의 경로
paste_pwd=`pwd`          #복사하여 붙어넣으려는 디렉토리 경로
ctrl_v_pwd=`pwd`         #잘라내서 붙어넣으려는 디렉토리 경로

while [ true ]           #여기서부터 커서 계속해서 움직이는 작업
do

print_high_rank_list     #1번레이블 출력(상위 디렉토리 목록)
tput cup 38 0; echo "|"  
redeclare                #현재 디렉토리에있는 구성들을 배열에 담기위해 배열 선언 및 초기화
assignment               #전체 목록을 배열에 담기 위한 할당
all_species_size         #4번레이블 출력(현재 디렉토리의 구성 종류 개수 및 용량)

if [ $end -eq 0 ]
then
print_element
else
scroll $start $end
fi

move

read -s -n 1 key1
if [ "$key1" = "" ]                 #방향키 입력 받을 때
then

read -s -n 1 key2
if [ "$key2" = "[" ]
then

read -s -n 1 key3
#up
if [ "$key3" = "A" ] && [ $cursor_y -gt 1 ]
then
cursor_y=`expr $cursor_y - 5`
tput cup $cursor_y $cursor_x
all_ary_index=`expr $all_ary_index - 5`

#scroll_up
elif [ "$key3" = "A" ] && [ $cursor_y -eq 1 ] && [ $all_ary_index -ge 5 ]
then
all_ary_index=`expr $all_ary_index - 5`
start=`expr $start - 5`
end=`expr $end - 1`
scroll_line_count=`expr $scroll_line_count - 1`

#down
elif [ "$key3" = "B" ] && [ $cursor_y -lt 21 ]
then
if [ $all_ary_index -lt `expr $p - 5`  ]
then
cursor_y=`expr $cursor_y + 5`
tput cup $cursor_y $cursor_x
all_ary_index=`expr $all_ary_index + 5`
fi

#scroll down
elif [ "$key3" = "B" ] && [ $cursor_y -eq 21 ] && [ $all_ary_index -lt `expr $p - 5` ]
then
if [ $all_ary_index -ge 20 ]
then
all_ary_index=`expr $all_ary_index + 5`
start=`expr $start + 5`
end=`expr $end + 1`
scroll_line_count=`expr $scroll_line_count + 1`
fi

#right
elif [ "$key3" = "C" ] && [ $cursor_x -lt 82 ] && [ $all_ary_index -lt `expr $p - 1` ]
then
cursor_x=`expr $cursor_x + 15`
tput cup $cursor_y $cursor_x
all_ary_index=`expr $all_ary_index + 1`

#right down(스크롤 & 한줄 내리기) 
elif [ "$key3" = "C" ] && [ $cursor_x -eq 82 ]
then
if [ $cursor_y -eq 21 ]
then
cursor_x=22; cursor_y=21
all_ary_index=`expr $all_ary_index + 1`
start=`expr $start + 5`
end=`expr $end + 1`
scroll_line_count=`expr $scroll_line_count + 1`
else
cursor_x=22; cursor_y=`expr $cursor_y + 5`
tput cup $cursor_y $cursor_x
all_ary_index=`expr $all_ary_index + 1`
fi

#left
elif [ "$key3" = "D" ] && [ $cursor_x -gt 22 ]
then
cursor_x=`expr $cursor_x - 15`
tput cup $cursor_y $cursor_x
all_ary_index=`expr $all_ary_index - 1`

#left up(스크롤 & 한줄 올리기)
elif [ "$key3" = "D" ] && [ $cursor_x -eq 22 ]
then
if [ $cursor_y -eq 1 ]
then
cursor_x=82; cursor_y=1
all_ary_index=`expr $all_ary_index - 1`
start=`expr $start - 5`
end=`expr $end - 1`
scroll_line_count=`expr $scroll_line_count - 1`
else
cursor_x=82; cursor_y=`expr $cursor_y - 5`
tput cup $cursor_y $cursor_x
all_ary_index=`expr $all_ary_index - 1`
fi
fi
fi

#copy
elif [ "$key1" = "c" ] && [ $copy_index -lt 3 ]
then
copy_ary[$copy_index]=${all_ary[$all_ary_index]}
copy_index=`expr $copy_index + 1`
copy_pwd=`pwd`

#move
elif [ "$key1" = "m" ] && [ $move_index -lt 3 ]
then
move_ary[$move_index]=${all_ary[$all_ary_index]}
move_index=`expr $move_index + 1`
move_pwd=`pwd`

#paste
elif [ "$key1" = "p" ] && [ $copy_index -gt 0 ]
then
paste_pwd=`pwd`
redeclare
for copy_item in ${copy_ary[*]}
do
cp -a -f "$copy_pwd/$copy_item" $paste_pwd
copy_index=`expr $copy_index - 1`
done
assignment

#Ctrl+V
elif [ "$key1" = "v" ] && [ $move_index -gt 0 ]
then
ctrl_v_pwd=`pwd`
redeclare
for move_item in ${move_ary[*]}
do
mv -f "$move_pwd/$move_item" $ctrl_v_pwd
move_index=`expr $move_index - 1`
done
assignment

elif [ -z $key1 ]                  #스페이스바 입력받을 때 
then
#실행파일-실행
if [ "`ls -l $element | cut -c 1`" = "-" ] && [ "`ls -l $element | cut -c -10 | grep [x]`" ]
then
if [ $all_ary_index -gt 0 ]
then
	clear
	tput cup 40 0
	bash $element
	clear
	main_display
	tput cup $cursor_y $cursor_x
fi
#디렉토리-이동
elif [ "`file -b $element`" = "directory" ] && [ $all_ary_index -gt 0 ]
then
	cd $element
	redeclare
	for ((l=1; l<=20; l++))
	do
		tput cup $l 1
		echo "            "
	done
	tput cup 38 0; tput el
	tput cup 38 100; echo "|"
	assignment
	all_ary_index=0
	cursor_x=22; cursor_y=1
elif [ $cursor_x -eq 22 ] && [ $cursor_y -eq 1 ]
then
	cd ..
	redeclare
	for ((l=1; l<=20; l++))
	do
		tput cup $l 1
		echo "            "
	done
	tput cup 38 0; tput el
	tput cup 38 100; echo "|"
	assignment
	all_ary_index=0
	cursor_x=22; cursor_y=1
	fi

fi
#GUI 갱신
for((erase_line=1; erase_line<=26; erase_line++))
do
tput cup $erase_line 21
tput el
tput cup $erase_line 100
echo "|"
done

if [ $end -eq 0 ]
then
list_count=1
x=36
y=1
else
list_count=5
x=21
y=1
fi

done

