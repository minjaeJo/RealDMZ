#!/usr/bin/env bash
npm run build
mv ./dist ./realdmz
rm -rf ../../../var/www/html/realdmz
mv ./realdmz ../../../var/www/html
