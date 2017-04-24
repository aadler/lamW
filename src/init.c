#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME: 
   Check these declarations against the C/Fortran source code.
*/

/* .Call calls */
extern SEXP lamW_lambertW0_C(SEXP);
extern SEXP lamW_lambertWm1_C(SEXP);
extern SEXP lamW_RcppExport_registerCCallable();

static const R_CallMethodDef CallEntries[] = {
    {"lamW_lambertW0_C",                  (DL_FUNC) &lamW_lambertW0_C,                  1},
    {"lamW_lambertWm1_C",                 (DL_FUNC) &lamW_lambertWm1_C,                 1},
    {"lamW_RcppExport_registerCCallable", (DL_FUNC) &lamW_RcppExport_registerCCallable, 0},
    {NULL, NULL, 0}
};

void R_init_lamW(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
