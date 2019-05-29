cmake . -B.build -G"Visual Studio 14 2015 Win64" -DBOOST_ROOT="D:/repo/boost_1_68_0" -DBoostCompute_DIR="D:/repo/boost.compute"
cmake --build .build --config Release