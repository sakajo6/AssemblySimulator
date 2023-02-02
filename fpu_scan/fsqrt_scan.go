package main

import (
	"os"
	"bufio"
	"fmt"
	"strings"
	"strconv"
)

func ReadFsqrtFuncA() {
	filename := "fsqrt_func_A.txt"

	fp, err := os.Open(filename)
	if err != nil {
		panic("error: cannot open fsqrt_func_A.txt")
	}
	defer fp.Close()

	scanner := bufio.NewScanner(fp)

	check_sum := 0
	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())

		slice := strings.Split(line, ": A = 32'b")
		head := strings.Split(slice[0], "11'd")[1]
		tail := strings.Split(slice[1], ";")[0]

		fmt.Printf("\t\tfsqrt_A[%s].i = 0b%s;\n", head, tail)

		head_num, err := strconv.Atoi(head)
		if err != nil || head_num != check_sum {
			panic("error: index error")
		}

		check_sum += 1
	}

	fmt.Println()
}

func ReadFsqrtFuncB() {
	filename := "fsqrt_func_B.txt"

	fp, err := os.Open(filename)
	if err != nil {
		panic("error: cannot open fsqrt_func_B.txt")
	}
	defer fp.Close()

	scanner := bufio.NewScanner(fp)

	check_sum := 0
	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())

		slice := strings.Split(line, ": B = 32'b")
		head := strings.Split(slice[0], "11'd")[1]
		tail := strings.Split(slice[1], ";")[0]

		fmt.Printf("\t\tfsqrt_B[%s].i = 0b%s;\n", head, tail)

		head_num, err := strconv.Atoi(head)
		if err != nil || head_num != check_sum {
			panic("error: index error")
		}

		check_sum += 1
	}

	fmt.Println()
}

func main() {
	ReadFsqrtFuncA()
	ReadFsqrtFuncB()
}