#디렉토리 안으로 접근하기 위한 설정
cd $subelement

#파일 정보 출력 함수
file_info()
{
echo [0m"        2)File size : `stat --printf=%s $element`"
echo -e "\t3)Time of last data modification : `stat --printf=%y $element`"
echo -e "\t4)Permission : `stat --printf=%a $element`"
echo -e "\t5)Absolute path : `pwd $element`"

while [ "`pwd $element | cut -d / -f $path_cnt`" ]
do
       	path_cnt=`expr $path_cnt + 1`
done
path_cnt=`expr $path_cnt - 1`
echo -e "\t6)Relative path : ./`pwd $element | cut -d / -f $path_cnt`/$element"
echo -e "\t-------------------------------------------------"

index=`expr $index + 1`
}

declare -a special_ary #특수파일 저장 배열
index=1 #파일 순서 인덱스
n=0 #특수파일 저장 배열 인덱스

for element in `ls --group-directories-first` 
do
path_cnt=2
	if [ "`file -b $element`" = "directory" ]
	then
		echo -e "\t[$index] $subelement/`stat --printf=%n $element`"
		echo -e "\t-------------------Information-------------------"
		echo [34m"        1)File type : `stat --printf=%F $element`"
		file_info

	elif [ "`ls -l $element | cut -c 1`" = "-" ]
	then
		echo -e "\t[$index] $subelement/`stat --printf=%n $element`"
		echo -e "\t-------------------Information-------------------"
		echo -e "\t1)File type : `stat --printf=%F $element`"
		file_info
	else
		special_ary[n]=$element
		n=`expr $n + 1`
	fi
done

#특수파일 저장된 배열 출력 반복문
for special in ${special_ary[*]}
do
path_count=2 
echo -e "\t[$index] $subelement/`stat --printf=%n $special`"
echo -e "\t-------------------Information-------------------"
echo [32m"        1)File type : `stat --printf=%F $special`"
echo [0m"        2)File size : `stat --printf=%s $special`"
echo -e "\t3)Time of last data modification : `stat --printf=%y $special`"
echo -e "\t4)Permission : `stat --printf=%a $special`"
echo -e "\t5)Absolute path : `pwd $special`"

        while [ "`pwd $special | cut -d / -f $path_count`" ]
        do
                path_count=`expr $path_count + 1`
        done
        path_count=`expr $path_count - 1`
       
echo -e "\t6)Relative path : ./`pwd $special | cut -d / -f $path_count`/$special"
        echo -e "\t-------------------------------------------------"

        index=`expr $index + 1`
done
