echo "=== print file information ==="

echo "current directory : `pwd`"
echo "the number of elements : `ls | wc -w`"
echo ""

#파일정보출력함수
file_info()
{
	echo [0m"2)File size : `stat --printf=%s $element`"
	echo "3)Time of last data modification : `stat --printf=%y $element`"
	echo "4)Permission : `stat --printf=%a $element`"
	echo "5)Absolute path : `pwd $element`"

	while [ "`pwd $element | cut -d / -f $path_cnt`" ]
	do
        	path_cnt=`expr $path_cnt + 1`
	done
	path_cnt=`expr $path_cnt - 1`
	echo "6)Relative path : ./`pwd $element | cut -d / -f $path_cnt`"
	echo "-------------------------------------------------"

	index=`expr $index + 1`
}

declare -a special_ary #특수파일 저장 배열
index=1 #디렉토리나 파일 출력시 번호 순서 인덱스
n=0 #특수파일 저장 배열의 인덱스

for element in `ls --group-directories-first` 
do
path_cnt=2
	if [ "`file -b $element`" = "directory" ] #디렉토리를 걸러냄
	then
		echo "[$index] `stat --printf=%n $element`"
		echo "-------------------Information-------------------"
		echo [34m"1)File type : `stat --printf=%F $element`"
		file_info

		#디렉토리안에 파일이 있을 경우 안으로 들어가기 위한 설정
		if [ `ls -a $element | wc -l` -gt 2 ] 
		then
			export subelement=$element
			bash 2014726074_ChoiKyungJin_sub.sh
		fi
	
	elif [ "`ls -l $element | cut -c 1`" = "-" ] #일반파일을 걸러냄
	then
		echo "[$index] `stat --printf=%n $element`"
		echo "-------------------Information-------------------"
		echo "1)File type : `stat --printf=%F $element`"
		file_info
	#특수파일을 걸러냄
	else 
		special_ary[n]=$element
		n=`expr $n + 1`
	fi
done

#특수파일 출력 반복문
for special in ${special_ary[*]}
do
path_count=2 
	echo "[$index] `stat --printf=%n $special`"
	echo "-------------------Information-------------------"
	echo [32m"1)File type : `stat --printf=%F $special`"
	echo [0m"2)File size : `stat --printf=%s $special`"
        echo "3)Time of last data modification : `stat --printf=%y $special`"
        echo "4)Permission : `stat --printf=%a $special`"
        echo "5)Absolute path : `pwd $special`"

        while [ "`pwd $special | cut -d / -f $path_count`" ]
        do
                path_count=`expr $path_count + 1`
        done
        path_count=`expr $path_count - 1`
       
	echo "6)Relative path : ./`pwd $special | cut -d / -f $path_count`"
        echo "-------------------------------------------------"

        index=`expr $index + 1`
done
