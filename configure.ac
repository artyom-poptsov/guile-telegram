dnl   configuration script for Guile-Telegram
dnl   Process this file with autoconf to produce configure.
dnl

define(GUILE_TELEGRAM_CONFIGURE_COPYRIGHT, [[
Copyright (C) 2019 Artyom V. Poptsov <poptsov.artyom@gmail.com>

This file is part of Guile-Telegram.

Guile-Telegram is free software: you can redistribute it and/or
modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

Guile-Telegram is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with Guile-Telegram.  If not, see <http://www.gnu.org/licenses/>.
]])

AC_INIT([Guile-Telegram], [0.1.0], [poptsov.artyom@gmail.com],
                     [guile-telegram],
                     [https://github.com/artyom-poptsov/guile-telegram])

AC_COPYRIGHT(GUILE_TELEGRAM_CONFIGURE_COPYRIGHT)

AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])

AM_INIT_AUTOMAKE([color-tests])
m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])], [AC_SUBST([AM_DEFAULT_VERBOSITY],1)])

AC_ARG_WITH([guilesitedir],
            [AS_HELP_STRING([--with-guilesitedir],
                            [use the specified installation path for Guile modules])],
            [case "x$withval" in
             xyes|xno) guilesitedir="";;
             *)        guilesitedir="$withval";;
             esac],
             [guilesitedir=""])


dnl These macros must be provided by guile.m4.
m4_pattern_forbid([^GUILE_PKG$])
m4_pattern_forbid([^GUILE_PROGS$])

dnl Use this macro so that 'GUILE_EFFECTIVE_VERSION' is defined here.
dnl Try Guile 2.2, then Guile 2.0.
GUILE_PKG([2.2 2.0])

GUILE_PROGS
GUILE_FLAGS
GUILE_SITE_DIR

GUILE_MODULE_REQUIRED([json])

if test "x$guilesitedir" = "x"; then
   guilesitedir="$datadir/guile/site/$GUILE_EFFECTIVE_VERSION"
fi
AC_SUBST([guilesitedir])

GUILE_EFFECTIVE_VERSION=`$GUILE -c '(display (effective-version))'`
AC_SUBST(GUILE_EFFECTIVE_VERSION)

AC_CONFIG_FILES([Makefile am/Makefile build-aux/Makefile m4/Makefile])
AC_CONFIG_FILES([modules/Makefile modules/telegram/Makefile modules/telegram/type/Makefile])

# Generate a Makefile, based on the results.
AC_OUTPUT

if test "$guilesitedir" != "$GUILE_SITE"; then
   # Guile has a different prefix than this module
   AC_MSG_WARN([]
   [The Guile modules will be installed in ${guilesitedir}.]
   [You should probably re-run `configure' with]
   [`--with-guilesitedir=$GUILE_SITE']
   [Otherwise, you will have to adjust the `GUILE_LOAD_PATH' environment]
   [variable.])
fi
