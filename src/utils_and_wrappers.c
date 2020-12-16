#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <Rmath.h>
#include <R_ext/Rdynload.h>

//  Copyright (c) 2016, Avraham Adler
//  All rights reserved.
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided
//  that the following conditions are met:
//    1. Redistributions of source code must retain the above copyright notice, this list of conditions and
//       the following disclaimer.
//    2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions
//       and the following disclaimer in the documentation and/or other materials provided with the distribution.
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
//  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
//  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
//  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
//  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

void F77_NAME(lambertW0_f) (double *x, int nx, double *ret);

extern SEXP lambertW0_f_wrap (SEXP x) {
  const int nx = LENGTH(x);
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, nx));
  F77_CALL(lambertW0_f)(REAL(x), nx, REAL(ret));
  UNPROTECT(1);
  return(ret);
}

void F77_NAME(lambertWm1_f) (double *x, int nx, double *ret);

extern SEXP lambertWm1_f_wrap (SEXP x) {
  const int nx = LENGTH(x);
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, nx));
  F77_CALL(lambertWm1_f)(REAL(x), nx, REAL(ret));
  UNPROTECT(1);
  return(ret);
}

void F77_SUB(set_nan)(double *val){
  *val = R_NaN;
}

void F77_SUB(set_inf)(double *val){
  *val = R_PosInf;
}

void F77_SUB(set_neginf)(double *val){
  *val = R_NegInf;
}

static const R_CallMethodDef callMethods[]  = {
  {"lambertW0_f_wrap", (DL_FUNC) &lambertW0_f_wrap, 1},
  {"lambertWm1_f_wrap", (DL_FUNC) &lambertWm1_f_wrap, 1},
  {NULL, NULL, 0}
};

void R_init_delaporte(DllInfo *dll) {
    R_registerRoutines(dll, NULL, callMethods, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
    R_forceSymbols(dll, TRUE);
}
