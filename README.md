# andys-football-calculator
This application is a static page with small JavaScript suitable for a smartphone.

TASK
Combinatorial optimisation - variant of "Partition Problem".
Divide a set of players with (signed +/-) strengths into two teams of equal size.
Objective is to pick teams with the closest total strength.

STRENGTH
The model here is a team's strength is simply the sum of its members.
Thus individual strength's can be derived from previous team results e.g. using robuat logistic regression.

CORRELATION
Since all players will be on one or other team, it turns out pairwise correlations cancel.
However, the available players change each matchday, we've implied correlation zero
by making "strength" constant regardless of available set.

SECONDARY OBJECTIVE
There are many solutions close to optimum.  It is undesirable to pick one team with more variance.
Variance (square of strength) could be a poor penalty cost for large scores so here we penalised by Huber.

Huber(x)
x<sup>2</sup>/2 |x|&lt;1
|x|-0.5  |x|&gt;=1
