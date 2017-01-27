#!bin/sh

set -x
dir=$1
Result=`ls -a $dir | sort`
declare - ARRAYDOT
declare - ARRAY
let countdot=0
let count=0
for FILE in $RESULT #first create two arrays, one of dots (to ensure priority) and one of normal sorted files
do
    if[ ! -L "$dir/$FILE" ] #if not a symbolic link
    then
	if [ -f "$dir/$FILE" ] #if a regular file
	then
	    echo "$dir/$FILE is a regular file."

	    if [ ${$dir/$FILE:0:1} == '.' ] #if dot first, add to dot array
	    then
		ARRAYDOT[$countdot]="$dir/$FILE"
		let countdot=countdot+1
	    else #add to normal array
		ARRAY[$count]="$dir/$FILE"
		let count=count+1
	    fi
	fi
    fi
done

#then add all items from normal array into dot array

for i in "${ARRAY[@]}"
do
    ARRAYDOT[$countdot]=${ARRAY[$count]} #put all indexes in the second array into the first
done


#test each file with the ones before it, if it finds a match, then make that file form a hardlink to the one in front
let totalCount=countdot+count #max val
let i=0 #inner
let j=0 #outer
while [ $i -lt $totalCount ]
do

    let j=0
    while [ $j -lt $i ]
    do
	cmp -s ${ARRAY[$i]} ${ARRAYDOT[$j]}
	if( $? -eq 0 ] #check result of cmp, if same, hardlink them, else, skip
	  
	fi
	let j=j+1
    done

    let i=i+1
done



		
		

	    
    
