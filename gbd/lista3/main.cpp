#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <fstream>

using namespace std;

/**
 *  Desenvolvido e testado no Linux: 
 *      g++ -o main main.cpp && ./main
 * 
 *  Authors:
 *   Rafael Valentim     11711BCC010
 *   Matheus José        11711BCC008
 *   Leonardo Essia      11712BCC009
**/

void removeUnwantedCaracteres (char *word) {
    int length = strlen(word);
    if (
        (word[length-1] == '.') || (word[length-1] == ',') || (word[length-1] == ';') ||
        (word[length-1] == ':') || (word[length-1] == '?') || (word[length-1] == '!')
       )
        word[length-1] = '\0';
}

void printLine(int offset,FILE *f) {
    int position = ftell(f);
    char line[2048];

    while (position < offset) {
        fgets(line, 2047, f);
        position = ftell(f);
    }

    printf("%s", line);
}

class InvertedList {
public:
    
    typedef struct secondary_list {
        char word[100];
        int quantity;
        int offset_list;
        struct secondary_list *next;
    } SECONDARY_LIST;

    typedef struct inverted_list {
        int offset;
        int next;
    } INVERTED_LIST; 

    FILE* f;
    SECONDARY_LIST* first_register = NULL;

    InvertedList(){ 
        f = fopen("inverted-list.dat", "wb+"); 
    }

    ~InvertedList(){  
        destroy_secondary_list();
        fclose(f);    
    }

    void add_word(char *word, int offset){
         if(first_register == NULL){
            
            first_register = new_secondary_list();
            
            strcpy(first_register->word, word);
            
            if(!insert_on_inverted_list(first_register,offset)){
                printf("Insert on list error. Finishing..."); 
                exit(1);
            }
            return;
        }

        SECONDARY_LIST* aux_secondary_list = first_register;
        SECONDARY_LIST* previous = NULL;

        int cmp;
        
        while(1){
            cmp = strcmp(word, aux_secondary_list->word);
            if(cmp == 0){
                break;
            }
            if(aux_secondary_list->next == NULL){

                aux_secondary_list->next = new_secondary_list();
                strcpy(aux_secondary_list->next->word, word);
                aux_secondary_list = aux_secondary_list->next;

                break;
            }

            if(cmp < 0){
                SECONDARY_LIST* novo = new_secondary_list();
                strcpy(novo->word, word);

                if(previous!=NULL){
                    previous->next = novo;
                }else{
                    first_register = novo;
                }

                novo->next = aux_secondary_list;
                aux_secondary_list = novo;

                break;
            }
            previous = aux_secondary_list;
            aux_secondary_list = aux_secondary_list->next;
        }

        if(!insert_on_inverted_list(aux_secondary_list, offset)){
            printf("Insert on list error!! Finishing..."); 
            exit(1);
        }
    }

    int * fetch(char *word, int *quantity) {

        SECONDARY_LIST* secondary_list_key = fetch_register_by_word(word);

        if(secondary_list_key == NULL){
            printf("Word not found...");
            return NULL;
        }

        INVERTED_LIST r;
        fseek(f, secondary_list_key->offset_list, SEEK_SET);
        fread(&r, sizeof(INVERTED_LIST), 1, f);

        quantity[0] = secondary_list_key->quantity;

        int *offsets = new int[*quantity];

        for(int i=0; i < quantity[0]; i++){
            offsets[i] = r.offset;
            fseek(f, r.next, SEEK_SET);
            fread(&r, sizeof(INVERTED_LIST), 1, f);
        }

        return offsets;
    }
private:

    void destroy_secondary_list(){

        if(first_register == NULL) return;

        SECONDARY_LIST* aux_secondary_list;

        while(1){
            aux_secondary_list =  first_register -> next;

            free(first_register);

            if(aux_secondary_list -> next == NULL){
                break;
            }

            first_register = aux_secondary_list -> next;
        }
        return;
    }

    SECONDARY_LIST* new_secondary_list(){

        SECONDARY_LIST* secondary_list_register;

        secondary_list_register = (SECONDARY_LIST*) malloc(sizeof(SECONDARY_LIST));

        secondary_list_register->offset_list = -1;
        secondary_list_register->quantity = 0;
        secondary_list_register->next = NULL;

        return secondary_list_register;
    }

    int insert_on_inverted_list(SECONDARY_LIST* secondary_list_register, int offset){
        if(secondary_list_register == NULL){
            return 0;
        }

        INVERTED_LIST r;
        r.offset = offset;
        r.next = -1;

        int current_register = secondary_list_register->offset_list;

        INVERTED_LIST current;
        INVERTED_LIST previous;

        int previous_offset= -1;

        while(1){
            if(current_register == -1){
                break;
            }

            fseek(f, current_register, SEEK_SET);
            fread(&current, sizeof(INVERTED_LIST), 1, f);

            if(offset<=current.offset){
                break;
            }

            previous = current;
            previous_offset = current_register; 
            current_register = current.next;
        }

        r.next = current_register; 
        fseek(f, 0, SEEK_END); 
        
        int r_offset = ftell(f);
        fwrite(&r, sizeof(INVERTED_LIST), 1, f);

        if(previous_offset != -1){
            previous.next = r_offset;
            fseek(f, previous_offset, SEEK_SET);
            fwrite(&previous, sizeof(INVERTED_LIST), 1, f); 
        }else{
            secondary_list_register->offset_list = r_offset;
        }
        secondary_list_register->quantity++;
        return 1;

    }

    SECONDARY_LIST* fetch_register_by_word(char* word){
            int cmp = strcmp(word,first_register->word);
            if(cmp == 0)
            {
                //encontrou a word
                return first_register;
            }
            SECONDARY_LIST* aux_secondary_list =  first_register->next;
            while(aux_secondary_list != NULL){
                cmp = strcmp(word, aux_secondary_list->word);
                if(cmp == 0){
                    return aux_secondary_list;
                }else if(cmp < 0){
                    return NULL;
                }
                aux_secondary_list = aux_secondary_list->next;
            }
            return NULL;
    }
};

int main(int argc, char** argv) {

    ifstream in("biblia.txt");

    if (!in.is_open()){
        printf("\n\nCould not open file biblia.txt.\n\n\n\n");
    }
    else {

        char *word = new char[100];
        int offset, word_counter = 0;

        InvertedList list;

        while (!in.eof()) {
            in >> word;

            offset = in.tellg();

            removeUnwantedCaracteres(word);

            if (!((word[0] == '#') || (word[0] == '[') || ((word[0] >= '0') && (word[0] <= '9')))) {

                printf("%d %s\n", offset,word); fflush(stdout);

                list.add_word(word, offset);

                word_counter++;

                if (word_counter % 1000 == 0) { 
                    printf(".");  
                    fflush(stdout); 
                }
            }
        }

        in.close();

        do {

            printf("\nType the word you want to find or \"EXIT\" to exit: ");
            scanf("%s", word);

            if (strcmp(word,"EXIT") != 0) {

                int quantity;
                int *offsets = list.fetch(word, &quantity);

                if (quantity > 0) {
                    FILE *f = fopen("biblia.txt","rt");
                    for (int i = 0; i < quantity; i++)
                        printLine(offsets[i],f);
                    fclose(f);
                }
                else
                    printf("Not found word: %s\n",word);
            }
        } while (strcmp(word,"EXIT") != 0);

        printf("\n\nSee you soon!\n\n");
    }

    return (EXIT_SUCCESS);
}

