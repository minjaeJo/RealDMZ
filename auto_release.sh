#!/usr/bin/env bash
npm run build
mv ./dist ./realdmz
mv ./realdmz ../../../var/www/html
