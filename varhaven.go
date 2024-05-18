package main

import (
	"fmt"
	"math"
	"slices"
	"time"
	"varhaven/xoroshiro"
)

func getModifier(score int64) int64 {
	return int64(math.Floor(float64((score - 10) / 2)))
}

func main() {
	random := xoroshiro.New(time.Now().Unix())

	fmt.Println("Generating character values...")
	scores := generateScores(random)
	fmt.Println("Applying human racial bonus...")

	for i := 0; i < 6; i++ {
		scores[i] += 1
	}

	fmt.Println("Let's roll initiative!")
	playerInit := random.Int63n(20) + 1 + getModifier(scores[1])
	goblinInit := random.Int63n(20) + 1 + 2
	var playerFirst bool

	if playerInit > goblinInit {
		fmt.Println("Player goes first!")
		playerFirst = true
	} else if playerInit < goblinInit {
		fmt.Println("Goblin goes first!")
		playerFirst = false
	} else {
		if getModifier(scores[1]) > 2 {
			fmt.Println("Player goes first!")
			playerFirst = true
		} else if getModifier(scores[1]) < 2 {
			fmt.Println("Goblin goes first!")
			playerFirst = false
		} else {
			if getModifier(scores[3]) > 0 {
				fmt.Println("Player goes first!")
				playerFirst = true
			} else if getModifier(scores[3]) < 0 {
				fmt.Println("Goblin goes first!")
				playerFirst = false
			} else {
				if getModifier(scores[4]) > -1 {
					fmt.Println("Player goes first!")
					playerFirst = true
				} else if getModifier(scores[4]) < -1 {
					fmt.Println("Goblin goes first!")
					playerFirst = false
				} else {
					fmt.Println("I have never had this happen before, so the player will go first.")
					playerFirst = true
				}
			}
		}
	}

	fmt.Println(playerFirst)
}

func generateScores(random xoroshiro.State) []int64 {
	var scores [6]int64

	for i := 0; i < 6; i++ {
		var rolls [4]int64

		for j := 0; j < 4; j++ {
			rolls[j] = random.Int63n(6) + 1
		}

		rollSlice := rolls[:]
		slices.Sort(rollSlice)

		var total int64 = 0

		for j := 1; j < 4; j++ {
			total += rollSlice[j]
		}

		scores[i] = total
	}

	scoreSlice := scores[:]
	slices.Sort(scoreSlice)
	slices.Reverse(scoreSlice)
	return scoreSlice
}
