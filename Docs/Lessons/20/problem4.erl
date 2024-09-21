%
% Refer to: Docs/Problem+4+-+Functions.pdf
% Solution: Numerical approach
%    david.paiva.fernandes@gmail.com
%    2024-09-21
%

-module(problem4).
-export([related_sum/1]).

% Just trying to avoid the necessity to use round over math:pow.
power(_, 0) ->
    1;
power(N, E) ->
    N * power(N, E - 1).

related_sum(N) when is_integer(N), N >= 0 ->
    Digits = floor(math:log10(N)) + 1,
    case Digits rem 2 of
        1 ->
            io:format("Invalid argument. (~p) must have an even number of digits.~n", [N]);
        _ ->
            TenMult = power(10, Digits div 2),
            LeftPart = N div TenMult,
            RightPart = N - LeftPart * TenMult,
            LeftSum = sum_digits(LeftPart, TenMult),
            RightSum = sum_digits(RightPart, TenMult),
            show_result(LeftSum, RightSum)
        end;

related_sum(N) ->
    io:format("Invalid argument. (~p) is not a number or not positive.~n", [N]).

sum_digits(N, TenMult) ->
    sum_digits(N, TenMult div 10, 0).

sum_digits(_, 0, RunningTotal) ->
    RunningTotal;

sum_digits(N, TenMult, RunningTotal) ->
    Digit = N div TenMult,
    sum_digits(N - Digit * TenMult, TenMult div 10, RunningTotal + Digit).

show_result(L, R) ->
    {L, order_sign(L, R), R}.

order_sign(L, R) when L > R ->
    ">";
order_sign(L, R) when L < R ->
    "<";
order_sign(_, _) ->
    "=".