#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int
split(int divisor, char *input, char *base)
{
    FILE **fplist   = NULL;
    FILE  *fp       = NULL;
    int    c_start  = 0;
    int    c_end    = 0;
    int    quotient = 0;
    int    toomuch  = 0;
    int    total    = 0;
    int    part     = 0;
    int    cnt      = 0;
    int    no       = 0;
    char   buf[2048];

    fplist = calloc(sizeof(FILE *),divisor);
    if (!fplist) {
        fprintf(stderr,"calloc error!\n");
        return(1);
    }

    fp = fopen(input,"r");
    if (!fp) {
        fprintf(stderr,"Can't open file[%s]\n",input);
        return(1);
    }
    while(fgets(buf, sizeof(buf), fp)) {
        total++;
    }
    if (fclose(fp)) {
        fprintf(stderr,"Can't open file[%s]\n",input);
        return(1);
    }

    quotient = total / divisor;
    toomuch  = total % divisor;

    for(no=0;no<divisor;no++) {
        char file[128];
        sprintf(file,"%s%02d",base,no);
        fp = fopen(file,"w");
        if (!fp) {
            fprintf(stderr,"Can't open file[%s]\n",file);
            return(1);
        }
        fplist[no] = fp;
    }

    fp = fopen(input,"r");
    if (!fp) {
        fprintf(stderr,"Can't open file[%s]\n",input);
        return(1);
    }
    cnt = 0;
    while(fgets(buf, sizeof(buf), fp)) {
        cnt++;
        if (cnt > c_end) {
            if (part < toomuch) {
                c_start = c_end + 1;
                c_end   = c_start + quotient;
            }
            else {
                c_start = c_end + 1;
                c_end   = c_start + quotient - 1;
            }
            printf("Part[%d] Start[%08d] End[%08d] Cnt[%08d]\n",
                   part+1, c_start, c_end, c_end-c_start+1);
            part++;
        }
        if (!fprintf(fplist[part-1],"%s",buf)) {
            fprintf(stderr,"part [%d] write error\n",part);
            return(1);
        }
    }
    if (fclose(fp)) {
        fprintf(stderr,"Can't open file[%s]\n",input);
        return(1);
    }
    
    for(no=0;no<divisor;no++) {
        char file[128];
        sprintf(file,"%s%02d",base,no);
        if (fclose(fplist[no])) {
            fprintf(stderr,"Can't open file[%s]\n",file);
            return(1);
        }
    }
    
    return(0);
} 

int
main(int argc, char *argv[]) 
{
    int   divisor = 0;
    char *p       = NULL;
    char  input[128];
    char  base[128];

    if (argc != 4) {
        fprintf(stderr,"Usage : split2 divisor input base\n");
        exit(1);
    }
 
    for(p=argv[1];(*p)!='\0';p++) {
        if (!isdigit(*p)) {
            fprintf(stderr,"not a number! [%s]\n",argv[1]);
            exit(1);
        }
    }

    divisor = atoi(argv[1]);
    strcpy(input, argv[2]);
    strcpy(base, argv[3]);

    split(divisor, input, base);
}
