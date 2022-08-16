#' Global variables
#' @name the global variables
#' @title Make variable names global to avoid CHECK notes
#'
#' @importFrom utils globalVariables
utils::globalVariables(c("."))


# global variable and function issue
#
# https://github.com/tidyverse/magrittr/issues/29
# https://stackoverflow.com/questions/40251801/how-to-use-utilsglobalvariables
#
#
# https://bookdown.org/rdpeng/RProgDA/non-standard-evaluation.html
# https://stackoverflow.com/questions/39439006/package-dependencies-for-r-base-packages
# https://stackoverflow.com/questions/48750221/dplyr-and-no-visible-binding-for-global-variable-note-in-package-check
