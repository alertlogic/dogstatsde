#!/bin/bash -ex

if [[ $TRAVIS_TAG && ($TRAVIS_OTP_RELEASE != $MAIN_OTP || $REBAR_VSN -ne 3) ]]; then
    echo Skip tests for non-primary test of a tag-build
    exit 0
fi

if [ $REBAR_VSN == 'mix' ]; then
    cd examples/elixir
    mix deps.get
    mix compile
    mix escript.build
    ./elixir_example
elif [ $REBAR_VSN -eq 2 ]; then
    ./vendor/rebar compile
    ./vendor/rebar eunit
elif [ $REBAR_VSN -eq 3 ]; then
    ./vendor/rebar3 eunit
else
    echo Unknown rebar version requested: $REBAR_VSN
    exit 1
fi
