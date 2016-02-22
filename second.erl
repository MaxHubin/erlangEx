-module(second).
-author("maxsim").

-export([max_path/0]).

max_path() -> TriangleList = lists:reverse(read_text_file('triangle.txt')),
  MaxPoint = by_row(hd(TriangleList), tl(TriangleList)),
  io:write(MaxPoint).

%% read_file
read_text_file(Filename) ->
  {ok, Device} = file:open(Filename, [read]),
  read_text(Device, []).

read_text(Device, Accum) ->
  case file:read_line(Device) of
    eof -> file:close(Device), Accum;
    {ok, Line} ->
      NewLine = lists:map(fun(X) -> {Int, _} = string:to_integer(X), Int end, string:tokens(Line, " ")),
      read_text(Device, lists:append(Accum, [NewLine]))
  end.
%% end read_file

by_row(LastRowPoints, []) -> LastRowPoints;
by_row(LastRowPoints, [CurrentRow | UpTriangleList]) -> CurrentRowPoints = add_point(CurrentRow, 1, LastRowPoints),
  by_row(CurrentRow, UpTriangleList),
  by_row(CurrentRowPoints, UpTriangleList).

add_point([], _Position, _LastRow) -> [];
add_point([CurrentCell | OtherList], Position, LastRow) ->
  [max((CurrentCell + lists:nth(Position, LastRow)), (CurrentCell + lists:nth((Position + 1), LastRow))) | add_point(OtherList, Position + 1, LastRow)].