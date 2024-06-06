adjacent_cells(GridList, Cols, Rows, Idx, AdjIdx) :-
    % Get the color of the current cell
    nth0(Idx, GridList, Color),
    % Calculate the row and column for the current index
    X is Idx div Cols,
    Y is Idx mod Cols,
    % Calculate the row and column for the adjacent cell
    (   (AdjX is X - 1, AdjY is Y, AdjX >= 0 ; % Cell above
         AdjX is X + 1, AdjY is Y, AdjX < Rows ; % Cell below
         AdjX is X, AdjY is Y - 1, AdjY >= 0 ; % Cell to the left
         AdjX is X, AdjY is Y + 1, AdjY < Cols), % Cell to the right
        % Convert back to 1D index
        AdjIdx is AdjX * Cols + AdjY,
        % Ensure the index is within bounds
        AdjIdx >= 0, AdjIdx < Rows * Cols,
        % Get the color of the adjacent cell and compare
        nth0(AdjIdx, GridList, AdjColor),
        Color = AdjColor
    ).





% Predicate to check for a cycle in the grid.
isCycle(CurrIndex, GridList, Visited, ParentIndex, Cols, Rows) :-
    append(Visited, [CurrIndex], NewVisited),
   findall(NextIndex,adjacent_cells(GridList, Cols, Rows, CurrIndex, NextIndex),N),
    N=[NextIndex|R],
    % Check if the NextIndex has the same color and is not the ParentIndex.
    (
        NextIndex \= ParentIndex
    ->  % If NextIndex has been visited, we've found a cycle.
        (   member(NextIndex, Visited),write("cycle found"),write(Visited)
        ->  true  % Succeed the predicate indicating a cycle is found.
        ;   % Otherwise, continue the recursion to check for a cycle.
            isCycle(NextIndex, GridList, NewVisited, CurrIndex, Cols, Rows)
        )
    ;  (    R=[]
           ->false
          )

        ;  (   R=[Next|_],isCycle(Next,GridList,NewVisited,CurrIndex,Cols,Rows)
           )

       ).




% Predicate to detect a cycle starting from each index in the grid sequentially.
detect_cycle_sequential(GridList, Cols, Rows, StartIndex,Visited,ParentIndex) :-
    % Check for a cycle starting from StartIndex.
   isCycle(StartIndex,GridList,Visited,ParentIndex,Cols, Rows),!
    ;
    % If isCycle fails, increment the index and try the next cell.
    NextIndex is StartIndex + 1,
    grid_size(Cols, Rows, Size),
    NextIndex < Size,
    detect_cycle_sequential(GridList, Cols, Rows, NextIndex,Visited,ParentIndex).

% Helper predicate to calculate the size of the grid.
grid_size(Cols, Rows, Size) :-
    Size is Cols * Rows.






% Helper predicate to calculate the size of the grid.
grid_size(Cols, Rows, Size) :-
    Size is Cols * Rows.
