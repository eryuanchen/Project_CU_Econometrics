*1.preparation (data_1.csv is the dataset should be first put into the file. Then use the cd command)
insheet using"data_1.csv",clear

summarize

tab invest_year,gen(dummy_year)
tab industry,gen(dummy_area)

gen experience_2 = experience^2

*2.Empirical Study I: How the Network Position Influence the Investment Return

**2.1.Hyporhesis 1: Whether a VC Fund adopts co-investment strategy would NOT have significant impact on the return.
logit ipo_exit coinvest foreign experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r

**2.2.Hypothesis 2: The network position of a VC firm would have significant positive impact on the return.

***2.2.1.the correlation Matrix of the 3 key network position indices（相关系数矩阵）
correlate individual_degree individual_between individual_eigen

***2.2.1.Test the hypothesis by introducing the 3 network position indicies into the model one by one
logit ipo_exit coinvest individual_eigen foreign experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r
logit ipo_exit coinvest individual_degree foreign experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r
logit ipo_exit coinvest individual_between foreign experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r

*3.Empirical Study II: The Interaction Effect Between the Network Position and Capital Source

*3.Hypothesis 3: The Capital Source would enhance the effect of the network position.

**3.1.Method 1

***3.1.1.Centralize the 3 network postion indices
ssc install center, replace
center individual_eigen
center individual_degree
center individual_between 

***3.1.2.generate the interaction term
gen foreign_c_eigen = foreign*c_individual_eigen
gen foreign_c_degree = foreign*c_individual_degree
gen foreign_c_between = foreign*c_individual_between

***3.1.3.Test
logit ipo_exit coinvest c_individual_eigen foreign foreign_c_eigen experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r 
logit ipo_exit coinvest c_individual_degree foreign foreign_c_degree experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r  
logit ipo_exit coinvest c_individual_between foreign foreign_c_between experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r  

**3.2.Method 2

***3.2.1.install inteff command
search inteff

***3.2.2.Test
logit ipoma_exit c_individual_eigen foreign foreign_c_eigen coinvest experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r  
inteff ipoma_exit c_individual_eigen foreign foreign_c_eigen coinvest experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*, savegraph1(D:\C盘\港中文ECON\计量经济学\programme\最终稿\figure1, replace) savegraph2(D:\C盘\港中文ECON\计量经济学\programme\最终稿\figure2, replace)
******Before saving the graphs, you should change the file path. The file path shown above is mine, which cannot be found in your computer. 

logit ipoma_exit c_individual_degree foreign foreign_c_degree coinvest experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r  
inteff ipoma_exit c_individual_degree foreign foreign_c_degree coinvest  experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*, savegraph1(D:\C盘\港中文ECON\计量经济学\programme\最终稿\figure3, replace) savegraph2(D:\C盘\港中文ECON\计量经济学\programme\最终稿\figure4, replace)

logit ipoma_exit c_individual_between foreign foreign_c_between coinvest experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r  
inteff ipoma_exit c_individual_between foreign foreign_c_between coinvest  experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*, savegraph1(D:\C盘\港中文ECON\计量经济学\programme\最终稿\figure5, replace) savegraph2(D:\C盘\港中文ECON\计量经济学\programme\最终稿\figure6, replace)

*4.Empirical study III: The Long Board Effect

*4.Hypothesis 4: Given a co-investment event, only the best-networked VC's network position would have a significant positive effect on the investment return, and other VCs' individual network position would not have a significant effect on the return.

**4.1. Drop
drop if coinvest == 0

**4.2. Test
logit ipo_exit coinvest individual_degree foreign experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r
logit ipo_exit coinvest max_degree foreign experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round sd_eigen dummy_year* dummy_area*,r

*5.Robustness Test (Use ipoma_exit as the dependent variable)

*preparation
insheet using"data_1.csv",clear

summarize

tab invest_year,gen(dummy_year)
tab industry,gen(dummy_area)

gen experience_2 = experience^2

*Empirical Study I: How the Network Position Influence the Investment Return

*Hyporhesis 1: Whether a VC Fund adopts co-investment strategy would NOT have significant impact on the return.
logit ipoma_exit coinvest foreign experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r

*Hypothesis 2: The network position of a VC firm would have significant positive impact on the return.

*Test the hypothesis by introducing the 3 network position indicies into the model one by one
logit ipoma_exit coinvest individual_eigen foreign experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r
logit ipoma_exit coinvest individual_degree foreign experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r
logit ipoma_exit coinvest individual_between foreign experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r

*Empirical Study II: The Interaction Effect Between the Network Position and Capital Source

*3.Hypothesis 3: The Capital Source would enhance the effect of the network position.

*Centralize the 3 network postion indices
center individual_eigen
center individual_degree
center individual_between

*generate the interaction term
gen foreign_c_eigen = foreign*c_individual_eigen
gen foreign_c_degree = foreign*c_individual_degree
gen foreign_c_between = foreign*c_individual_between

*Test
logit ipoma_exit coinvest c_individual_eigen foreign foreign_c_eigen experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r 
logit ipoma_exit coinvest c_individual_degree foreign foreign_c_degree experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r  
logit ipoma_exit coinvest c_individual_between foreign foreign_c_between experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r  

*Empirical study III: The Long Board Effect

*4.Hypothesis 4: Given a co-investment event, only the best-networked VC's network position would have a significant positive effect on the investment return, and other VCs' individual network position would not have a significant effect on the return.

*Drop
drop if coinvest == 0

*Test
logit ipoma_exit coinvest individual_degree foreign experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round dummy_year* dummy_area*,r
logit ipoma_exit coinvest max_degree foreign experience experience_2 hq_bj hq_sh hq_gz hq_sz maturity invest_round sd_eigen dummy_year* dummy_area*,r