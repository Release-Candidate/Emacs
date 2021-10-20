(defun my-class-name ()
  (file-name-sans-extension (file-name-nondirectory buffer-file-name)))

(defun my-file-name ()
  (file-name-nondirectory buffer-file-name))

(defun my-uppercase-filename ()
  (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))))

(defun my-year ()
  (format-time-string "%Y"))

(defun my-date ()
  (format-time-string "%d.%m.%Y"))

(defun my-project ()
  (file-name-nondirectory (directory-file-name (projectile-acquire-root))))

(defconst my-name "YOUR NAME")

(defconst mit-license "MIT")
(defconst gpl-license "GPL-3.0-or-later")
(defconst lgpg-license "LGPL-3.0-or-later")
(defconst agpl-license "AGPL-3.0-or-later")
(defconst my-license gpl-license)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-skeleton c-header
  "Insert default C File Header"
  nil
  "// SPDX-License-Identifier: "my-license"\n"
  "// Copyright (C) "(my-year)" "my-name"\n"
  "//\n"
  "// Project:  "(my-project)"\n"
  "// File:     "(my-file-name)"\n"
  "// Date:     "(my-date)"\n"
  "//==============================================================================\n"
  "\n")

(define-skeleton h-header
  "Insert default C Header Header"
  nil
  "// SPDX-License-Identifier: "my-license"\n"
  "// Copyright (C) "(my-year)" "my-name"\n"
  "//\n"
  "// Project:  "(my-project)"\n"
  "// File:     "(my-file-name)"\n"
  "// Date:     "(my-date)"\n"
  "//==============================================================================\n"
  "\n"
  "#ifndef "(concat "H_" (my-uppercase-filename) "_H")"\n"
  "#define "(concat "H_" (my-uppercase-filename) "_H")"\n"
  "\n"
  "#ifdef __cplusplus\n"
  "#    error This is C code, you shall use a C compiler!\n"
  "#endif\n"
  "#if __STDC_VERSION__ < 201112L\n"
  "#    error A C11 compiler is needed! This compiler is too old or has to be configured for c11\n"
  "#endif\n"
  "\n"
  "#endif // "(concat "H_" (my-uppercase-filename) "_H")"\n"
  "\n")


(define-skeleton cpp-header
  "Insert default C++ Header"
  nil
  "// SPDX-License-Identifier: "my-license"\n"
  "// Copyright (C) "(my-year)" "my-name"\n"
  "//\n"
  "// Project:  "(my-project)"\n"
  "// File:     "(my-file-name)"\n"
  "// Date:     "(my-date)"\n"
  "//==============================================================================\n"
  "\n"
  "#include \""(concat (my-uppercase-filename) ".hpp")"\"\n"
  "\n"
  "namespace "(my-project)"\n{\n\n"
  "\n\n"
  "//=============================================================================\n"
  (my-class-name)"::"(my-class-name)"()\n"
  "{\n"
  "}\n"
  "\n"
  "//=============================================================================\n"
  (my-class-name)"::~"(my-class-name)"()\n"
  "{\n"
  "}\n"
  "\n"
  "\n} // namespace "(my-project)"\n"
  "\n")

(define-skeleton hpp-header
  "Insert default C++ Header Header"
  nil
  "// SPDX-License-Identifier: "my-license"\n"
  "// Copyright (C) "(my-year)" "my-name"\n"
  "//\n"
  "// Project:  "(my-project)"\n"
  "// File:     "(my-file-name)"\n"
  "// Date:     "(my-date)"\n"
  "//==============================================================================\n"
  "\n\n"
  "#ifndef "(concat "HPP_" (my-uppercase-filename) "_HPP")"\n"
  "#define "(concat "HPP_" (my-uppercase-filename) "_HPP")"\n"
  "\n\n"
  "namespace "(my-project)"\n{\n\n"
  "///\n"
  "class "(my-class-name)"\n"
  "{\n"
  "public:\n\n"
  "    /// Constructor.\n"
  "    "(my-class-name)"();\n\n"
  "    /// Destructor.\n"
  "    ~"(my-class-name)"();\n\n"
  "private:\n"
  "\n\n}; // class "(my-class-name)"\n"
  "\n} // namespace "(my-project)"\n"
  "\n"
  "#endif // "(concat "HPP_" (my-uppercase-filename) "_HPP")"\n"
  "\n")

(define-skeleton python-header
  "Insert default Python Header"
  nil
  "# SPDX-License-Identifier: "my-license"\n"
  "# Copyright (C) "(my-year)" "my-name"\n"
  "#\n"
  "# Project:  "(my-project)"\n"
  "# File:     "(my-file-name)"\n"
  "# Date:     "(my-date)"\n"
  "#===============================================================================\n"
  "\n"
  "from __future__ import annotations\n"
  "\n")

(define-skeleton bash-header
  "Insert default Bash Header"
  nil
  "#!/usr/bin/bash\n"
  "#\n"
  "# SPDX-License-Identifier: "my-license"\n"
  "# Copyright (C) "(my-year)" "my-name"\n"
  "#\n"
  "# Project:  "(my-project)"\n"
  "# File:     "(my-file-name)"\n"
  "# Date:     "(my-date)"\n"
  "#===============================================================================\n"
  "\n")

(define-skeleton lisp-header
  "Insert default LISP Header"
  nil
  ";;; SPDX-License-Identifier: "my-license"\n"
  ";;; Copyright (C) "(my-year)" "my-name"\n"
  ";;;\n"
  ";;; Project:  "(my-project)"\n"
  ";;; File:     "(my-file-name)"\n"
  ";;; Date:     "(my-date)"\n"
  ";;;=============================================================================\n"
  "\n")

(define-skeleton js-header
  "Insert default Javascript File Header"
  nil
  "// SPDX-License-Identifier: "my-license"\n"
  "// Copyright (C) "(my-year)" "my-name"\n"
  "//\n"
  "// Project:  "(my-project)"\n"
  "// File:     "(my-file-name)"\n"
  "// Date:     "(my-date)"\n"
  "//==============================================================================\n"
  "\n")

(define-skeleton html-header
  "Insert default HTML File Header"
  nil
  "<!DOCTYPE html>\n"
  "<html>\n"
  "  <head>\n"
  "    <meta charset=\"utf-8\"/>\n"
  "  </head>\n"
  "  <body>\n"
  "\n"
  "  </body>\n"
  "</html>\n"
  "\n")

(add-hook 'find-file-hook 'auto-insert)
(setq auto-insert-alist '((python-mode . python-header)
                          (sh-mode . bash-header)
                          (lisp-mode . lisp-header)
                          (js-mode . js-header)
                          (mhtml-mode . html-header)
                          (html-mode . html-header)
                          ("\\.cpp" . cpp-header)
                          ("\\.hpp" . hpp-header)
                          ("\\.h" . h-header)
                          ("\\.c" . c-header)))

(setq auto-insert-query nil)
