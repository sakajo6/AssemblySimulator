package main

import (
	"os"
	"bufio"
	"fmt"
	"strings"
	"strconv"
)

func ReadFinvFuncA() {
	filename := "finv_func_A.txt"

	fp, err := os.Open(filename)
	if err != nil {
		panic("error: cannot open finv_func_A.txt")
	}
	defer fp.Close()

	scanner := bufio.NewScanner(fp)

	check_sum := 0
	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		line = strings.Trim(line, ";")

		slice := strings.Split(line, ": A = 32'b")
		head := strings.Split(slice[0], "10'd")[1]
		tail := slice[1]

		fmt.Printf("\t\tfinv_A[%s].i = 0b%s;\n", head, tail)

		head_num, err := strconv.Atoi(head)
		if err != nil || head_num != check_sum {
			panic("error: index error")
		}

		check_sum += 1
	}

	fmt.Println()
}

func ReadFinvFuncB() {
	filename := "finv_func_B.txt"

	fp, err := os.Open(filename)
	if err != nil {
		panic("error: cannot open finv_func_B.txt")
	}
	defer fp.Close()

	scanner := bufio.NewScanner(fp)

	check_sum := 0
	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		line = strings.Trim(line, ";")

		slice := strings.Split(line, ": B = 32'b")
		head := strings.Split(slice[0], "10'd")[1]
		tail := slice[1]

		fmt.Printf("\t\tfinv_B[%s].i = 0b%s;\n", head, tail)

		head_num, err := strconv.Atoi(head)
		if err != nil || head_num != check_sum {
			panic("error: index error")
		}

		check_sum += 1
	}

	fmt.Println()
}

func main() {
	ReadFinvFuncA()
	ReadFinvFuncB()
}