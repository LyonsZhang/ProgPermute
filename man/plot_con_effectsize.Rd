\name{plot_con_effectsize}
\alias{plot_con_effectsize}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{plot_con_effectsize}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
plot_con_effectsize(bestoutputs, variable, testdata, estitle = NULL, saveesfile, espicdim, crtitle = NULL, savecrfile, crpicdim, goodtype = "goodpvname", effecttext = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{bestoutputs}{
%%     ~~Describe \code{bestoutputs} here~~
}
  \item{variable}{
%%     ~~Describe \code{variable} here~~
}
  \item{testdata}{
%%     ~~Describe \code{testdata} here~~
}
  \item{estitle}{
%%     ~~Describe \code{estitle} here~~
}
  \item{saveesfile}{
%%     ~~Describe \code{saveesfile} here~~
}
  \item{espicdim}{
%%     ~~Describe \code{espicdim} here~~
}
  \item{crtitle}{
%%     ~~Describe \code{crtitle} here~~
}
  \item{savecrfile}{
%%     ~~Describe \code{savecrfile} here~~
}
  \item{crpicdim}{
%%     ~~Describe \code{crpicdim} here~~
}
  \item{goodtype}{
%%     ~~Describe \code{goodtype} here~~
}
  \item{effecttext}{
%%     ~~Describe \code{effecttext} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (bestoutputs, variable, testdata, estitle = NULL, saveesfile, 
    espicdim, crtitle = NULL, savecrfile, crpicdim, goodtype = "goodpvname", 
    effecttext = FALSE) 
{
    select <- switch(goodtype, goodpsigname = bestoutputs$goodpsigname, 
        goodpvname = bestoutputs$goodpvname, goodesname = bestoutputs$goodesname, 
        goodcrname = bestoutputs$goodcrname, stop("goodtype must be one of the follows: 'goodpsigname', 'goodpvname', 'goodesname' and 'goodcrname'. "))
    selname <- bestoutputs$selname
    df <- data.frame(matrix(0, length(selname), 2))
    row.names(df) <- selname
    colnames(df) <- c("selname", "effectsize")
    df$selname <- selname
    df$effectsize <- bestoutputs$effectsize0
    df1 <- df[selname \%in\% select, ]
    df1$signed <- sign(df1$effectsize)
    temp <- df1[df1$signed == -1, ]
    temp <- temp[order(temp$effectsize), ]
    df1 <- rbind(df1[df1$signed == 1, ], temp)
    df1$selname <- factor(df1$selname, levels = df1$selname)
    df1[[variable]] <- factor(ifelse(df1$signed == 1, "positive", 
        "negative"))
    p <- ggplot(df1, aes(selname, effectsize)) + geom_bar(stat = "identity", 
        aes_string(fill = variable)) + scale_fill_manual(values = c("#00b0f6", 
        "#f8766d")) + geom_hline(yintercept = 0, size = 2) + 
        ylab("Effect size") + xlab("Selected features with decreasing order") + 
        coord_flip() + ggtitle(estitle) + theme_bw() + theme(plot.title = element_text(size = 30, 
        face = "bold"), legend.title = element_text(size = 20), 
        legend.text = element_text(size = 16)) + theme(axis.line = element_line(colour = "black"), 
        panel.border = element_blank(), panel.background = element_blank(), 
        axis.line.x = element_line(color = "black", size = 1), 
        axis.line.y = element_line(color = "black", size = 1), 
        axis.text = element_text(size = 16, face = "bold"), axis.title = element_text(size = 20, 
            face = "bold"))
    if (effecttext == TRUE) {
        p <- p + geom_text(aes(label = round(effectsize, 2), 
            hjust = 0.5, angle = 0))
    }
    p
    ggsave(filename = saveesfile, width = espicdim[1], height = espicdim[2])
    df <- data.frame(matrix(0, length(selname), 2))
    row.names(df) <- selname
    colnames(df) <- c("selname", "correlation")
    df$selname <- selname
    df$correlation <- bestoutputs$correlation0
    df2 <- df[selname \%in\% select, ]
    df2$signed <- sign(df2$correlation)
    temp <- df2[df2$signed == -1, ]
    temp <- temp[order(temp$correlation), ]
    df2 <- rbind(df2[df2$signed == 1, ], temp)
    df2$selname <- factor(df2$selname, levels = df2$selname)
    df2[[variable]] <- factor(ifelse(df2$signed == 1, "positive", 
        "negative"))
    p <- ggplot(df2, aes(selname, correlation)) + geom_bar(stat = "identity", 
        aes_string(fill = variable)) + scale_fill_manual(values = c("#00b0f6", 
        "#f8766d")) + geom_hline(yintercept = 0, size = 2) + 
        ylab("Correlation") + xlab("Selected features with decreasing order") + 
        coord_flip() + ggtitle(crtitle) + theme_bw() + theme(plot.title = element_text(size = 30, 
        face = "bold"), legend.title = element_text(size = 20), 
        legend.text = element_text(size = 16)) + theme(axis.line = element_line(colour = "black"), 
        panel.border = element_blank(), panel.background = element_blank(), 
        axis.line.x = element_line(color = "black", size = 1), 
        axis.line.y = element_line(color = "black", size = 1), 
        axis.text = element_text(size = 16, face = "bold"), axis.title = element_text(size = 20, 
            face = "bold"))
    if (effecttext == TRUE) {
        p <- p + geom_text(aes(label = round(correlation, 2), 
            hjust = 0.5, angle = 0))
    }
    p
    ggsave(filename = savecrfile, width = crpicdim[1], height = crpicdim[2])
    return(list(sigeffectsize = df1, sigcorrelation = df2))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
