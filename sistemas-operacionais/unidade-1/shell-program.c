#include <stdio.h>
#include <time.h>
#include <dirent.h>
#include <string.h>

#include <readline/readline.h>

#define BADKEY -1
#define EXIT 0
#define CLS 1
#define DIRETORIO 2
#define DATE 3
#define TIME 4
#define HELP 5

typedef struct { char *key; int val; } key_value_struct;

static key_value_struct helptable[] = {
    { "exit", EXIT }, { "cls", CLS }, { "dir", DIRETORIO }, { "date", DATE }, { "time", TIME }, { "help", HELP }
};

#define NUMBER_KEYS (sizeof(helptable)/sizeof(key_value_struct))

int keyfromstring(char *key)
{
    int i;
    for (i=0; i < NUMBER_KEYS; i++) {
        key_value_struct *key_value  = malloc(sizeof(key_value_struct));
        *key_value = helptable[i];
        if (strcmp(key_value->key, key) == 0)
            return key_value->val;
    }
    return BADKEY;
}


int readInput(char* str) {
    char* buf;

    buf = readline("\nmini-shell$ ");
    if (strlen(buf) != 0) {
        strcpy(str, buf);
        return 0;
    } else {
        return 1;
    }
}

int clear_screen() {
    printf("\e[1;1H\e[2J");

    return 0;
}

struct tm datetime() {
    time_t t = time(NULL);
    struct tm time_s = *localtime(&t);

    return time_s;
}

int list() {
    DIR *directory;
    struct dirent *ep;
    directory = opendir(".");

    if (directory != NULL) {
        while (ep = readdir(directory)) {
            if (ep->d_type == DT_DIR)   
                printf("%s (dir)\n", ep->d_name);
            else
                printf("%s\n", ep->d_name);
        }
        closedir(directory);

        return 0;
    } else
        return -1;
}

void help() {
    printf("Available commands:\n"
            "cls - clear screen like 'clear' command\n"
            "date - show current date \n"
            "time - show current time \n"
            "dir - show files and folders in current directory like 'ls' command\n"
            "help - print this message\n"
            "exit - exit from this program\n");
}

int main() {

    char command[50];
    struct tm time_s;

    while(1) {

        readInput(command);

        switch(keyfromstring(command)){
            case(0):
                return -1;
            case(1):
                clear_screen(); continue;
            case(2):
                list(); continue;
            case(3): 
                time_s = datetime();
                printf("%02d/%02d/%02d\n", time_s.tm_mday,
                    time_s.tm_mon + 1,
                    time_s.tm_year + 1900);
                continue;
            case(4):
                time_s = datetime();
                printf("%02d/%02d/%02d\n", time_s.tm_hour, time_s.tm_min,time_s.tm_sec);
                continue;
            case(5):
                help();
                continue;
            default:
                printf("command not found: %s\n", command);
        }
    }

    return 0;
}