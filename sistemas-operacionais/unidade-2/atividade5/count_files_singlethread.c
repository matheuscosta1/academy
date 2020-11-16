#include <stdio.h>
#include <time.h>
#include <dirent.h>
#include <string.h>
#include <stdlib.h>

int listdir(const char *name, int nextPath)
{
    DIR *directory;
    struct dirent *entry;
    int count = 0;

    if (!(directory = opendir(name)))
        return -1;
    count += 1;
    
    while ((entry = readdir(directory)) != NULL) {
        if (entry->d_type == DT_DIR) {
            char path[1024];
            if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0){
                continue;
            }
            snprintf(path, sizeof(path), "%s/%s", name, entry->d_name);
            count += listdir(path, nextPath + 1);
        } else {
            count += 1;
        }
    }

    closedir(directory);
    return count;
}

int main() {

    int numberOfFiles;

    char *path = malloc(100*sizeof(path));

    printf("Enter a directory to be calculated the size of files: "); scanf("%s",&(*path));
    numberOfFiles = listdir(path, 0); 
    printf("Number of files: %d\n", numberOfFiles);
               
    return 0;
}