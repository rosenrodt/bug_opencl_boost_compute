#include "mylib.h"
#include <iostream>
#include <boost/compute.hpp>

namespace compute = boost::compute;

void mylibfunc()
{
    std::cout << "mylibfunc() called\n";

    compute::vector<int> vec1;
    // compute::vector<float> vec2;

    // vec = compute::vector<int>(size_t(10));
    // vec = compute::vector<float>(size_t(10));
}

