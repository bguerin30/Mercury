

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "TestAll.h"


int main(int argc, char **argv)
{
    if(!Test_RingBuf())
    {
        printf("\t\tRingBuffer Module failed.\r\n");
        printf("\t\tExiting ...\r\n");
        return 0;
    }

    return 0;
}