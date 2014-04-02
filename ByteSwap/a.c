#include <stdio.h>
#include <stdlib.h>

int main()
{
    int a = 0x11223344;
    int b = 0x55667788;

    int i = 0;
    for (i = 0; i < 100000; ++i) {
        //TODO: ShuffleVector and ByteSwap Part
    }

    printf("%02X %02X %02X %02X ", (a & 0xFF000000) >> 24, (a & 0xFF0000) >> 16, (a & 0xFF00) >> 8, (a & 0xFF));
    printf("%02X %02X %02X %02X\n", (b & 0xFF000000) >> 24, (b & 0xFF0000) >> 16, (b & 0xFF00) >> 8, (b & 0xFF));
    return 0;
}
