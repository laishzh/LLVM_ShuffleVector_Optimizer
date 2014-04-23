#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main()
{
    uint8_t a[64] = {
       0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
       0x09, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16,
       0x17, 0x18, 0x19, 0x20, 0x21, 0x22, 0x23, 0x24,
       0x25, 0x26, 0x27, 0x28, 0x29, 0x30, 0x31, 0x32,
       0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x40,
       0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48,
       0x49, 0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56,
       0x57, 0x58, 0x59, 0x60, 0x61, 0x62, 0x63, 0x64
    };

    uint32_t i = 0;
    printf("Before Shuffle: Begin\n");
    for (i = 0; i < 8; ++i) {
        printf("%02X %02X %02X %02X %02X %02X %02X %02X\n",
            a[8 * i + 0],
            a[8 * i + 1],
            a[8 * i + 2],
            a[8 * i + 3],
            a[8 * i + 4],
            a[8 * i + 5],
            a[8 * i + 6],
            a[8 * i + 7]);
    }
    printf("Before Shuffle: End\n\n");
    for (i = 0; i < 100000; ++i) {
        //TODO: ShuffleVector and ByteSwap Part
    }

    printf("After Shuffle: Begin\n");
    for (i = 0; i < 8; ++i) {
        printf("%02X %02X %02X %02X %02X %02X %02X %02X\n",
            a[8 * i + 0],
            a[8 * i + 1],
            a[8 * i + 2],
            a[8 * i + 3],
            a[8 * i + 4],
            a[8 * i + 5],
            a[8 * i + 6],
            a[8 * i + 7]);
    }
    printf("After Shuffle: End\n");
    return 0;
}
