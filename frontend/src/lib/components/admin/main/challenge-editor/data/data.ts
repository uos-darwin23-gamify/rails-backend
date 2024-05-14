import { Button, Hand, ListBullet, DotFilled } from 'radix-icons-svelte';

export const challengeTypes = [
	{
		value: 'ScqChallenge',
		label: 'Single Choice',
		icon: DotFilled
	},
	{
		value: 'McqChallenge',
		label: 'Multiple Choice',
		icon: ListBullet
	},
	{
		value: 'ConnectBlocksChallenge',
		label: 'Connect Blocks',
		icon: Hand
	},
	{
		value: 'CodeOutputChallenge',
		label: 'Code Output',
		icon: Button
	}
];

export const challengeDiffuculties = [
	{
		value: 'SIMPLE',
		label: 'Simple'
	},
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
	},
	{
		value: 'EXTREME',
		label: 'Extreme'
	}
];
