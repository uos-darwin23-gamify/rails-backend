import { BorderDashed, Hand, ListBullet } from 'radix-icons-svelte';

export const challengeTypes = [
	{
		value: 'FillBlankChallenge',
		label: 'Fill In The Blank',
		icon: BorderDashed
	},
	{
		value: 'McqChallenge',
		label: 'Multiple Choice',
		icon: ListBullet
	},
	{
		value: 'DragDropChallenge',
		label: 'Drag & Drop',
		icon: Hand
	}
];

export const challengeDiffuculties = [
	{
		value: 'EASY',
		label: 'Easy'
	},
	{
		value: 'MEDIUM',
		label: 'Medium'
	},
	{
		value: 'HARD',
		label: 'Hard'
	}
];
