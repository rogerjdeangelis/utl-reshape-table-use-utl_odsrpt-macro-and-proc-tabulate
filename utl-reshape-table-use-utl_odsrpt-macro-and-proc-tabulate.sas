Reshape table use utl_odsrpt macro and proc tabulate                                                                              
                                                                                                                                  
This solution creates an output dataset instaed of a static report,                                                               
it fixes a SAS bug in ods.                                                                                                        
                                                                                                                                  
It is a reshaping problem not a transpose?                                                                                        
                                                                                                                                  
github                                                                                                                            
https://tinyurl.com/yakutt82                                                                                                      
https://github.com/rogerjdeangelis/utl-reshape-table-use-utl_odsrpt-macro-and-proc-tabulate                                       
                                                                                                                                  
SAS forum                                                                                                                         
https://tinyurl.com/y9onn2uh                                                                                                      
https://communities.sas.com/t5/SAS-Programming/Re-organize-table-using-proc-tabulate-or-report-or-transpose/m-p/648227            
                                                                                                                                  
Ksharp ( I just wrap his code with my ods macros)                                                                                 
https://communities.sas.com/t5/user/viewprofilepage/user-id/18408                                                                 
                                                                                                                                  
macros                                                                                                                            
https://tinyurl.com/y9nfugth                                                                                                      
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories                                        
                                                                                                                                  
*_                   _                                                                                                            
(_)_ __  _ __  _   _| |_                                                                                                          
| | '_ \| '_ \| | | | __|                                                                                                         
| | | | | |_) | |_| | |_                                                                                                          
|_|_| |_| .__/ \__,_|\__|                                                                                                         
        |_|                                                                                                                       
;                                                                                                                                 
                                                                                                                                  
data have;                                                                                                                        
 input group desc$ a b;                                                                                                           
cards4;                                                                                                                           
1 min 1 4                                                                                                                         
1 p50 2 5                                                                                                                         
1 max 3 6                                                                                                                         
2 min 3 7                                                                                                                         
2 p50 4 2                                                                                                                         
2 max 5 3                                                                                                                         
3 min 7 5                                                                                                                         
3 p50 6 4                                                                                                                         
3 max 8 6                                                                                                                         
;;;;                                                                                                                              
run;quit;                                                                                                                         
                                                                                                                                  
WORK.HAVE total obs=9                                                                                                             
                                                                                                                                  
 GROUP    DESC    A    B                                                                                                          
                                                                                                                                  
   1      min     1    4                                                                                                          
   1      p50     2    5                                                                                                          
   1      max     3    6                                                                                                          
   2      min     3    7                                                                                                          
   2      p50     4    2                                                                                                          
   2      max     5    3                                                                                                          
   3      min     7    5                                                                                                          
   3      p50     6    4                                                                                                          
   3      max     8    6                                                                                                          
                                                                                                                                  
*            _               _                                                                                                    
  ___  _   _| |_ _ __  _   _| |_                                                                                                  
 / _ \| | | | __| '_ \| | | | __|                                                                                                 
| (_) | |_| | |_| |_) | |_| | |_                                                                                                  
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                 
                |_|                                                                                                               
;                                                                                                                                 
                                                                                                                                  
Dataset not static report;                                                                                                        
WORK.WANT total obs=6                                                                                                             
                                                                                                                                  
  AB    STAT    GROUP1    GROUP2    GROUP3                                                                                        
                                                                                                                                  
  A     Min        1         3         7                                                                                          
        P50        2         4         6                                                                                          
        Max        3         5         8                                                                                          
  B     Min        4         7         5                                                                                          
        P50        5         2         4                                                                                          
        Max        6         3         6                                                                                          
                                                                                                                                  
*                                                                                                                                 
 _ __  _ __ ___   ___ ___  ___ ___                                                                                                
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                                               
| |_) | | | (_) | (_|  __/\__ \__ \                                                                                               
| .__/|_|  \___/ \___\___||___/___/                                                                                               
|_|                                                                                                                               
;                                                                                                                                 
                                                                                                                                  
proc format;                                                                                                                      
      picture Group low-high = '9' (prefix='GROUP');                                                                              
run;                                                                                                                              
                                                                                                                                  
title;                                                                                                                            
footnote;                                                                                                                         
%utl_odsrpt(setup);                                                                                                               
proc tabulate data=have;                                                                                                          
  class group;                                                                                                                    
  class desc / order=data;                                                                                                        
  var a b;                                                                                                                        
  table                                                                                                                           
    (a b) * desc=''                                                                                                               
  , group="" * sum='' * f=best6. / box="AB|Stat"  ;                                                                               
  format group group.;                                                                                                            
run;quit;                                                                                                                         
%utl_odsrpt(outdsn=want);                                                                                                         
                                                                                                                                  
                                                                                                                                  
