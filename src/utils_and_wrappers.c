#include <R.h>
#include <Rinternals.h>
#include <Rmath.h>
#include <string.h>
#include <stdint.h>

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

void lambertW0_f (double *x, int nx, double *ret);

SEXP lambertW0_f_wrap (SEXP x) {
  const int nx = LENGTH(x);
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, nx));
  lambertW0_f(REAL(x), nx, REAL(ret));
  UNPROTECT(1);
  return(ret);
}

void lambertWm1_f (double *x, int nx, double *ret);

SEXP lambertWm1_f_wrap (SEXP x) {
  const int nx = LENGTH(x);
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, nx));
  lambertWm1_f(REAL(x), nx, REAL(ret));
  UNPROTECT(1);
  return(ret);
}

double h (double *x, double *w);

SEXP h_wrap(SEXP x, SEXP w){
  SEXP ret;
  PROTECT(ret = allocVector(REALSXP, 1));
  REAL(ret)[0] = h(REAL(x), REAL(w));
  UNPROTECT(1);
  return(ret);
}

void set_nan_(double *val)
{
  // *val = sqrt(-1.0); By Drew Schmidt
  int64_t x = 0x7FF0000000000001LL;
  memcpy((void *) val, (void *) &x, 8);
}

void set_inf_(double *val) {
  // *val = Inf Based on set_nan
  int64_t x = 0x7FF0000000000000LL;
  memcpy((void *) val, (void *) &x, 8);
}

void set_neginf_(double *val) {
  // *val = Neg Inf Based on set_nan
  int64_t x = 0xFFF0000000000000LL;
  memcpy((void *) val, (void *) &x, 8);
}