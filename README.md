![image](https://github.com/ShahdAhmed2003/Detecting-A-cycle-in-a-2D-grid-using-prolog/assets/147663642/e4d253fb-503b-4628-aea7-cd735e95fbca)
sample Run 
-?GridList = [c,c,c,a,
            c,d,c,c,
            c,c,e,c,
            f,c,c,c],   
detect_cycle_sequential(GridList, 4, 4, 0,[],null) .

?-GridList = [a,b,b,
              b,z,b,
              b,b,a] ,
detect_cycle_sequential(GridList, 3, 3, 0,[],null) .
