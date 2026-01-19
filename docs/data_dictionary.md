# Data Dictionary — Premier League (E0.csv)

## Source documentation

Official column definitions and abbreviations are provided by the data source and preserved verbatim in:

`docs/source_notes/football-data-notes.txt`

This dictionary maps raw source columns to analytics-friendly names used in this project.

## File metadata

- League: Premier League
- Season: Current season
- Source file: E0.csv
- Grain: One row per match

## Column mapping (initial)

Match identifiers and core results
Source Column	Staging Column	Type (target)	Description	Notes
Div	div	text	League division	e.g. E0 for Premier League
Date	match_date	date	Match date	Source format dd/mm/yy
Time	kickoff_time	text	Kick-off time	May be blank
HomeTeam	home_team	text	Home team	As provided
AwayTeam	away_team	text	Away team	As provided
FTHG	home_goals_ft	integer	Full-time home goals	
FTAG	away_goals_ft	integer	Full-time away goals	
FTR	result_ft	text	Full-time result	H/D/A
HTHG	home_goals_ht	integer	Half-time home goals	
HTAG	away_goals_ht	integer	Half-time away goals	
HTR	result_ht	text	Half-time result	H/D/A
Referee	referee	text	Match referee	As provided
Match statistics
Source Column	Staging Column	Type (target)	Description	Notes
HS	home_shots	integer	Home shots	
AS	away_shots	integer	Away shots	
HST	home_shots_on_target	integer	Home shots on target	
AST	away_shots_on_target	integer	Away shots on target	
HF	home_fouls	integer	Home fouls committed	
AF	away_fouls	integer	Away fouls committed	
HC	home_corners	integer	Home corners	
AC	away_corners	integer	Away corners	
HY	home_yellow_cards	integer	Home yellow cards	Notes mention counting nuance for some competitions
AY	away_yellow_cards	integer	Away yellow cards	
HR	home_red_cards	integer	Home red cards	
AR	away_red_cards	integer	Away red cards	
Odds columns
A) Match odds (Home/Draw/Away) — pre-closing

Bookmaker odds (1X2)

Source	Staging	Type	Description
B365H	b365_h	real	Bet365 home win odds
B365D	b365_d	real	Bet365 draw odds
B365A	b365_a	real	Bet365 away win odds
BFDH	bfd_h	real	Betfred home win odds
BFDD	bfd_d	real	Betfred draw odds
BFDA	bfd_a	real	Betfred away win odds
BMGMH	bmgm_h	real	BetMGM home win odds
BMGMD	bmgm_d	real	BetMGM draw odds
BMGMA	bmgm_a	real	BetMGM away win odds
BVH	bv_h	real	BetVictor home win odds
BVD	bv_d	real	BetVictor draw odds
BVA	bv_a	real	BetVictor away win odds
BWH	bw_h	real	Bet&Win home win odds
BWD	bw_d	real	Bet&Win draw odds
BWA	bw_a	real	Bet&Win away win odds
CLH	cl_h	real	Coral home win odds
CLD	cl_d	real	Coral draw odds
CLA	cl_a	real	Coral away win odds
LBH	lb_h	real	Ladbrokes home win odds
LBD	lb_d	real	Ladbrokes draw odds
LBA	lb_a	real	Ladbrokes away win odds
PSH	ps_h	real	Pinnacle home win odds
PSD	ps_d	real	Pinnacle draw odds
PSA	ps_a	real	Pinnacle away win odds

Market aggregates (1X2)

Source	Staging	Type	Description
MaxH	market_max_h	real	Market maximum home odds
MaxD	market_max_d	real	Market maximum draw odds
MaxA	market_max_a	real	Market maximum away odds
AvgH	market_avg_h	real	Market average home odds
AvgD	market_avg_d	real	Market average draw odds
AvgA	market_avg_a	real	Market average away odds

Betfair Exchange (1X2)

Source	Staging	Type	Description
BFEH	bfe_h	real	Betfair Exchange home odds
BFED	bfe_d	real	Betfair Exchange draw odds
BFEA	bfe_a	real	Betfair Exchange away odds
B) Over/Under 2.5 goals odds — pre-closing
Source	Staging	Type	Description
B365>2.5	b365_ou25_over	real	Bet365 over 2.5 goals
B365<2.5	b365_ou25_under	real	Bet365 under 2.5 goals
P>2.5	p_ou25_over	real	Pinnacle over 2.5 goals
P<2.5	p_ou25_under	real	Pinnacle under 2.5 goals
Max>2.5	market_max_ou25_over	real	Market max over 2.5
Max<2.5	market_max_ou25_under	real	Market max under 2.5
Avg>2.5	market_avg_ou25_over	real	Market avg over 2.5
Avg<2.5	market_avg_ou25_under	real	Market avg under 2.5
BFE>2.5	bfe_ou25_over	real	Betfair Exchange over 2.5
BFE<2.5	bfe_ou25_under	real	Betfair Exchange under 2.5
C) Asian handicap odds — pre-closing
Source	Staging	Type	Description	Notes
AHh	market_ah_handicap	real	Market size of handicap (home team)	Notes: since 2019/20
B365AHH	b365_ah_home_odds	real	Bet365 Asian handicap home odds	
B365AHA	b365_ah_away_odds	real	Bet365 Asian handicap away odds	
PAHH	p_ah_home_odds	real	Pinnacle Asian handicap home odds	
PAHA	p_ah_away_odds	real	Pinnacle Asian handicap away odds	
MaxAHH	market_max_ah_home_odds	real	Market max AH home odds	
MaxAHA	market_max_ah_away_odds	real	Market max AH away odds	
AvgAHH	market_avg_ah_home_odds	real	Market avg AH home odds	
AvgAHA	market_avg_ah_away_odds	real	Market avg AH away odds	
BFEAHH	bfe_ah_home_odds	real	Betfair Exchange AH home odds	
BFEAHA	bfe_ah_away_odds	real	Betfair Exchange AH away odds	
Closing odds (same markets, “C”)
D) Match odds (Home/Draw/Away) — closing

Bookmaker closing odds (1X2)

Source	Staging	Type	Description
B365CH	b365c_h	real	Closing Bet365 home odds
B365CD	b365c_d	real	Closing Bet365 draw odds
B365CA	b365c_a	real	Closing Bet365 away odds
BFDCH	bfdc_h	real	Closing Betfred home odds
BFDCD	bfdc_d	real	Closing Betfred draw odds
BFDCA	bfdc_a	real	Closing Betfred away odds
BMGMCH	bmgmc_h	real	Closing BetMGM home odds
BMGMCD	bmgmc_d	real	Closing BetMGM draw odds
BMGMCA	bmgmc_a	real	Closing BetMGM away odds
BVCH	bvc_h	real	Closing BetVictor home odds
BVCD	bvc_d	real	Closing BetVictor draw odds
BVCA	bvc_a	real	Closing BetVictor away odds
BWCH	bwc_h	real	Closing Bet&Win home odds
BWCD	bwc_d	real	Closing Bet&Win draw odds
BWCA	bwc_a	real	Closing Bet&Win away odds
CLCH	clc_h	real	Closing Coral home odds
CLCD	clc_d	real	Closing Coral draw odds
CLCA	clc_a	real	Closing Coral away odds
LBCH	lbc_h	real	Closing Ladbrokes home odds
LBCD	lbc_d	real	Closing Ladbrokes draw odds
LBCA	lbc_a	real	Closing Ladbrokes away odds
PSCH	psc_h	real	Closing Pinnacle home odds
PSCD	psc_d	real	Closing Pinnacle draw odds
PSCA	psc_a	real	Closing Pinnacle away odds

Market aggregates (1X2) — closing

Source	Staging	Type	Description
MaxCH	market_maxc_h	real	Closing market max home odds
MaxCD	market_maxc_d	real	Closing market max draw odds
MaxCA	market_maxc_a	real	Closing market max away odds
AvgCH	market_avgc_h	real	Closing market avg home odds
AvgCD	market_avgc_d	real	Closing market avg draw odds
AvgCA	market_avgc_a	real	Closing market avg away odds

Betfair Exchange (1X2) — closing

Source	Staging	Type	Description
BFECH	bfec_h	real	Closing Betfair Exchange home odds
BFECD	bfec_d	real	Closing Betfair Exchange draw odds
BFECA	bfec_a	real	Closing Betfair Exchange away odds
E) Over/Under 2.5 goals — closing
Source	Staging	Type	Description
B365C>2.5	b365c_ou25_over	real	Closing Bet365 over 2.5
B365C<2.5	b365c_ou25_under	real	Closing Bet365 under 2.5
PC>2.5	pc_ou25_over	real	Closing Pinnacle over 2.5
PC<2.5	pc_ou25_under	real	Closing Pinnacle under 2.5
MaxC>2.5	market_maxc_ou25_over	real	Closing market max over 2.5
MaxC<2.5	market_maxc_ou25_under	real	Closing market max under 2.5
AvgC>2.5	market_avgc_ou25_over	real	Closing market avg over 2.5
AvgC<2.5	market_avgc_ou25_under	real	Closing market avg under 2.5
BFEC>2.5	bfec_ou25_over	real	Closing Betfair Exchange over 2.5
BFEC<2.5	bfec_ou25_under	real	Closing Betfair Exchange under 2.5
F) Asian handicap — closing
Source	Staging	Type	Description
AHCh	market_ahc_handicap	real	Closing market handicap size
B365CAHH	b365c_ah_home_odds	real	Closing Bet365 AH home odds
B365CAHA	b365c_ah_away_odds	real	Closing Bet365 AH away odds
PCAHH	pc_ah_home_odds	real	Closing Pinnacle AH home odds
PCAHA	pc_ah_away_odds	real	Closing Pinnacle AH away odds
MaxCAHH	market_maxc_ah_home_odds	real	Closing market max AH home odds
MaxCAHA	market_maxc_ah_away_odds	real	Closing market max AH away odds
AvgCAHH	market_avgc_ah_home_odds	real	Closing market avg AH home odds
AvgCAHA	market_avgc_ah_away_odds	real	Closing market avg AH away odds
BFECAHH	bfec_ah_home_odds	real	Closing Betfair Exchange AH home odds
BFECAHA	bfec_ah_away_odds	real	Closing Betfair Exchange AH away odds