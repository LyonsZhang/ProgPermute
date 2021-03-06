##clear current session
closeAllConnections()
rm(list=ls())

library(devtools)
install_github("LyonsZhang/ProgPermute")
library(ProgPermute)
##set the working path
setwd("/Users/lzhang27/Documents/ProgPermute/R/Binary")

######binary variable

##load packages
# source("bin_true_initial.R")
# source("bin_multitest.R")
# source("bin_exchange.R")
# source("bin_permute_all.R")
# source("plot_bin_permute_all.R")
# source("bin_permute_best.R")
# source("plot_bin_permute_best.R")
# source("plot_bin_effectsize.R")
# source("dotplot_bin_sig.R")
# source("bin_progresscoverage.R")
# source("bin_fragility.R")
# source("bin_pv_distribution.R")
# source("bin_pv_dist_transit.R")
# source("plot_bin_permute_sigcurve.R")
# source("plot_bin_psig.R")
# source("plot_bin_es.R")
# source("plot_bin_pv.R")

##read data
data(testdata1)

results<-bin_permute_all(variable="variable",testdata=testdata1,top_pm=267,zoomn=15,alpha=0.05)

####Overall association
sigloc<-plot_bin_psig(alloutputs=results,psigtitle=NULL,psigyrange=c(0,170),savepsigfile ="sigfeatures.eps", psigpicdim=c(10,7))

pvloc<-plot_bin_pv(alloutputs=results,top_pm=267,pvtitle="",pvyrange=c(0,7),savepvfile ="pvfeatures.eps", pvpicdim=c(10,7))

sigsum<-plot_bin_permute_sigcurve(alloutputs=results,samsize=267,lgndcol=2,psigtitle=NULL,savepsigfile="bin_sigcurve.eps",psigpicdim=c(10,7))

plot_bin_permute_all(alloutputs=results,top_pm=267,lgndcol=3,psigtitle=NULL,psigyrange=c(0,170),savepsigfile="bin_sigfeatures.eps",psigpicdim=c(10,7),pvtitle=NULL,pvyrange=c(0,7),savepvfile="Pvalues.eps",pvpicdim=c(10,7),estitle=NULL,esyrange=c(0,1.5),saveesfile="effectsize.eps",espicdim=c(10,7))

intres<-bin_true_initial(variable="variable",testdata=testdata1,top_pm=267)
fragility<-bin_fragility(alloutputs=results,lowindx=intres$n,top_pm=50,lgndcol=2,yrange=c(0,7),pvtitle=NULL,savepvfile="Pvfragility.eps",pvpicdim=c(15,7))

intres<-bin_true_initial(variable="variable",testdata=testdata1,top_pm=267)
coverage<-bin_progresscoverage(alloutputs=results,lowindx=intres$n,top_pm=50,lgndcol=2,pvtitle=NULL,savepvfile="Pvcoverage.eps",pvpicdim=c(15,7),estitle=NULL,saveesfile="effectcoverage.eps",espicdim=c(15,7))

bin_pv_distribution(alloutputs=results,lowindx=intres$n,folder="dist1",pvtitle=NULL,pvpicdim=c(7,7))

bin_pv_dist_transit(alloutputs=results,lowindx=intres$n,cutoff=0.05,folder="results1",pvtitle="",pvpicdim=c(7,7))

##Identify best features
best<-bin_permute_best(variable="variable",testdata=testdata1,top_pm=50,zoomn=100,alpha=0.05)

cinfresults<-plot_bin_permute_best(bestoutputs=best,top_pm=50,pvtitle="Coverage plot",savepvfile="pvalue_Coverageplot.eps",pvpicdim=c(15,10),estitle="Coverage plot",saveesfile="effectsize_Coverageplot.eps",espicdim=c(15,10))

lapply(best$goodpvname,dotplot_bin_sig,variable="variable",testdata=testdata1,folder="individual1")

plot_bin_effectsize(bestoutputs=best,variable="variable",testdata=testdata1,estitle=NULL,saveesfile="signedeffectsize_plot.eps",espicdim=c(15,10))

#####Continuous variable

##set the working path
setwd("/Users/lzhang27/Documents/ProgPermute/R/Continuous")

##read data
data(testdata2)

###load packages
# source("con_true_initial.R")
# source("con_multitest.R")
# source("con_exchange.R")
# source("con_permute_all.R")
# source("plot_con_permute_all.R")
# source("con_permute_best.R")
# source("plot_con_permute_best.R")
# source("plot_con_effectsize.R")
# source("scatterplot_con_sig.R")
# source("bin_progresscoverage.R")
# source("con_progresscoverage.R")
# source("con_fragility.R")
# source("con_pv_distribution.R")
# source("con_pv_dist_transit.R")
# source("plot_con_permute_sigcurve.R")


results<-con_permute_all(variable="variable",testdata=testdata2,top_pm=841,zoomn=15,method="kendall",alpha=0.05)

####Overall association
plot_con_permute_all(alloutputs=results,top_pm=841,lgndcol=2,psigtitle="",savepsigfile="sigfeatures.eps",psigpicdim=c(10,7),pvtitle=NULL,savepvfile="Pvalues.eps",pvpicdim=c(10,7),estitle=NULL,saveesfile="effectsizes.eps",espicdim=c(10,7),crtitle=NULL,savecrfile="correlations.eps",crpicdim=c(10,7))

sigsum<-plot_con_permute_sigcurve(alloutputs=results,samsize=841,lgndcol=2,psigtitle=NULL,savepsigfile="sigcurve.eps",psigpicdim=c(10,7))

coverage<-con_progresscoverage(alloutputs=results,top_pm=20,lgndcol=2,pvtitle=NULL,savepvfile="Pvcoverage.eps",pvpicdim=c(15,7),estitle=NULL,saveesfile="effectcoverage.eps",espicdim=c(15,7),crtitle=NULL,savecrfile="correlatecoverage.eps",crpicdim=c(15,10))

fragility<-con_fragility(alloutputs=results,top_pm=50,alpha=0.05,lgndcol=2,pvtitle=NULL,savepvfile="Pvfragility.eps",pvpicdim=c(15,7))

con_pv_distribution(alloutputs=results,folder="dist2",pvtitle=NULL,pvpicdim=c(7,7))

con_pv_dist_transit(alloutputs=results,cutoff=0.05,folder="results2",pvtitle=NULL,pvpicdim=c(7,7))

####Identify best features
best<-con_permute_best(variable="variable",testdata=testdata2,top_pm=50,zoomn=100,method="kendall",alpha=0.05)

cinfresults<-plot_con_permute_best(bestoutputs=best,pvtitle="Coverage plot",savepvfile="pvalue_Coverageplot.eps",pvpicdim=c(15,10),estitle="Coverage plot",saveesfile="effectsize_Coverageplot.eps",espicdim=c(15,10),crtitle="Coverage plot",savecrfile="correlation_Coverageplot.eps",crpicdim=c(15,10))

effectresults<-plot_con_effectsize(bestoutputs=best,variable="variable",testdata=testdata2,estitle=NULL,saveesfile="signedeffectsize_plot.eps",espicdim=c(15,10),crtitle=NULL,savecrfile="correlation_plot.eps",crpicdim=c(15,10))

lapply(best$goodpvname[-5],scatterplot_con_sig,variable="variable",testdata=testdata2,folder="individual2")

