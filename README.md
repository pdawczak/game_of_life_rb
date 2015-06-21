# Game of life (Ruby) [![Build Status](https://travis-ci.org/pdawczak/game_of_life_rb.svg?branch=master)](https://travis-ci.org/pdawczak/game_of_life_rb)

When solving the problem, solution has been implemented using TDD technique. Please refer to travis output of tests execution [here](https://travis-ci.org/pdawczak/game_of_life_rb#L104). The tests can be found in [spec/lib/](https://github.com/pdawczak/game_of_life_rb/tree/master/spec/lib), and implementation in [lib/](https://github.com/pdawczak/game_of_life_rb/tree/master/lib).

## Domain

To solve the problem, there are 3 domain objects used:

* [`Map`](https://github.com/pdawczak/game_of_life_rb/blob/master/lib/map.rb) which holds "representation" of game board consisting of *1's* (live) and *0's* (dead) cells. It provides access for cell values with [`#at`](https://github.com/pdawczak/game_of_life_rb/blob/master/lib/map.rb#L27) method, and performs *recalculation* of next state of the board with [`#tick`](https://github.com/pdawczak/game_of_life_rb/blob/master/lib/map.rb#L19) method.

* [`Cell`](https://github.com/pdawczak/game_of_life_rb/blob/master/lib/cell.rb) which is responsible for computing the [`#next_state`](https://github.com/pdawczak/game_of_life_rb/blob/master/lib/cell.rb#L12) of the `Cell` based on current_state, and it's environment - [`#count_of_live_neighbours`](https://github.com/pdawczak/game_of_life_rb/blob/master/lib/cell.rb#L8). `Cell` in contrast to `Map` understands values of 1 and 0, based on which performs proper computing, while `Map` just holds the *raw* representation.

* [`CellBuilder`](https://github.com/pdawczak/game_of_life_rb/blob/master/lib/cell_builder.rb) - As stated before - `Cell`, to properly compute the *next state* needs information of it's *current state*, and *count of live neighbours*. As this is the only responibility, it shouldn't have access to `Map` - how to limit which values of board can be accessed? Because of that, there was a concept of `CellBuilder` introduced - it's purpose is to read `Map`'s cell values at proper indices, create new `Cell` and let it perform proper computing. Having process of accessing the values encapsulated gives great flexibility - what if in future requirements change the way we would like to consider values of neighours that lay in distance of 2 cell's from current one? Another `CellBuilder` could be intorduced and no changes to `Map` or `Cell` would be required.

## [`OutOfIndexAccess`](https://github.com/pdawczak/game_of_life_rb/blob/master/lib/support/out_of_index_access.rb) Support

To simplify the problem, when checking values of cells out of the board, `Map` will return value of 0 - this is the case when calculating the next state for cells at the edges of the map (eg. at [0, 0]). 

In Ruby there is no exception thrown (so it could be caught and handled properly) when accessing values of arrays for indices that don't exist:

```ruby
arr = [2, 3, 4] 

arr[0] # => 2
arr[2] # => 4

# but:
arr[99] # => nil
arr[-1] # => 4, equivalent of arr[arr.length - 1]
```

In order to nicely handle accessing values out of the array in [`Map#at`](https://github.com/pdawczak/game_of_life_rb/blob/master/lib/map.rb#L27) there was [`OutOfIndexAccess`](https://github.com/pdawczak/game_of_life_rb/blob/master/lib/support/out_of_index_access.rb) supporting module introduced. It is irrelevant for solution itself, highly Ruby specific that lets removing some `if` statements.