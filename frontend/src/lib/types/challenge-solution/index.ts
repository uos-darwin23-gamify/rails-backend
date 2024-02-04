import type { ScqChallengeSolutionType } from './scq';
import type { McqChallengeSolutionType } from './mcq';
import type { ConnectBlocksChallengeSolutionType } from './connect';
import type { CodeOutputChallengeSolutionType } from './code';

type SolutionType =
	| ScqChallengeSolutionType
	| McqChallengeSolutionType
	| ConnectBlocksChallengeSolutionType
	| CodeOutputChallengeSolutionType;

export type {
	ScqChallengeSolutionType,
	McqChallengeSolutionType,
	ConnectBlocksChallengeSolutionType,
	CodeOutputChallengeSolutionType,
	SolutionType
};
