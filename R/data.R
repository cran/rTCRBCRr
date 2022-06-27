#' @title Raw clonotype output from trust4
#'
#' @description An example dataframe for raw clonotype identified by trust4
#'
#' @format A data frame with m rows and n variables:
#' @source <https://github.com/liulab-dfci/TRUST4>
"raw_input_clonotype_dataframe"

#' @title An converted dataframe to immunarch format
#'
#' @description An example dataframe converted to immunarch format
#'
#' @format A data frame with m rows and n variables:
#' @source <https://github.com/immunomind/immunarch/>
"immunarch_style_dataframe"

#' @title a dataframe with nonproductive CDR3aa removed
#'
#' @description an example dataframe with nonproductive CDR3aa removed
#'
#' @format A data frame with m rows and n variables:
#' @source <https://mixcr.readthedocs.io/en/master/analyze.html>
"nonproductive_CDR3aa_removed_dataframe"

#' @title a dataframe separated by chain name
#'
#' @description an example dataframe separated by chain name
#'
#' @format A data frame with m rows and n variables:
#' @source <https://en.wikipedia.org/wiki/T-cell_receptor>
"chain_separated_dataframe"

#' @title a dataframe where convergent clonotypes are merged
#'
#' @description an example dataframe where convergent clonotypes are merged
#'
#' @format A data frame with m rows and n variables:
#' @source <https://www.frontiersin.org/articles/10.3389/fimmu.2019.02985/full>
"convergent_clonotype_merged_dataframe"

#' @title a list of dataframe where convergent clonotypes are merged
#'
#' @description an list of example dataframes where convergent clonotypes are merged
#'
#' @format A list of data frame with m rows and n variables:
#' @source <https://www.frontiersin.org/articles/10.3389/fimmu.2019.02985/full>
"the_divergent_clonotype_dataframe_list"

#' @title a dataframe list to combine rowwise.
#'
#' @description The element data frame must be generated from compute_repertoire_metrics_by_chain_name function
#'
#' @format A list of data frames with m rows and n variables:
#' @source <https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/list>
"all_sample_all_chain_all_metrics_wide_format_dataframe_list"


#' @title a dataframe of wide format
#'
#' @description The data frame must be generated from combine_all_sample_repertoire_metrics function
#'
#' @format A data frame with m rows and n variables:
#' @source <https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/list>
"all_sample_all_chain_all_metrics_wide_format_dataframe"

#' @title a list of dataframes
#'
#' @description The list of data frames generated from get_item_name_x_sample_name_for_each_metric
#'
#' @format A list of data frame with m rows and n variables:
#' @source <https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/list>
"all_sample_all_chain_individual_metrics_dataframe_list"


#' @title a dataframe list to combine rowwise.
#'
#' @description The element data frame must be generated from calculate_IGH_isotype_proportion function
#'
#' @format A list of data frames with m rows and n variables:
#' @source <https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/list>
"all_sample_IGH_chain_all_metrics_wide_format_dataframe_list"


#' @title a dataframe of wide format
#'
#' @description The data frame must be generated from combine_all_sample_repertoire_metrics function
#'
#' @format A data frame with m rows and n variables:
#' @source <https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/list>
"all_sample_IGH_chain_all_metrics_wide_format_dataframe"

#' @title a list of dataframes
#'
#' @description The list of data frames generated from get_item_name_x_sample_name_for_each_metric
#'
#' @format A list of data frame with m rows and n variables:
#' @source <https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/list>
"all_sample_IGH_chain_individual_metrics_dataframe_list"

