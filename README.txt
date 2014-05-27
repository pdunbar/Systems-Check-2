At this point I have a basic structure for my site and have a particular problem.

I have the data structure that I would like prior to sorting by wins vs. losses.
  @standings_unsorted = {"Patriots"=>{:wins=>4, :losses=>0},
                         "Broncos"=>{:wins=>2, :losses=>3},
                         "Colts"=>{:wins=>0, :losses=>4},
                         "Steelers"=>{:wins=>2, :losses=>1}}


Sorting by only wins, I was able to sort as follows:
  @standings = [["Patriots", {:wins=>4, :losses=>0}],
                ["Steelers", {:wins=>2, :losses=>1}],
                ["Broncos", {:wins=>2, :losses=>3}],
                ["Colts", {:wins=>0, :losses=>4}]]


After sorting I am left with this following data structure. The teams are properly sorted by wins only. This is where I got stuck. I am having trouble correctly sorting the standings without messing up its data structure. This is THE hurdle I am having.


Please see my index.erb to show that I have a solid grasp on Sinatra and how it relates to the server.rb file.

