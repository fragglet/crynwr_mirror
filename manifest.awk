# defer printing of a line until we see that it is not a proper prefix of
#   the following line.

BEGIN {
	system("DIR /B >\\$$$");
	while(getline <"\\$$$") {
		files[$0] = "y"
	}
}

($1 in files) {
	delete files[$1]
	print
	next
}

{
	print "!!!!!!!!!!!!  Following file is in manifest but doesn't exist"
	print
}

END {
	for (i in files) {
		printf("%-12s  !!! not listed in manifest !!!\n", i)
	}
}
