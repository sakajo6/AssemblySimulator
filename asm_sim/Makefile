sim: ./src/* 
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs
debug: ./src/* 
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs -DDEBUG
hard: ./src/*
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs -DHARD
stats: ./src/*
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs -DSTATS
fpu: ./src/*
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs -DFPUEMU
prod: ./src/*
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs -DDEBUG -DHARD -DSTATS -DFPUEMU -DPROD
contest: ./src/*
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs -DHARD -DSTATS -DFPUEMU -DPROD
clean:
	rm ./sim