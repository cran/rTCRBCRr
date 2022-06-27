#' calibrate_proportion_by_clones
#'
#' @param a_dataframe a dataframe
#' @return a dataframe
#' @import magrittr
#' @export
calibrate_proportion_by_clones <- function(a_dataframe) {
    processed_dataframe <- a_dataframe %>%
        inset(., "Proportion", value = .$Clones / sum(.$Clones)) %>%
        .[order(-.$Clones), ]

    processed_dataframe
}
