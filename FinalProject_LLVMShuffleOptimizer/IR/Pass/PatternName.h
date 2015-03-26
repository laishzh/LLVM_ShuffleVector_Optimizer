#ifndef __PATTERNNAME_H__
#define __PATTERNNAME_H__

#define __DEBUG true

#define NoPattern 0
#define Rotate 1
#define ShiftLeft 2
#define ShiftRightLogical 3
#define ZeroExtend 4
#define Merge 5
#define Pack 6
#define Blend 7

#define Case_And_Print(x, y) case x: llvm::errs() << y; break;
#define _DEBUG if(__DEBUG) errs()
#define VECTOR_DUMP(x) for(unsigned i=0;i<x.size();i++) errs()<<' '<<x[i];

typedef int PatternName;
void ArgvDump(unsigned t) {
    switch(t) {
	Case_And_Print(0, "NoPattern")
	Case_And_Print(1, "Rotate")
	Case_And_Print(2, "ShiftLeft")
	Case_And_Print(3, "ShiftRIghtLogical")
	Case_And_Print(4, "ZeroExtend")
	Case_And_Print(5, "Merge")
	Case_And_Print(6, "Pack")
	Case_And_Print(7, "Blend")
    }
}

void SVecDump(const llvm::SmallVector<int, 16>& vec) {
    llvm::errs() << "VectorLength: " << vec.size() << '\n';
    for (unsigned i=0; i<vec.size(); i++)
	llvm::errs() << vec[i] << ' ';
    llvm::errs() << '\n';
}

#endif
