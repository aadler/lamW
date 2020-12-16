// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#ifndef RCPP_lamW_RCPPEXPORTS_H_GEN_
#define RCPP_lamW_RCPPEXPORTS_H_GEN_

#include <Rcpp.h>

namespace lamW {

    using namespace Rcpp;

    namespace {
        void validateSignature(const char* sig) {
            Rcpp::Function require = Rcpp::Environment::base_env()["require"];
            require("lamW", Rcpp::Named("quietly") = true);
            typedef int(*Ptr_validate)(const char*);
            static Ptr_validate p_validate = (Ptr_validate)
                R_GetCCallable("lamW", "_lamW_RcppExport_validate");
            if (!p_validate(sig)) {
                throw Rcpp::function_not_exported(
                    "C++ function with signature '" + std::string(sig) + "' not found in lamW");
            }
        }
    }

    inline NumericVector lambertW0_C(NumericVector x) {
        typedef SEXP(*Ptr_lambertW0_C)(SEXP);
        static Ptr_lambertW0_C p_lambertW0_C = NULL;
        if (p_lambertW0_C == NULL) {
            validateSignature("NumericVector(*lambertW0_C)(NumericVector)");
            p_lambertW0_C = (Ptr_lambertW0_C)R_GetCCallable("lamW", "_lamW_lambertW0_C");
        }
        RObject rcpp_result_gen;
        {
            RNGScope RCPP_rngScope_gen;
            rcpp_result_gen = p_lambertW0_C(Shield<SEXP>(Rcpp::wrap(x)));
        }
        if (rcpp_result_gen.inherits("interrupted-error"))
            throw Rcpp::internal::InterruptedException();
        if (Rcpp::internal::isLongjumpSentinel(rcpp_result_gen))
            throw Rcpp::LongjumpException(rcpp_result_gen);
        if (rcpp_result_gen.inherits("try-error"))
            throw Rcpp::exception(Rcpp::as<std::string>(rcpp_result_gen).c_str());
        return Rcpp::as<NumericVector >(rcpp_result_gen);
    }

    inline NumericVector lambertWm1_C(NumericVector x) {
        typedef SEXP(*Ptr_lambertWm1_C)(SEXP);
        static Ptr_lambertWm1_C p_lambertWm1_C = NULL;
        if (p_lambertWm1_C == NULL) {
            validateSignature("NumericVector(*lambertWm1_C)(NumericVector)");
            p_lambertWm1_C = (Ptr_lambertWm1_C)R_GetCCallable("lamW", "_lamW_lambertWm1_C");
        }
        RObject rcpp_result_gen;
        {
            RNGScope RCPP_rngScope_gen;
            rcpp_result_gen = p_lambertWm1_C(Shield<SEXP>(Rcpp::wrap(x)));
        }
        if (rcpp_result_gen.inherits("interrupted-error"))
            throw Rcpp::internal::InterruptedException();
        if (Rcpp::internal::isLongjumpSentinel(rcpp_result_gen))
            throw Rcpp::LongjumpException(rcpp_result_gen);
        if (rcpp_result_gen.inherits("try-error"))
            throw Rcpp::exception(Rcpp::as<std::string>(rcpp_result_gen).c_str());
        return Rcpp::as<NumericVector >(rcpp_result_gen);
    }

}

#endif // RCPP_lamW_RCPPEXPORTS_H_GEN_