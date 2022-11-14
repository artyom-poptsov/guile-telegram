;; guix.scm --- GNU Guix package recipe    -*- coding: utf-8 -*-
;;
;; Copyright (C) 2022 Artyom V. Poptsov <poptsov.artyom@gmail.com>
;;
;; Author: Artyom V. Poptsov <poptsov.artyom@gmail.com>
;; Created: 14 November 2022
;;
;; This file is part of Guile-Telegram.
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; The program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with the program.  If not, see <http://www.gnu.org/licenses/>.


;;; Commentary:
;;
;; GNU Guix development package. To use as the basis for a development
;; environment, run:
;;
;;  guix shell -D -f guix.scm
;;
;; In the new shell, run:
;;
;;  autoreconf -vif && ./configure && make check
;;
;;; Code:


(use-modules (guix gexp)
             (guix packages)
             (guix licenses)
             (guix git-download)
             (guix build-system gnu)
             (gnu packages autotools)
             (gnu packages guile)
             (gnu packages guile-xyz)
             (gnu packages bash)
             (gnu packages curl)
             (gnu packages pkg-config)
             (gnu packages tex)
             (gnu packages texinfo))


(define %source-dir (dirname (current-filename)))


(package
    (name "guile-telegram")
    (version "git")
    (source (local-file %source-dir
                        #:recursive? #t
                        #:select? (git-predicate %source-dir)))
    (build-system gnu-build-system)
    (arguments
     `(#:make-flags '("GUILE_AUTO_COMPILE=0")))     ;to prevent guild warnings
    (native-inputs
     (list autoconf automake pkg-config texinfo texlive))
    (inputs
     (list bash-minimal
           guile-3.0
           guile-lib
           guile-json-4
           curl))
    (home-page "https://github.com/artyom-poptsov/guile-ini")
    (synopsis "Guile library Telegram bot API")
    (description
     "@code{guile-telegram} is a GNU Guile library that allows to use Telegram bot
API.")
    (license gpl3))

;;; guix.scm ends here.
