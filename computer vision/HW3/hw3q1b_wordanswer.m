%{

In order to make RANSAC fit m models to the data, it would be nested within
a loop over m models. After each line is fit to a set of data, those
inliers are then removed from the data set and the process is repeated on
the new, smaller, data set.

In order to guarantee that you recover the model, you would need to add the
number of iterations required to guarantee each model to one another. If
they have the same required number of iterations, 17 for instance, and
there are 2 models, it would require 34 iterations.

This number, k, is determined by: k >= m*log(1-p)/log(1-w^n), element of integers.
Therefore, it increases linearly with the number of models, and inverse
exponentially (ish) withrespect to n.

%}
