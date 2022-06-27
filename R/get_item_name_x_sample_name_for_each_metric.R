#' get_item_name_x_sample_name_for_each_metric
#'
#' @param input_dataframe a dataframe with repertoire metrics calculated for each item name
#' @importFrom tidyr pivot_wider
#' @importFrom tidyselect all_of
#' @return a list of dataframes that is one single repertoire metric for all items in all samples
#' @export
#' @examples
#' get_item_name_x_sample_name_for_each_metric(all_sample_all_chain_all_metrics_wide_format_dataframe)
#'
get_item_name_x_sample_name_for_each_metric <- function(input_dataframe) {

    # input_dataframe <- all_sample_all_chain_all_metrics_wide_dataframe

    metrics_names <- colnames(input_dataframe)[3:length(colnames(input_dataframe))]

    accumulation_list <- list()

    for (current_metric in metrics_names) {
        current_metric_dataframe <- input_dataframe[, c(c("item_name", "sample_name"), current_metric)]

        # long to wide so that column names are mainly sample names.
        current_new_metric_dataframe <- tidyr::pivot_wider(
            current_metric_dataframe,
            names_from = "sample_name",
            values_from = tidyselect::all_of(current_metric)
        )

        # Set row names to chain name
        current_new_metric_dataframe <- as.data.frame(current_new_metric_dataframe)
        rownames(current_new_metric_dataframe) <- current_new_metric_dataframe$item_name
        current_new_metric_dataframe$item_name <- NULL

        accumulation_list[[current_metric]] <- current_new_metric_dataframe

    }
    accumulation_list
}

# Diversity and Clonality definition

## mathematical definition, demonstration, and source code

# http://traits-dgs.nceas.ucsb.edu/workspace/r/r-tutorial-for-measuring-species-diversity/Measuring%20Diversity%20in%20R.pdf/attachment_download/file

# https://cran.r-project.org/web/packages/vegan/vignettes/diversity-vegan.pdf

# https://rdrr.io/bioc/LymphoSeq/src/R/clonality.R (source code of formula)

## Formula explicitly described in the papers

# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6124515/ (ln based, best described formula, also talk about different of the studied tumor from melanoma)

# formula:
# https://www.pnas.org/content/113/42/11919 (ln based)
# https://cancerimmunolres.aacrjournals.org/content/8/1/146 (ln based)

# https://www.tandfonline.com/doi/full/10.1080/2162402X.2019.1652538 (log2 based)
# https://www.frontiersin.org/articles/10.3389/fimmu.2019.02985/full (log2 based) (has source code)

# T-cell repertoire analysis and metrics of diversity and clonality
# https://www.sciencedirect.com/science/article/abs/pii/S0958166920301051?dgcid=rss_sd_all (can not download)
