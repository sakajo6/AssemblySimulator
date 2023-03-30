sim: ./src/* 
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs
debug: ./src/* 
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs -DDEBUG
stats: ./src/*
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs -DSTATS
prod: ./src/*
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs -DPROD -DSTATS
clean:
	rm ./sim