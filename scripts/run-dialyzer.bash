#!/bin/bash -ex

if [[ $TRAVIS_OTP_RELEASE != $MAIN_OTP ]]; then
    echo "No dialyzer run for non-primary build"
elif [[ $REBAR_VSN == 'mix' ]]; then
    echo "No dialyzer run for Elixir build"
elif [[ $REBAR_VSN -eq 2 ]]; then
    echo "No dialyzer run under rebar2"
elif [[ $REBAR_VSN -eq 3 ]]; then
    ./vendor/rebar3 dialyzer
else
    echo Unknown rebar version requested: $REBAR_VSN
    exit 1
fi
