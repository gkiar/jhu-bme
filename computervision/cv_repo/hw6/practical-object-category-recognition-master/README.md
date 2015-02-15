# Object category recognition practical

> A computer vision practical by the Oxford Visual Geometry group,
> authored by Andrea Vedaldi and Andrew Zisserman.

Start from `doc/instructions.html`.

Package contents
----------------

The package contains three exercises:

* `exercise1.m`: learns and test an image classifier on benchmark data
* `exercise2.m`: learns your own classifier
* `exercise3.m`: experiment with different image  encoding methods

The computer vision algorithms are implemented by
[VLFeat](http://www.vlfeat.org). This package contains the following
MATLAB functions:

* `standardizeImage.m`: Rescale an image to a standard size.
* `computeFeatures.m`: Compute dense SIFT keypoints and descriptors.
* `encodeImage.m`: Compute an image encoding: BoVW, VLAD, FV.
* `removeSpatialInformation.m`: Reduces and encoding using spatial
  subdivisions to a simple one.
* `trainLinearSVM.m`: Learn a linear support vector machine.
* `displayRankedImagelist.m`: Visualize a subset of a ranked list of images.
* `getImageSet.m`: Scan a directory for images.
* `sampleLocalFeatures.m`: Sample local features from a set of images in order to train and encoder.
* `trainEncoder.m`: Train a BoVW, VLAD, or FV encoder (i.e., learn visual word dictionary).

Appendix: Installing from scratch
---------------------------------

1. From Bash, run `./extras/download.sh`. This will download the
   PASCAL VOC data, extract a subsetof it , and install VLFeat.
2. From MATLAB, run `addpath extras ; preprocess.m`.

Changes
-------

* *2014a* - Switches to VLFeat 0.9.18. Redone packaging and doc.
* *2013a* - Switches to VLFeat 0.9.17. Adds VLAD and FV.
* *2012* - Minor cleanups.
* *2011* - Initial version.

License
-------

    Copyright (c) 2011-13 Andrea Vedaldi

    Permission is hereby granted, free of charge, to any person
    obtaining a copy of this software and associated documentation
    files (the "Software"), to deal in the Software without
    restriction, including without limitation the rights to use, copy,
    modify, merge, publish, distribute, sublicense, and/or sell copies
    of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
    HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
    DEALINGS IN THE SOFTWARE.
