#include<stdio.h>
#include<stdlib.h>
int main(int argc, char const *argv[]){
	if (argc != 3) {
		printf("Please provide two files!\n");
		exit(-1);
	} else {
		FILE *fr, *fw;

		fr = fopen(argv[1], "r");
		if (fr == NULL) {
			printf("Read file doesn't exist!\n");
			exit(-1);
		}
		
		fw = fopen(argv[2], "w");
		if (fw == NULL) {
			printf("Can't create new file!for writing\n");
			exit(-1);
		}
		
		char buf[1000];
		while (fgets(buf, 1000, fr) != NULL){
			int i = 0;
			while (buf[i] == ' '){
				++i;
			}
			fputs(&buf[i], fw);
		}

		fclose(fr);
		fclose(fw);
	}
	return 0;
}