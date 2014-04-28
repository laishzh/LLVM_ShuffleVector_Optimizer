ALL: Build_BSwap Build_SflVec

Build_SflVec: sfl_vec.ll
	clang sfl_vec.ll -S -o sfl_vec.s
	clang sfl_vec.ll -o sfl_vec

Build_BSwap: byte_swap.ll
	clang byte_swap.ll -S -o byte_swap.s
	clang byte_swap.ll -o byte_swap

clean:
	rm *.s byte_swap sfl_vec
