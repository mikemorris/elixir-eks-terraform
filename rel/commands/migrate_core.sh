#!/bin/sh

release_ctl eval --mfa "Core.ReleaseTasks.migrate/1" --argv -- "$@"
