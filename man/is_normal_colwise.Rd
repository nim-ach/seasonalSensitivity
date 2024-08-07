% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is_normal.R
\name{is_normal_colwise}
\alias{is_normal_colwise}
\title{Comprueba si las columnas de un conjunto de datos siguen una distribución normal}
\usage{
is_normal_colwise(.data, ..., .by, char.only = FALSE)
}
\arguments{
\item{.data}{Un data.table. Si no lo es debe ser al menos un data.frame y despues es convertido a un data.table.}

\item{...}{Argumentos traspasados a \code{is_normal}.}

\item{.by}{Una variable en base a la cual agrupar los análisis, por defecto no se usa ninguna.}

\item{char.only}{Lógico. El argumento \code{.by} debe tratarse como un carácter? Por defecto es \code{FALSE}. De lo contrario se trata como un nombre sin comillas.}
}
\value{
Logical
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}

Wrapper alrededor de \code{is_normal} aplicando la función de manera iterativa sobre un
conjunto de datos, especificamente sobre las variables numéricas. Se puede aplicar
agrupando por un factor
}
