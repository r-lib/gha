% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/time-chunks.R
\name{knitr_time_chunks}
\alias{knitr_time_chunks}
\title{Compute duration of each knitr chunk}
\source{
Inspired by \url{https://bookdown.org/yihui/rmarkdown-cookbook/time-chunk.html}.
}
\usage{
knitr_time_chunks()
}
\description{
Call this function in a setup chunk to automatically record the amount of
time every subsequent chunk takes. This useful for identifying slow chunks,
and is generally good practice when rendering an Rmd or qmd in a
non-interactive environment.
}
