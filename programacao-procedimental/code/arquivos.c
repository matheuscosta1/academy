// C program for writing
// struct to file
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// a struct to read and write
struct person
{
	int id;
	char fname[20];
	char lname[20];
};

int main ()
{
	FILE *outfile;
	
	// open file for writing
	outfile = fopen ("person.txt", "w");
	if (outfile == NULL)
	{
		fprintf(stderr, "\nError opened file\n");
		exit (1);
	}

	struct person input1 = {1, "rohan", "sharma"};
	struct person input2 = {2, "mahendra", "dhoni"};
    struct person input;
	
	// write struct to file
	fwrite (&input1, sizeof(struct person), 1, outfile);
	fwrite (&input2, sizeof(struct person), 1, outfile);
	
	if(fwrite != 0)
		printf("contents to file written successfully !\n");
	else
		printf("error writing file !\n");

	fclose (outfile);

    FILE *infile = fopen ("person.txt", "r");
  
    while(fread(&input, sizeof(struct person), 1, infile))
        printf ("id = %d name = %s %s\n", input.id,
        input.fname, input.lname);

	// close file
    fclose (infile);


	return 0;
}
