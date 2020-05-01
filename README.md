# ProgPermute
> Progressive permutation for a dynamic representation of the robustness of microbiome discoveries

The proposed method progressively permutes the grouping factor labels of microbiome and performs multiple differential abundance tests in each scenario. We compare the signal strength of top hits from the original data with their performance in permutations, and will observe an apparent decreasing trend if these top hits are true positives identified from the data. To help understand the robustness of the discoveries and identify best hits, we develop a user-friendly and efficient RShiny tool. Simulations and applications on real data show that the proposed method can evaluate the overall association between microbiome and the grouping factor, rank the robustness of the discovered microbes, and list the discoveries, their effect sizes, and individual abundances.

---

# Table of Contents
=================
<!--ts-->
- [Installation](#installation)
- [Example](#example)
   * [Binary outcome](#binary_outcome)
   * [Continuous outcome](#continuous_outcome)
- [Contributing](#contributing)
- [Team](#team)
- [FAQ](#faq)
- [Support](#support)
- [License](#license)
<!--te-->

## Installation
============

1. If you don't have "devtools" package, you need to download it by using 
```R
install.packages("devtools")
```

2. Run the following codes:
```R
library(devtools)
install_github("LyonsZhang/ProgPermute")
library(ProgPermute)
```
3. Run the example codes in "Exucute_ProgPermute.R" in the test folder.

#
If you have any questions, please contact me at liangliangzhang.stat@gmail.com

## Example

### Binary outcome
>clear current session
```R
closeAllConnections()
rm(list=ls())
```
>load data
```R
data(testdata1)
```

results<-bin_permute_all(variable="variable",testdata=testdata1,top_pm=267,zoomn=15,alpha=0.05)

####Overall association
sigloc<-plot_bin_psig(alloutputs=results,psigtitle=NULL,psigyrange=c(0,170),savepsigfile ="location_sigfeatures.eps", psigpicdim=c(10,7))

pvloc<-plot_bin_pv(alloutputs=results,top_pm=267,pvtitle="",pvyrange=c(0,7),savepvfile ="location_pvfeatures.eps", pvpicdim=c(10,7))

plot_bin_permute_all(alloutputs=results,top_pm=267,lgndcol=3,psigtitle=NULL,psigyrange=c(0,170),savepsigfile="bin_locationsigfeatures.eps",psigpicdim=c(10,7),pvtitle=NULL,pvyrange=c(0,7),savepvfile="locationPvalues.eps",pvpicdim=c(10,7),estitle=NULL,esyrange=c(0,1.5),saveesfile="locationeffectsize.eps",espicdim=c(10,7))

sigsum<-plot_bin_permute_sigcurve(alloutputs=results,samsize=267,lgndcol=2,psigtitle=NULL,savepsigfile="bin_locationsigcurve.eps",psigpicdim=c(10,7))

intres<-bin_true_initial(variable="variable",testdata=testdata1,top_pm=267)
coverage<-bin_progresscoverage(alloutputs=results,lowindx=intres$n,top_pm=50,lgndcol=2,pvtitle=NULL,savepvfile="locationPvcoverage.eps",pvpicdim=c(15,7),estitle=NULL,saveesfile="locationeffectcoverage.eps",espicdim=c(15,7))

intres<-bin_true_initial(variable="variable",testdata=testdata1,top_pm=267)
fragility<-bin_fragility(alloutputs=results,lowindx=intres$n,top_pm=50,lgndcol=2,yrange=c(0,7),pvtitle=NULL,savepvfile="locationPvfragility.eps",pvpicdim=c(15,7))

bin_pv_distribution(alloutputs=results,lowindx=intres$n,folder="dist1",pvtitle=NULL,pvpicdim=c(7,7))

bin_pv_dist_transit(alloutputs=results,lowindx=intres$n,cutoff=0.05,folder="results1",pvtitle="",pvpicdim=c(7,7))

##Identify best features
best<-bin_permute_best(variable="variable",testdata=testdata1,top_pm=50,zoomn=100,alpha=0.05)

cinfresults<-plot_bin_permute_best(bestoutputs=best,top_pm=50,pvtitle="Coverage plot",savepvfile="Race_pvalue_Coverageplot.eps",pvpicdim=c(15,10),estitle="Coverage plot",saveesfile="Race_effectsize_Coverageplot.eps",espicdim=c(15,10))

lapply(best$goodpvname,dotplot_bin_sig,variable="variable",testdata=testdata1,folder="individual1")

plot_bin_effectsize(bestoutputs=best,variable="variable",testdata=testdata1,estitle=NULL,saveesfile="location_signedeffectsize_plot.eps",espicdim=c(15,10))

