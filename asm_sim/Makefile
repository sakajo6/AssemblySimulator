sim: ./src/* 
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs -pthread
debug: ./src/* 
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs -pthread -DDEBUG
test: ./src/*
	g++ -std=c++17 -O3 -o sim ./src/main.cpp -lstdc++fs -pthread -DTEST
clean:
	rm ./sim