!-------------------------------------------------------------------------------
!
! MODULE: LambertW
!
! AUTHOR: Avraham Adler <Avraham.Adler@gmail.com>
!
! DESCRIPTION: Lambert W function
!
! HISTORY:
!          Version 1.0: 2016-11-20
!          Version 1.1: 2020-05-21
!
! LICENSE:
!   Copyright (c) 2016, Avraham Adler
!   All rights reserved.
!
!   Redistribution and use in source and binary forms, with or without
!   modification, are permitted provided that the following conditions are met:
!       1. Redistributions of source code must retain the above copyright
!       notice, this list of conditions and the following disclaimer.
!       2. Redistributions in binary form must reproduce the above copyright
!       notice, this list of conditions and the following disclaimer in the
!       documentation and/or other materials provided with the distribution.
!
!   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
!   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
!   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
!   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
!   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
!   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
!   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
!   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
!   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
!   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
!   POSSIBILITY OF SUCH DAMAGE.
!
! REFERENCES:
!   Corless, R. M.; Gonnet, G. H.; Hare, D. E.; Jeffrey, D. J. & Knuth, D. E.
!   "On the Lambert W function", Advances in Computational Mathematics,
!   Springer, 1996, 5, 329-359
!
!   Veberič, Darko. "Lambert W function for applications in physics."
!   Computer Physics Communications 183(12), 2012, 2622-2628
!
!   Veberič used for Fritsch iteration step; access to original paper currently
!   unavailable. Need to retain Halley step for -3e-4 < x 3e-4 where the Fritsch
!   may underflow and return NaN
!-------------------------------------------------------------------------------

module lambertW
  use, intrinsic :: iso_c_binding
  use, intrinsic :: omp_lib

  implicit none
  private
  public :: lambertW0_f, lambertWm1_f

  real(kind = c_double), parameter :: ZERO = 0._c_double
  real(kind = c_double), parameter :: ONE = 1._c_double
  real(kind = c_double), parameter :: TWO = 2._c_double
  real(kind = c_double), parameter :: THREE = 3._c_double
  real(kind = c_double), parameter :: FOUR = 4._c_double
  real(kind = c_double), parameter :: HALF = 0.5_c_double
  real(kind = c_double), parameter :: TWOTHIRDS = TWO / THREE
  real(kind = c_double), parameter :: EPS = 2.2204460492503131e-16_c_double
  real(kind = c_double), parameter :: ME = 2.7182818284590451_c_double
  real(kind = c_double), parameter :: M1E = ONE / ME

contains

!-------------------------------------------------------------------------------
! FUNCTION: fritsch_f
!
! DESCRIPTION: Frisch iteration for lambert W function as found in
!              http://arxiv.org/pdf/1209.0735.pdf:
!               * W_{n+1} = W_n * (1 + e_n)
!               * e_n = z_n / (1 + W_n) * (q_n - z_n) / (q_n - 2 * z_n)
!               * z_n = ln(x / W_n) - W_n
!               * q_n = 2 * (1 + W_n) * (1 + W_n + 2 / 3 * z_n)
!-------------------------------------------------------------------------------

    elemental function fritsch_f (x, w_guess) result (w)

    real(kind = c_double), intent(in)            :: x, w_guess
    real(kind = c_double)                        :: w, z, w1, q, qz, e
    logical(kind = c_bool)                       :: converged
    integer(kind = c_int), parameter             :: maxeval = 3
    integer(kind = c_int)                        :: i

        w = w_guess
        converged = .FALSE.
        i = 1

        do while (i <= maxeval .and. .not. converged)
            z = log(x / w) - w
            w1 = w + ONE
            q = 2 * w1 * (w1 + TWOTHIRDS * z)
            qz = q - z
            e = z * qz / (w1 * (qz - z))
            converged = abs(e) <= EPS
            w = w * (ONE + e)
            i = i + 1
        end do

    end function fritsch_f

!-------------------------------------------------------------------------------
! FUNCTION: halley_f
!
! DESCRIPTION: Halley iteration for lambert W function. Given x, we want to find
!              W such that Wexp(W) = x, so Wexp(W) - x = 0. We can use Halley
!              iteration to find this root; to do so it needs first and second
!              derivative.
!                 f(W)    = W * exp(W) - x
!                 f'(W)   = W * exp(W) + exp(W)       = exp(W) * (W + 1)
!                 f''(W)  = exp(W) + (W + 1) * exp(W) = exp(W) * (W + 2)
!
!              Halley Step:
!              W_{n+1} = W_n - {2 * f(W_n) * f'(W_n)} /
!                               {2 * [f'(W_n)]^2 - f(W_n) * f''(W_n)}
!----------------------------------------------------------------------------------------

    elemental function halley_f (x, w_guess) result (w)

    real(kind = c_double), intent(in)            :: x, w_guess
    real(kind = c_double)                        :: w, w1, ew, f0
    logical(kind = c_bool)                       :: converged
    integer(kind = c_int), parameter             :: maxeval = 2
    integer(kind = c_int)                        :: i

        w = w_guess
        converged = .FALSE.
        i = 1

        do while (i <= maxeval .and. .not. converged)
            ew = exp(w)
            w1 = w + ONE
            f0 = w * ew - x
            f0 = f0 / ((ew * w1) - (((w1 + ONE) * f0) / (TWO * w1)))
            converged = abs(f0) < EPS
            w = w - f0
            i = i + 1
        end do

    end function halley_f

!-------------------------------------------------------------------------------
! FUNCTION: lambertW0_f_s
!
! DESCRIPTION: Calculates real-valued lambert W principal branch for single
!              value. Long decimal expansions below calculated using expansion
!              in Corliss 4.22  to create (3, 2) Pade approximant:
!
!              Numerator: 13 / 720 * p ^ 3 + 257 / 720 * p ^ 2 + 1 / 6 * p - 1
!              Denominator: 103 / 720 * p^2 + 5 / 6 * p + 1
!
!              Converted to digits to reduce needed operations. Halley step used
!              when abs(x) < 3e-4 as this version of Fritsch may underflow.
!-------------------------------------------------------------------------------

  function lambertW0_f_s (x) result (l)

  external set_nan
  external set_inf

  real(kind = c_double), intent(in)              :: x
  integer(kind = c_int)                          :: i
  real(kind = c_double)                          :: l, w, p, Numer, Denom, L2, &
                                                    L3, L11, infty
  real(kind = c_double), dimension(3), parameter :: N = [0.018055555555555555_c_double, &
                                                         0.35694444444444444_c_double, &
                                                         0.166666666666666_c_double]
  real(kind = c_double), dimension(2), parameter :: D = [0.143055555555555555_c_double, &
                                                         0.83333333333333333_c_double]
      call set_inf(infty)
      if (x == infty) then
          call set_inf(l)
      else if (x < -M1E) then
          call set_nan(l)
      else if (abs(x + M1E) < FOUR * EPS) then
          l = -ONE
      else if (x <= (ME - HALF)) then
          p = sqrt(TWO * (ME * x + ONE))
          Numer = ((N(1) * p + N(2)) * p + N(3)) * p - ONE
          Denom = (D(1) * p + D(2)) * p + ONE
          w = Numer / Denom
          if (abs(x) <= 3e-4_c_double) then
              l = halley_f(x, w)
          else
              l = fritsch_f(x, w)
          end if
      else
    ! Use first five terms of Corliss et al. 4.19
          w = log(x)
          L2 = log(w);
          L11 = 1 / w
          L3 = L2 * L11;
          w = w - L2 + L3 + ((L3 / THREE + HALF * (ONE - 3 * L11)) * L3 + L11 &
              * (L11 - ONE)) * L3
          l = fritsch_f(x, w)
      end if

  end function lambertW0_f_s

!-------------------------------------------------------------------------------
! ROUTIBE: lambertW0_f
!
! DESCRIPTION: Calls lambertW0_f_s on a vector
!              For some reason, I have a problem combining the single into the
!              vector here, but it works for lambertWm1_f.
!-------------------------------------------------------------------------------

    subroutine lambertw0_f (x, nx, lamwv) bind(C, name = 'lambertW0_f_')

    integer(kind = c_int), intent(in), value          :: nx       ! Size
    real(kind = c_double), intent(in), dimension(nx)  :: x        ! Observations
    real(kind = c_double), intent(out), dimension(nx) :: lamwv    ! Result
    integer(kind = c_int)                             :: i

        !$omp parallel do schedule(auto) default(private) shared(x, lamwv)
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

  subroutine lambertWm1_f (x, nx, lamwv) bind(C, name = 'lambertWm1_f_')

  external set_nan
  external set_neginf

  integer(kind = c_int), intent(in), value            :: nx       ! Size
  real(kind = c_double), intent(in), dimension(nx)    :: x        ! Observations
  real(kind = c_double), intent(out), dimension(nx)   :: lamwv    ! Result
  integer(kind = c_int)                               :: i
  real(kind = c_double)                               :: w, L2, L3, L11

      !$omp parallel do schedule(auto) default(private) shared(x, lamwv)
      do i = 1, nx
          if (x(i) == ZERO) then
              call set_neginf(lamwv(i))
          else if (x(i) < -M1E .or. x(i) > ZERO) then
              call set_nan(lamwv(i))
          else if (abs(x(i) + M1E) < FOUR * EPS) then
              lamwv(i) = -ONE
          else
    ! Use first five terms of Corliss et al. 4.19
              w = log(-x(i))
              L2 = log(-w);
              L11 = 1 / w
              L3 = L2 * L11;
              w = w - L2 + L3 + ((L3 / THREE + HALF * (ONE - 3 * L11)) * L3 + &
                  L11 * (L11 - ONE)) * L3
              lamwv(i) = fritsch_f(x(i), w)
          end if
      end do
      !$omp end parallel do

  end subroutine lambertWm1_f

end module lambertW
