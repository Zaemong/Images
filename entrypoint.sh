#!/bin/bash

if [ -d ".runner" ]; then
    # すでに登録済みの場合はrun.shのみ実行
    exec ./run.sh
else
    # 未登録の場合はconfig.shで登録
    if [ -z "$URL" ] || [ -z "$TOKEN" ]; then
        echo "ERROR: URLとTOKENの両方を環境変数で指定してください"
        exit 1
    fi

    CMD="./config.sh --url \"$URL\" --token \"$TOKEN\""
    if [ -n "$NAME" ]; then
        CMD="$CMD --name \"$NAME\""
    fi
    if [ -n "$RUNNER_GROUP" ]; then
        CMD="$CMD --runnergroup \"$RUNNER_GROUP\""
    fi
    CMD="$CMD --unattended"

    eval $CMD
    exec ./run.sh
fi