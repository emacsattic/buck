;;; buck.el --- Client library for the Bitbucket API  -*- lexical-binding:t -*-

;; Copyright (C) 2016-2025 Jonas Bernoulli

;; Author: Jonas Bernoulli <emacs.ghub@jonas.bernoulli.dev>
;; Homepage: https://github.com/emacsattic/buck
;; Keywords: tools

;; Package-Version: 4.99
;; Package-Requires: ((ghub "4"))

;; SPDX-License-Identifier: GPL-3.0-or-later

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation, either version 3 of the License,
;; or (at your option) any later version.
;;
;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this file.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This package provides convenience wrappers, specialized for Bitbucket,
;; around functions provided by the `ghub' package (which, unless told
;; otherwise, assumes it is talking to a Github host).

;; Instead of   (ghub-get ... :forge 'bitbucket)
;; you can use  (buck-get ...)

;; This package is semi-deprecated.  You might learn that in your own
;; package you have to further wrap `buck-VERB' functions, and if you
;; do that, you might as well wrap `ghub-VERB' or even `ghub-request'
;; directly.

;;; Code:

(require 'ghub)

(cl-defun buck-get (resource &optional params
                             &key query payload headers
                             silent unpaginate noerror reader
                             username auth host
                             callback errorback extra)
  "Make a `GET' request for RESOURCE, with optional query PARAMS.
Like calling `ghub-request' (which see) with \"GET\" as METHOD
and `bitbucket' as FORGE."
  (ghub-request "GET" resource params :forge 'bitbucket
                :query query :payload payload :headers headers
                :silent silent :unpaginate unpaginate
                :noerror noerror :reader reader
                :username username :auth auth :host host
                :callback callback :errorback errorback :extra extra))

(cl-defun buck-put (resource &optional params
                             &key query payload headers
                             silent unpaginate noerror reader
                             username auth host
                             callback errorback extra)
  "Make a `PUT' request for RESOURCE, with optional payload PARAMS.
Like calling `ghub-request' (which see) with \"PUT\" as METHOD
and `bitbucket' as FORGE."
  (ghub-request "PUT" resource params :forge 'bitbucket
                :query query :payload payload :headers headers
                :silent silent :unpaginate unpaginate
                :noerror noerror :reader reader
                :username username :auth auth :host host
                :callback callback :errorback errorback :extra extra))

(cl-defun buck-post (resource &optional params
                              &key query payload headers
                              silent unpaginate noerror reader
                              username auth host
                              callback errorback extra)
  "Make a `POST' request for RESOURCE, with optional payload PARAMS.
Like calling `ghub-request' (which see) with \"POST\" as METHOD
and `bitbucket' as FORGE."
  (ghub-request "POST" resource params :forge 'bitbucket
                :query query :payload payload :headers headers
                :silent silent :unpaginate unpaginate
                :noerror noerror :reader reader
                :username username :auth auth :host host
                :callback callback :errorback errorback :extra extra))

(cl-defun buck-delete (resource &optional params
                                &key query payload headers
                                silent unpaginate noerror reader
                                username auth host
                                callback errorback extra)
  "Make a `DELETE' request for RESOURCE, with optional payload PARAMS.
Like calling `ghub-request' (which see) with \"DELETE\" as METHOD
and `bitbucket' as FORGE."
  (ghub-request "DELETE" resource params :forge 'bitbucket
                :query query :payload payload :headers headers
                :silent silent :unpaginate unpaginate
                :noerror noerror :reader reader
                :username username :auth auth :host host
                :callback callback :errorback errorback :extra extra))

(cl-defun buck-request (method resource &optional params
                               &key query payload headers
                               silent unpaginate noerror reader
                               username auth host
                               callback errorback extra)
  "Make a request for RESOURCE and return the response body.
Like calling `ghub-request' (which see) with `bitbucket' as FORGE."
  (ghub-request method resource params :forge 'bitbucket
                :query query :payload payload :headers headers
                :silent silent :unpaginate unpaginate
                :noerror noerror :reader reader
                :username username :auth auth :host host
                :callback callback :errorback errorback :extra extra))

(cl-defun buck-repository-id (owner name &key username auth host)
  "Return the id of the repository specified by OWNER, NAME and HOST."
  (substring (cdr (assq 'uuid
                        (ghub-get (format "/repositories/%s/%s" owner name)
                                  nil :forge 'bitbucket
                                  :username username :auth auth :host host)))
             1 -1))

;;; _
(provide 'buck)
;;; buck.el ends here
