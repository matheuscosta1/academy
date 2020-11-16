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
    pid_t pids[8];
    int i, status;
    int numeroProcessadores = 8;
    FILE * fp;
    fp = fopen ("/home/matheus/sistemas-operacionais/unidade-2/atividade5/count-files-multiprocess-singleathreaded","w");

    printf("PID=%d: Processo Pai\n", getpid());
    for(int i=0; i < numeroProcessadores; i++){
        pids[i] = vfork();
        if (pids[i] > 0 ) {
            /* Pai */
            printf("PID=%d: i=%d\n",getpid(), i);
            pids[i] = wait(&status);
        } else if (pids[i] == 0 ){
            switch(i){
                case 0:
                    fprintf(fp, "%d\n", listdir("/bin", 0));
                    fprintf(fp, "%d\n", listdir("/boot", 0));
                    fprintf(fp, "%d\n", listdir("/cdrom", 0));
                    fprintf(fp, "%d\n", listdir("/dev", 0));
                    break;
                case 1:
                    fprintf(fp, "%d\n", listdir("/etc", 0));
                    fprintf(fp, "%d\n", listdir("/home", 0));
                    break;
                case 2:
                    fprintf(fp, "%d\n", listdir("/usr/lib", 0));
                    fprintf(fp, "%d\n", listdir("/usr/lib32", 0));
                    fprintf(fp, "%d\n", listdir("/usr/lib64", 0));
                    fprintf(fp, "%d\n", listdir("/usr/libx32", 0));
                    break;
                case 3:
                    fprintf(fp, "%d\n", listdir("/lost+found", 0));
                    fprintf(fp, "%d\n", listdir("/media", 0));
                    fprintf(fp, "%d\n", listdir("/mnt", 0));
                    break;
                case 4:
                    fprintf(fp, "%d\n", listdir("/opt", 0));
                    fprintf(fp, "%d\n", listdir("/osqueryd.pid", 0));
                    fprintf(fp, "%d\n", listdir("/proc", 0));
                    break;
                case 5:
                    fprintf(fp, "%d\n", listdir("/root", 0));
                    fprintf(fp, "%d\n", listdir("/run", 0));
                    fprintf(fp, "%d\n", listdir("/usr/sbin", 0));
                    fprintf(fp, "%d\n", listdir("/snap", 0));
                    break;
                case 6:
                    fprintf(fp, "%d\n", listdir("/srv", 0));
                    fprintf(fp, "%d\n", listdir("/swapfile", 0));
                    fprintf(fp, "%d\n", listdir("/tmp", 0));
                    fprintf(fp, "%d\n", listdir("/usr", 0));
                    break;
                case 7:
                    fprintf(fp, "%d\n", listdir("/var", 0));
                    break;
            }
                
            printf("PID=%d: i=%d\n",getpid(), i);
        }
        printf("Finalizando - PID=%d: i=%d\n",getpid(),i);
    }

    fclose (fp);

    fp = fopen ("/home/matheus/sistemas-operacionais/unidade-2/atividade5/count-files-multiprocess-singleathreaded","r");

    int sum = 0, value;
    while(fscanf(fp, "%d", &value) == 1)
    {
        sum += value;
    }
    printf("O numero total de arquivos da partição / é: %d\n", sum);
    fclose (fp);
    return 0;
}