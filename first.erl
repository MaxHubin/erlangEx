-module(first). 
-export([findPosition/1]).

findPosition(StartList) ->
MaxSUM=100000000000000000, % TODO %
step(0,StartList,lists:sum(StartList),{MaxSUM,0}).

step(_In_1,[_In|[]],_LastSum,Property)->Property;

step(In_1,[In|Arr],LastSum,Property)-> 
NewSum=LastSum-In_1-In,
step(In,Arr,NewSum,min(Property,{abs(NewSum),In})).





