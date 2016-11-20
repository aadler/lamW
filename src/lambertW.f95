!----------------------------------------------------------------------------------------
!
! MODULE: LambertW
!
! AUTHOR: Avraham Adler <Avraham.Adler@gmail.com>
!
! DESCRIPTION: Lambert W function
!
! HISTORY:
!          Version 1.0: 2016-11-20
!
! LICENSE:
!   Copyright (c) 2016, Avraham Adler
!   All rights reserved.
!
!   Redistribution and use in source and binary forms, with or without modification, are
!   permitted provided that the following conditions are met:
!       1. Redistributions of source code must retain the above copyright notice, this
!          list of conditions and the following disclaimer.
!       2. Redistributions in binary form must reproduce the above copyright notice,
!          this list of conditions and the following disclaimer in the documentation
!          and/or other materials provided with the distribution.
!
!   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
!   EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
!   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
!   SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
!   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
!   TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
!   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
!   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
!   ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
!   DAMAGE.
!
! REFERENCES:
!   Corless, R. M.; Gonnet, G. H.; Hare, D. E.; Jeffrey, D. J. & Knuth, D. E.
!   "On the Lambert W function", Advances in Computational Mathematics,
!   Springer, 1996, 5, 329-359
!
!   Veberič, Darko. "Lambert W function for applications in physics."
!   Computer Physics Communications 183(12), 2012, 2622-2628
!
!   Veberič used for Fritsch iteration step; access to original paper currently unavailable
!   Need to retain Halley step for -7e-3 < x 7e-3 where the Fritsch may underflow and return NaN
!----------------------------------------------------------------------------------------

module lambertW
  use, intrinsic :: iso_c_binding
  use, intrinsic :: omp_lib
  use utils

  implicit none
  private
  public :: lambertW0_f, lambertWm1_f

contains

!----------------------------------------------------------------------------------------
! FUNCTION: fritsch_f
!
! DESCRIPTION: Frisch iteration for lambert W function as found in
!              http://arxiv.org/pdf/1209.0735.pdf:
!               * W_{n+1} = W_n * (1 + e_n)
!               * e_n = z_n / (1 + W_n) * (q_n - z_n) / (q_n - 2 * z_n)
!               * z_n = ln(x / W_n) - W_n
!               * q_n = 2 * (1 + W_n) * (1 + W_n + 2 / 3 * z_n)
!----------------------------------------------------------------------------------------

    function fritsch_f (x, w_guess) result (w)
    !$omp declare simd(fritsch_f) inbranch

    real(kind = c_double), intent(in)                       :: x, w_guess
    real(kind = c_double)                                   :: w, k, z, w1, q, qz, e
    logical(kind = c_bool)                                  :: converged
    integer(kind = c_int), parameter                        :: maxeval = 6
    integer(kind = c_int)                                   :: i

        w = w_guess
        converged = .FALSE.
        i = 1
        k = 2_c_double / 3_c_double

        do while (i <= maxeval .and. .not. converged)
            z = log(x / w) - w
            w1 = w + ONE
            q = 2 * w1 * (w1 + k * z)
            qz = q - z
            e = z / w1 * qz / (qz - z)
            converged = abs(e) <= EPS
            w = w * (ONE + e)
            i = i + 1
        end do

    end function fritsch_f

!----------------------------------------------------------------------------------------
! FUNCTION: halley_f
!
! DESCRIPTION: Halley iteration for lambert W function. Given x, we want to find W such
!              that Wexp(W) = x, so Wexp(W) - x = 0. We can use Halley iteration to find
!              this root; to do so it needs first and second derivative.
!                 f(W)    = W * exp(W) - x
!                 f'(W)   = W * exp(W) + exp(W)       = exp(W) * (W + 1)
!                 f''(W)  = exp(W) + (W + 1) * exp(W) = exp(W) * (W + 2)
!
!          Halley Step:
!          W_{n+1} = W_n - {2 * f(W_n) * f'(W_n)} / {2 * [f'(W_n)]^2 - f(W_n) * f''(W_n)}
!----------------------------------------------------------------------------------------

    function halley_f (x, w_guess) result (w) bind(C, name = 'h')
    !$omp declare simd(halley_f) inbranch

    real(kind = c_double), intent(in)                       :: x, w_guess
    real(kind = c_double)                                   :: w, k, ew, f0, f1, f2, &
                                                               N, D, diff
    logical(kind = c_bool)                                  :: converged
    integer(kind = c_int), parameter                        :: maxeval = 12
    integer(kind = c_int)                                   :: i

        w = w_guess
        converged = .FALSE.
        i = 1

        do while (i < maxeval .and. .not. converged)
            ew = exp(w)
            f0 = w * ew - x
            f1 = (w + ONE) * ew
            f2 = (w + TWO) * ew
            N = TWO * f0 * f1
            D = TWO * f1 ** 2 - f0 * f2
            diff = N / D
            converged = abs(diff) < EPS
            w = w - diff
            i = i + 1
        end do

    end function halley_f

!----------------------------------------------------------------------------------------
! FUNCTION: lambertW0_f_s
!
! DESCRIPTION: Calculates real-valued lambert W principal branch for single value.
!              Long decimal expansions below calculated using expansion in Corliss 4.22
!              to create (3, 2) Pade approximant:
!
!   Numerator: -10189 / 303840 * p ^ 3 + 40529 / 303840 * p ^ 2 + 489 / 844 * p - 1
!   Denominator: -14009 / 303840 * p^2 + 355 / 844 * p + 1
!
!           Converted to digits to reduce needed operations
!           Halley step used when abs(x) < 7e-3 as this version of Fritsch may underflow
!----------------------------------------------------------------------------------------

  function lambertW0_f_s (x) result (l) bind(C, name = 'lambertW0_f_s')

  external set_nan
  external set_inf

  real(kind = c_double), intent(in)                       :: x
  integer(kind = c_int)                                   :: i
  real(kind = c_double)                                   :: l, w, p, Numer, Denom, &
                                                             L2, L3, L3sq, infty
      call set_inf(infty)
      if (x == infty) then
          call set_inf(l)
      else if (x < MM1E) then
          call set_nan(l)
      else if (abs(x + M1E) < 4_c_double * EPS) then
          l = -ONE
      else if (x <= (ME - 0.5_c_double)) then
          p = sqrt(TWO * (ME * x + ONE))
          Numer = -0.03353409689310163_c_double * p ** 3 + &
                  0.1333892838335966_c_double * p ** 2 + &
                  0.5793838862559242_c_double * p - ONE
          Denom = -0.04610650342285413_c_double * p ** 2 + &
                  0.4206161137440758_c_double * p + ONE
          w = Numer / Denom
          if (abs(x) <= 1.2e-2_c_double) then
              l = halley_f(x, w)
          else
              l = fritsch_f(x, w)
          end if
      else
    ! Use first five terms of Corliss et al. 4.19
          w = log(x)
          L2 = log(w);
          L3 = L2 / w;
          L3sq = L3 * L3;
          w = w - L2 + L3 + 0.5_c_double * L3sq - L3 / w + L3 / (w * w) - 1.5_c_double &
                  * L3sq / w + L3sq * L3 / 3_c_double
          l = fritsch_f(x, w)
      end if

  end function lambertW0_f_s

!----------------------------------------------------------------------------------------
! ROUTIBE: lambertW0_f
!
! DESCRIPTION: Calls lambertW0_f_s on a vector
!----------------------------------------------------------------------------------------

    subroutine lambertw0_f (x, nx, lamwv) bind(C, name = 'lambertW0_f')

    integer(kind = c_int), intent(in), value                :: nx          ! Size
    real(kind = c_double), intent(in), dimension(nx)        :: x           ! Observations
    real(kind = c_double), intent(out), dimension(nx)       :: lamwv       ! Observations
    integer(kind = c_int)                                   :: i

        !$omp parallel do
        do i = 1, nx
            lamwv(i) = lambertW0_f_s(x(i))
        end do
        !$omp end parallel do

    end subroutine lambertw0_f

!----------------------------------------------------------------------------------------
! ROUTINE: lambertWm1_f
!
! DESCRIPTION: Calculates real-valued lambert W secondary branch.
!----------------------------------------------------------------------------------------

  subroutine lambertWm1_f (x, nx, lamwv) bind(C, name = 'lambertWm1_f')

  external set_nan
  external set_neginf

  integer(kind = c_int), intent(in), value                :: nx          ! Size
  real(kind = c_double), intent(in), dimension(nx)        :: x           ! Observations
  real(kind = c_double), intent(out), dimension(nx)       :: lamwv       ! Observations
  integer(kind = c_int)                                   :: i
  real(kind = c_double)                                   :: w, L2, L3, L3sq

      do i = 1, nx
          if (x(i) == ZERO) then
              call set_neginf(lamwv(i))
          else if (x(i) < MM1E .or. x(i) > ZERO) then
              call set_nan(lamwv(i))
          else if (abs(x(i) + M1E) < 4_c_double * EPS) then
              lamwv(i) = -ONE
          else
    ! Use first five terms of Corliss et al. 4.19
              w = log(-x(i))
              L2 = log(-w);
              L3 = L2 / w;
              L3sq = L3 * L3;
              w = w - L2 + L3 + 0.5_c_double * L3sq - L3 / w + L3 / (w * w) - 1.5_c_double &
                  * L3sq / w + L3sq * L3 / 3_c_double
              lamwv(i) = fritsch_f(x(i), w)
          end if
      end do


  end subroutine lambertWm1_f

end module lambertW
