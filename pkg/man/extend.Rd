\name{extend}
\alias{extend}
\alias{magic.wand}
\title{The extend function}
\description{
  Functions to extend the package with big data versions of data frame functions from packages base and dplyr or user-defined.
}
\usage{
extend(pack=c("base", "dplyr"), envir = parent.frame())
magic.wand(f, non.standard.args = FALSE, envir = parent.frame(), 
		mergeable = FALSE, vectorized = FALSE)}
\arguments{
	\item{pack}{The package from which the functions to be converted should be taken}
  \item{envir}{The environment to which new functions should be added}
  \item{non.standard.args}{whether \code{f} accepts arguments to be evaluated using \link{non standard evaluation} rules, like \code{\link{transform}}}
   \item{f}{A function of a data frame returning a data frame (attempts are made to coerce a non data frame return value to a data frame, but your milage may vary; vectors become single column data frames).}
   \item{mergeable}{Whether the function f satisfies the conditions for mergeability, see \code{\link{mergeable}}}
   \item{vectorized}{Whether the function f satisfies the conditions for vectorization, see \code{\link{vectorized}}}
}
\details{ 
\code{magic.wand} creates a generic named \code{f} with two methods, one for data.frames, which calls \code{f} itself, and one for pipes which calls \code{gapply(.data, f, \dots)}.
	Extend defines big data versions for \code{transform} and \code{subset} from package base and \code{mutate}, \code{summarize} and \code{filter} from dplyr. These functions don't add fundamentally new capabilities to plyrmr, but may be preferred by people already familiar with them. Hence they are not part of the package, but can be defined on demand. The \code{summarize} function is added in two versions, one called \code{summarize} and the other \code{summarize_mergeable}, the latter to be used when the operation described in the arguments is associative and commutative. For instance \code{summarize_mergeable(x, sum(col.1))} but \code{summarize(x, mean(col.1))}. The former has an advantage in efficiency and scalability and so should be preferred.}
\value{
NULL, useful only for their side-effects}
\examples{
#extend row.names to work on pipes
magic.wand(row.names)
#extend("dplyr")}
