#include <stdio.h>

int main(int argc, char *argv[]) {

	int i;

	printf("Pie pie your all pie\n");
	
	for (i = 0; i < argc; i++) {
		printf("%d:\t%s\n", i, argv[i]);
	}
	
	

}

