package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
	"math"
)

type Color struct {
	R int
	G int
	B int
}

func LineToColor(line []string) (*Color, error) {
	r, err := strconv.Atoi(line[0])
	if err != nil {
		return nil, err 
	}

	g, err := strconv.Atoi(line[1])
	if err != nil {
		return nil, err
	}

	b, err := strconv.Atoi(line[2])
	if err != nil {
		return nil, err
	}

	color := &Color {R: r, G: g, B: b}
	return color, nil
}

func ReadPPMFile(filename string) *[]Color {

	fp, err := os.Open(filename)
	if err != nil {
		panic(fmt.Sprintf("[error] cannot open %s", filename))
	}
	defer fp.Close()

	scanner := bufio.NewScanner(fp)

	ret := make([]Color, 0)
	for scanner.Scan() {
		line := strings.Split(scanner.Text(), " ")
		
		if len(line) == 3 {
			color, err := LineToColor(line)
			if err != nil {
				panic("[error] cannot convert line to Color")
			}

			ret = append(ret, *color)
		}
	}

	return &ret
}

func OutputDiff(fp *os.File, R, G, B int) {
	_, err := fp.Write([]byte(fmt.Sprintf("%d %d %d\n", R, G, B)))
	if err != nil {
		panic("[error] cannnot write on diff_check.ppm")
	}
}

func CheckDiff(answer, result *[]Color) (int, int) {
	fatalDiff := 0
	smallDiff :=0

	fp, err := os.Create("diff_check.ppm")
	if err != nil {
		panic("[error] cannot open diff_check.ppm")
	}
	defer fp.Close()

	_, err = fp.Write([]byte("P3\n256 256 255\n"))
	if err != nil {
		panic("[error] cannot write on diff_check.ppm")
	}

	for i := range *answer {
		u := (*answer)[i]
		v := (*result)[i]

		diffVal := 0.
		
		diffs := [3]float64 {
			math.Abs(float64(u.R - v.R)),
			math.Abs(float64(u.G - v.G)),
			math.Abs(float64(u.B - v.B)),
		}

		for _, v := range diffs {
			diffVal += v
		}

		if diffVal > 1 {
			fatalDiff += 1
			OutputDiff(fp, 255, 0, 0)
		} else if diffVal == 1 {
			smallDiff += 1
			OutputDiff(fp, 0, 255, 0)
		} else {
			OutputDiff(fp, u.R, u.G, u.B)
		}
	}

	return fatalDiff, smallDiff
}

func main() {
	var input, output string
	fmt.Scan(&input)
	fmt.Scan(&output)

	answer := ReadPPMFile(fmt.Sprintf("./ppm/%s.ppm", input))
	result := ReadPPMFile(fmt.Sprintf("./outputs/%s.ppm", output))

	fatalDiff, smallDiff := CheckDiff(answer, result)

	fmt.Println(fmt.Sprintf("fatal:\t%.2f%%\t%d", float64(fatalDiff) * 100. / float64(len(*answer)), fatalDiff))
	fmt.Println(fmt.Sprintf("small:\t%.2f%%\t%d", float64(smallDiff) * 100. / float64(len(*answer)), smallDiff))
	fmt.Println(fmt.Sprintf("total:\t%.2f%%\t%d", float64(fatalDiff + smallDiff) * 100. / float64(len(*answer)), fatalDiff + smallDiff))
}