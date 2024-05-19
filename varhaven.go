package main

import (
	"bufio"
	"fmt"
	"math/rand/v2"
	"os"
	"slices"
	"strings"
)

func getModifier(score int64) int64 {
	return int64(float64((score - 10) / 2))
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	fmt.Println("Generating character values...")
	scores := generateScores()
	fmt.Println("Applying human racial bonus...")

	for i := 0; i < 6; i++ {
		scores[i] += 1
	}

	fmt.Println("Let's roll initiative!")
	playerInit := rand.Int64N(20) + 1 + getModifier(scores[1])
	goblinInit := rand.Int64N(20) + 1 + 2
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

	var goblinHP int64 = 7
	var playerHP int64 = 10 + getModifier(scores[2])
	var playerAC int64 = 10 + getModifier(scores[1])

	for {
		if playerFirst {
			playerTurn(reader, scores, &goblinHP)

			if goblinHP < 0 {
				fmt.Println("You win!")
				os.Exit(0)
			}

			goblinTurn(&playerHP, playerAC)

			if playerHP < 0 {
				fmt.Println("You lose!")
				os.Exit(0)
			}
		} else {
			goblinTurn(&playerHP, playerAC)

			if playerHP < 0 {
				fmt.Println("You lose!")
				os.Exit(0)
			}

			playerTurn(reader, scores, &goblinHP)

			if goblinHP < 0 {
				fmt.Println("You win!")
				os.Exit(0)
			}
		}
	}
}

func generateScores() []int64 {
	var scores [6]int64

	for i := 0; i < 6; i++ {
		var rolls [4]int64

		for j := 0; j < 4; j++ {
			rolls[j] = rand.Int64N(6) + 1
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

func playerTurn(reader *bufio.Reader, scores []int64, goblinHP *int64) {
	fmt.Println("What would you like to do?")
	fmt.Println("1 - Longsword (Melee Attack)")

	choice, err := reader.ReadString('\n')
	choice = strings.TrimSpace(choice)

	if err != nil {
		errWriter := bufio.NewWriter(os.Stderr)
		errWriter.Write([]byte(err.Error()))
		os.Exit(1)
	}

	for choice != "1" {
		fmt.Println("Please choose 1.")
		choice, err = reader.ReadString('\n')

		if err != nil {
			errWriter := bufio.NewWriter(os.Stderr)
			errWriter.Write([]byte(err.Error()))
			os.Exit(1)
		}
	}

	if choice == "1" {
		if attack(getModifier(scores[0])+2, 15) {
			dam := damage(1, 8, getModifier(scores[0]))

			fmt.Printf("You hit with your Longsword dealing %d points of slashing damage.\n", dam)
			*goblinHP -= dam
		} else {
			fmt.Println("You miss!")
		}
	}
}

func attack(bonus int64, ac int64) bool {
	var roll int64 = rand.Int64N(20) + 1 + bonus
	return roll >= ac
}

func damage(amount int64, size int64, modifier int64) int64 {
	var total int64 = 0
	var i int64

	for i = 0; i < amount; i++ {
		total += rand.Int64N(size) + 1
	}

	return total + modifier
}

func goblinTurn(playerHP *int64, ac int64) {
	fmt.Println("The goblin swings at you with its scimitar.")

	if attack(4, ac) {
		dam := damage(1, 6, 2)

		fmt.Printf("The goblin hits you dealing %d points of slashing damage.\n", dam)
		*playerHP -= dam
	} else {
		fmt.Println("It misses!")
	}
}
