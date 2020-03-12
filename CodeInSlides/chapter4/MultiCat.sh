if [ "x$1$2" == "x$1" ]
then
echo "Input arg1[filename], arg2[times]"
exit
fi

for ((i=0;i<$2;i++))
do
	cat $1
done