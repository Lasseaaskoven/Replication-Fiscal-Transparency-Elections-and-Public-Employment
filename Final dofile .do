
*Setting of time and unit*
tsset countrynr year


*Table 1: Full models fixed-effects with and without elecionts 
xtreg publicemploymentpctemployment   c.gdpgrowthrateoecd##c.altlassenmodindex generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb i.year, fe cluster (countrynr),if year>1994
xtreg publicemploymentpctemployment   c.gdpgrowthrateoecd##c.altlassenmodindex##c.chiefexelection generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  unemploymentoecd leftwingchiefexecutive  population014wb populationaged65wb i.year, fe cluster (countrynr),if year>1994


*Figure 1: Visual interaction*
xtreg publicemploymentpctemployment  generalgovernmentexpenditureimf chiefexelection  c.gdpgrowthrateoecd##c.altlassenmodindex gdppercapitalconstantpricesoecd  unemploymentoecd leftwingchiefexecutive population014wb populationaged65wb i.year, fe cluster (countrynr),if year>1994
margins,noestimcheck dydx(gdpgrowthrate) over(altlassenmodindex)
marginsplot, level(90)ylabel(-0.2(0.1)0.2) ytitle(Effect of growth on public employment) xtitle(Fiscal transparency)scheme(s2mono)  graphregion(color(white))legend (off)


xtreg publicemploymentpctemployment   c.gdpgrowthrateoecd##c.altlassenmodindex##c.chiefexelection generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  unemploymentoecd leftwingchiefexecutive  population014wb populationaged65wb i.year, fe cluster (countrynr),if year>1994
margins, noestimcheck dydx(gdpgrowthrateoecd) over(altlassenmodindex), if chiefexelection==1
marginsplot, level(90)ylabel(-0.4(0.1)0.3) ytitle(Effect of growth on public employment) xtitle(Fiscal transparency)scheme(s2mono)  graphregion(color(white))legend (off)

xtreg publicemploymentpctemployment   c.gdpgrowthrateoecd##c.altlassenmodindex##c.chiefexelection generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  unemploymentoecd leftwingchiefexecutive  population014wb populationaged65wb i.year, fe cluster (countrynr),if year>1994
margins, noestimcheck dydx(gdpgrowthrateoecd) over(altlassenmodindex), if chiefexelection==0
marginsplot, level(90)ylabel(-0.4(0.1)0.3) ytitle(Effect of growth on public employment) xtitle(Fiscal transparency)scheme(s2mono)  graphregion(color(white))legend (off)




*Table 2: Arreallno-Bond* 
*Generation of relevant variables*
generate gdpgrowthaltlassen= gdpgrowthrateoecd*altlassenmodindex
generate gdpgrowthelection=  gdpgrowthrateoecd*chiefexelection
generate altlassenelection=altlassenmodindex*chiefexelection
generate threewayinteraction= gdpgrowthrateoecd*altlassenmodindex*chiefexelection
tabulate year, gen(year)


xtabond publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, lags(1),if year>1994

xtabond publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, lags(1),if year>1994

xtabond2 publicemploymentpctemployment l.publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, gmm (l.publicemploymentpctemployment) iv ( generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26) nolevel robust small ,if year>1994


xtabond2 publicemploymentpctemployment l.publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, gmm (l.publicemploymentpctemployment) iv ( generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26) nolevel robust small ,if year>1994


*Table 3: Question of endogenous vs. predicted elections*

*Creating endogenous election dummy and the relevant interactions*
generate endogenouselection=0
replace endogenouselection=1 if chiefexelection==1 & predictedelection==0

generate gdpgrowthelectonpredicedelection= predictedelection*gdpgrowthrateoecd
generate altlassenpredictedelection=altlassenmodindex*predictedelection
generate threewayinteractionpredicted= gdpgrowthrateoecd*altlassenmodindex*predictedelection


generate gdpgrowthendoelection= endogenouselection*gdpgrowthrateoecd
generate altlassenendoelection=altlassenmodindex*endogenouselection
generate threewayinteractionendoelection= gdpgrowthrateoecd*altlassenmodindex*endogenouselection

xtabond publicemploymentpctemployment gdpgrowthaltlassen  predictedelection gdpgrowthelectonpredicedelection altlassenpredictedelection threewayinteractionpredicted generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive  population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, lags(1),if year>1994
xtabond publicemploymentpctemployment gdpgrowthaltlassen endogenouselection gdpgrowthendoelection altlassenendoelection  threewayinteractionendoelection generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive  population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, lags(1),if year>1994



xtabond2 publicemploymentpctemployment l.publicemploymentpctemployment predictedelection gdpgrowthelectonpredicedelection altlassenpredictedelection threewayinteractionpredicted generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive  population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, gmm (l.publicemploymentpctemployment) iv ( generalgovernmentexpenditureimf predictedelection gdpgrowthelectonpredicedelection altlassenpredictedelection threewayinteractionpredicted gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26) nolevel robust small ,if year>1994
xtabond2 publicemploymentpctemployment l.publicemploymentpctemployment endogenouselection gdpgrowthendoelection altlassenendoelection  threewayinteractionendoelection generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive  population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, gmm (l.publicemploymentpctemployment) iv ( generalgovernmentexpenditureimf endogenouselection gdpgrowthendoelection altlassenendoelection  threewayinteractionendoelection gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26) nolevel robust small ,if year>1994


*Table 4: Robustness tests*


*1995-1998 excluded*
xtabond publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, lags(1),if year>1998
xtabond publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, lags(1),if year>1998


xtabond2 publicemploymentpctemployment l.publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, gmm (l.publicemploymentpctemployment) iv ( generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26) nolevel robust small ,if year>1998
xtabond2 publicemploymentpctemployment l.publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, gmm (l.publicemploymentpctemployment) iv ( generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26) nolevel robust small ,if year>1998


*2006-2010 excluded*
xtabond publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, lags(1),if year>1994 & year<2006
xtabond publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, lags(1),if year>1994 & year<2006


xtabond2 publicemploymentpctemployment l.publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, gmm (l.publicemploymentpctemployment) iv ( generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26) nolevel robust small ,if year>1994 & year<2006

xtabond2 publicemploymentpctemployment l.publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, gmm (l.publicemploymentpctemployment) iv ( generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26) nolevel robust small,if year>1994 & year<2006



*Excluding Greece
xtabond publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, lags(1),if year>1994 & countrynr!=9 
xtabond publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, lags(1),if year>1994 & countrynr!=9 

xtabond2 publicemploymentpctemployment l.publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, gmm (l.publicemploymentpctemployment) iv ( generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26) nolevel robust small ,if year>1994 & countrynr!=9 

xtabond2 publicemploymentpctemployment l.publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, gmm (l.publicemploymentpctemployment) iv ( generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26) nolevel robust small ,if year>1994 & countrynr!=9 



*Excluding New Zealand*
xtabond2 publicemploymentpctemployment l.publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, gmm (l.publicemploymentpctemployment) iv ( generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26) nolevel robust small ,if year>1994 & countrynr!=14
xtabond2 publicemploymentpctemployment l.publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, gmm (l.publicemploymentpctemployment) iv ( generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26) nolevel robust small ,if year>1994 &  countrynr!=14


* Appendix A: Deskriptive statistics*
xtsum publicemploymentpctemployment  gdpgrowthrateoecd altlassenmodindex generalgovernmentexpenditureimf  gdppercapitalconstantpricesoecd  unemploymentoecd  leftwingchiefexecutive chiefexelection population014wb populationaged65wb if year>1994 & countrynr!=12 & publicemploymentpctemployment!=. &  generalgovernmentexpenditureimf!=.


*Appenedix 2: Excluding Austria*
xtabond publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, lags(1),if year>1994 & countrynr!=2
xtabond publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, lags(1),if year>1994 & countrynr!=2


xtreg publicemploymentpctemployment   c.gdpgrowthrateoecd##c.altlassenmodindex generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb i.year, fe cluster (countrynr),if year>1994 & countrynr!=2
xtreg publicemploymentpctemployment   c.gdpgrowthrateoecd##c.altlassenmodindex##c.chiefexelection generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  unemploymentoecd leftwingchiefexecutive  population014wb populationaged65wb i.year, fe cluster (countrynr),if year>1994 & countrynr!=2

xtabond2 publicemploymentpctemployment l.publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, gmm (l.publicemploymentpctemployment) iv ( generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26) nolevel robust small ,if year>1994 & countrynr!=2
xtabond2 publicemploymentpctemployment l.publicemploymentpctemployment generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, gmm (l.publicemploymentpctemployment) iv ( generalgovernmentexpenditureimf gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26) nolevel robust small ,if year>1994 & countrynr!=2





*Appendix 3: Lagged economic controls*
xtabond publicemploymentpctemployment generalgovernmentexpenditureimf l.gdppercapitalconstantpricesoecd gdpgrowthaltlassen gdpgrowthrateoecd l.unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, lags(1),if year>1994
xtabond publicemploymentpctemployment generalgovernmentexpenditureimf l.gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd l.unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, lags(1),if year>1994


xtreg publicemploymentpctemployment   c.gdpgrowthrateoecd##c.altlassenmodindex generalgovernmentexpenditureimf l.gdppercapitalconstantpricesoecd  l.unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb i.year, fe cluster (countrynr),if year>1994
xtreg publicemploymentpctemployment   c.gdpgrowthrateoecd##c.altlassenmodindex##c.chiefexelection generalgovernmentexpenditureimf l.gdppercapitalconstantpricesoecd  l.unemploymentoecd leftwingchiefexecutive  population014wb populationaged65wb i.year, fe cluster (countrynr),if year>1994

xtabond2 publicemploymentpctemployment l.publicemploymentpctemployment generalgovernmentexpenditureimf l.gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd l.unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, gmm (l.publicemploymentpctemployment) iv ( generalgovernmentexpenditureimf l.gdppercapitalconstantpricesoecd  gdpgrowthaltlassen gdpgrowthrateoecd l.unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26) nolevel robust small ,if year>1994
xtabond2 publicemploymentpctemployment l.publicemploymentpctemployment generalgovernmentexpenditureimf l.gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd l.unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26, gmm (l.publicemploymentpctemployment) iv ( generalgovernmentexpenditureimf l.gdppercapitalconstantpricesoecd gdpgrowthelection altlassenelection threewayinteraction gdpgrowthaltlassen gdpgrowthrateoecd l.unemploymentoecd leftwingchiefexecutive chiefexelection population014wb populationaged65wb year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22 year23 year24 year25 year26) nolevel robust small ,if year>1994
