#include <stdio.h>
#include <time.h>
#include <dirent.h>
#include <string.h>
#include <stdlib.h>
#define NUM_THREADS 2

typedef struct thread_data {
   const char *name;
   int nextPath;
} thread_data;


void *listdir(void *args)
{
    DIR *directory;
    struct dirent *entry;
    int count = 0;;

    thread_data *tdata = args;

    if (!(directory = opendir(tdata->name)))
        return -1;

    count += 1;
    while ((entry = readdir(directory)) != NULL) {
        if (entry->d_type == DT_DIR) {
            char path[1024];
            if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0){
                continue;
            }
            snprintf(path, sizeof(path), "%s/%s", tdata->name, entry->d_name);
            tdata->name = path;
            tdata->nextPath +=  1;
            count += listdir((void *)&(*tdata));
        } else {
            count += 1;
        }
    }

    closedir(directory);
    printf("Count directory %s 2 %d\n", tdata->name, count);
    pthread_exit();
}


int main() {

    int numberOfFiles;
    char *path = malloc(100*sizeof(path));
    pid_t pids[8];
    int i, j, err, status;
    int numeroProcessadores = 8;
    pthread_t threads[8];

    // FILE * fp;
    // fp = fopen ("/home/matheus/sistemas-operacionais/unidade-2/atividade5/count_files_multiprocess_multithreaded","w");
    
    #define NUMBER_OF_STRING 25
    #define MAX_STRING_SIZE 40

    char arr[NUMBER_OF_STRING][MAX_STRING_SIZE] =
    { 
        "/bin",
        "/boot",
        "/cdrom",
        "/dev",
        "/etc",
        "/home",
        "/usr/lib",
        "/usr/lib32",
        "/usr/lib64",
        "/lost+found",
        "/media",
        "/mnt",
        "/opt",
        "/osqueryd.pid",
        "/proc",
        "/root",
        "/run",
        "/usr/sbin",
        "/snap",
        "/srv",
        "/swapfile",
        "/tmp",
        "/usr",
        "/var"
    };

    struct thread_data args;
    


    for (int i = 0; i < NUMBER_OF_STRING; i++)
    {
        args.name = arr[i];
        args.nextPath = 0;
        for(j=0; j < NUM_THREADS; j++){
            printf("Start to count files from %s directory: ", args.name);
            pthread_create(&threads[j], NULL, listdir, (void*)&args);
            pthread_join(threads[j], (void*)&args);
        }
        for(j=0; j < NUM_THREADS; j++){
            pthread_join(threads[j], (void*)&args);
        }
    }

    printf("%s / %d\n", args.name, args.nextPath);

    return 0;
}