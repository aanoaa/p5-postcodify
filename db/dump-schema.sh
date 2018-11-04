#!/bin/sh
USERNAME=postcodify
DATABASE=postcodify
mysqldump --quick \
          --no-data \
          --single-transaction \
          -u $USERNAME \
          -p \
          $DATABASE > schema.sql
