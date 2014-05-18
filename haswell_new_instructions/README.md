#Haswell New Instructions#

The Intel's official document of the two new instructions, PEXT and
PDEP, is
[here](https://software.intel.com/sites/default/files/m/8/a/1/8/4/36945-319433-011.pdf),
on page 7-17.

The PEXT and PDEP instructions are defined in the header file
``bmi2intrin.h``.

```c
static __inline__ unsigned int __attribute__((__always_inline__, __nodebug__))
_pdep_u32(unsigned int __X, unsigned int __Y)
{
    return __builtin_ia32_pdep_si(__X, __Y);
}

static __inline__ unsigned int __attribute__((__always_inline__, __nodebug__))
_pext_u32(unsigned int __X, unsigned int __Y)
{
    return __builtin_ia32_pext_si(__X, __Y);
}

static __inline__ unsigned long long __attribute__((__always_inline__, __nodebug__))
_pdep_u64(unsigned long long __X, unsigned long long __Y)
{
    return __builtin_ia32_pdep_di(__X, __Y);
}

static __inline__ unsigned long long __attribute__((__always_inline__, __nodebug__))
_pext_u64(unsigned long long __X, unsigned long long __Y)
{
    return __builtin_ia32_pext_di(__X, __Y);
}
```

Before use these instructions, check whether the machine supports
these instructions, and just ``include <x86intrin.h>`` and pass
``bmi2`` as the machine option when compilation.


By default clang compilation 

#LLVM llc view SelectionDAG Graph#

* **view-dag-combine1-dags** Pop up a window to show dags before the first dag combine pass
* **view-legalize-types-dags** Pop up a window to show dags before legalize types
* **view-legalize-dags** Pop up a window to show dags before legalize
* **iew-dag-combine2-dags** Pop up a window to show dags before the second dag combine pass
* **view-dag-combine-lt-dags** Pop up a window to show dags before the post legalize types dag combine pass
* **view-isel-dags** Pop up a window to show isel dags as they are selected
* **view-sched-dags** Pop up a window to show sched dags as they are processed
* **view-sunit-dags** Pop up a window to show SUnit dags after they are processed
