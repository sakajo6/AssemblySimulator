sim: ./src/* 
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs -pthread
debug: ./src/* 
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs -pthread -DDEBUG
hard: ./src/*
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs -pthread -DHARD
stats: ./src/*
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs -pthread -DSTATS
clean:
	rm ./sim