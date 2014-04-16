#include <simd-lib/bitblock.hpp>
#include <simd-lib/carryQ.hpp>
#include <simd-lib/pabloSupport.hpp>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <simd-lib/s2p.hpp>
#include <simd-lib/buffer.hpp>

#define SEGMENT_BLOCKS 15
#define SEGMENT_SIZE (BLOCK_SIZE * SEGMENT_BLOCKS)

#define BUFFER_SEGMENTS 15
#define BUFFER_SIZE (BUFFER_SEGMENTS * SEGMENT_SIZE)

struct Basis_bits {
    BitBlock bit_0;
    BitBlock bit_1;
    BitBlock bit_2;
    BitBlock bit_3;
    BitBlock bit_4;
    BitBlock bit_5;
    BitBlock bit_6;
    BitBlock bit_7;
};

#include <simd-lib/transpose.hpp>
void do_process(FILE *infile) {
    struct Basis_bits basis_bits;
    int blk = 0;
    int block_base = 0;
    int block_pos = 0;
    int buffer_base = 0;
    int buffer_pos = 0;
    int chars_avail = 0;
    int chars_read = 0;

    ATTRIBUTE_SIMD_ALIGN char src_buffer[SEGMENT_SIZE];
    chars_read = fread((void *) &src_buffer[0], 1, SEGMENT_SIZE, infile);
    chars_avail = chars_read;
    if (chars_avail >= SEGMENT_SIZE) chars_avail = SEGMENT_SIZE;
    while (chars_avail >= SEGMENT_SIZE) {
        printf("chars_avail:%d\n", chars_avail);
        for (blk = 0; blk < SEGMENT_BLOCKS; blk++) {
            block_base = blk * BLOCK_SIZE;
            //s2p_do_block((BytePack *) &src_buffer[block_base], basis_bits);
        }
        chars_avail = fread(&src_buffer[0], 1, SEGMENT_SIZE, infile);
    }
}

int main(int argc, char*argv[])
{
    char *infilename;
    FILE *infile;

    if (optind >= argc) {
		printf ("Too few arguments\n");
		printf("Usage: %s [-c] [-v] <filename> [<outputfile>]\n", argv[0]);
		exit(-1);
    }

    infilename = argv[optind++];
    infile = fopen(infilename, "rb");

    if (!infile) {
        fprintf(stderr, "Error: cannot open %s for input.\n", infilename);
        exit(-1);
    }
    do_process(infile);
    return 0;
}
