if [ -z "$1" ]
then
	echo "Usage 'JavaRunner <Path To Main Instance>'";
	exit
fi

getClasspath() {
	local classpaths=""
	while read p
	do
		classpaths+="$p:"
	done < classpath
	classpaths+="."
	
	echo $classpaths
}

compileFilesInFolder() {
	for d in */
	do
		( javac -d ../bin "$d"/*.java )
	done
}
run() {
	local dir=$pwd
	cd ..
	mkdir -p bin
	cd bin
	java -cp ../$2 $1
	cd $dir
}

classpath=$(getClasspath)
compileFilesInFolder
run $1 $classpath
