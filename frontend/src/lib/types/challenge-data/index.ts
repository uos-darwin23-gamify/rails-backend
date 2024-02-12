import type { ScqChallengeDataType as Scq } from './scq';
import type { McqChallengeDataType as Mcq } from './mcq';
import type { ConnectBlocksChallengeDataType as Connect } from './connect';
import type { CodeOutputChallengeDataType as Code } from './code';

type BaseChallengeDataType = {
	name: string;
	type: 'ScqChallenge' | 'McqChallenge' | 'ConnectBlocksChallenge' | 'CodeOutputChallenge';
	difficulty: 'EASY' | 'MEDIUM' | 'HARD';
	question_overview: string;
};

type ScqChallengeDataType = BaseChallengeDataType & Scq;
type McqChallengeDataType = BaseChallengeDataType & Mcq;
type ConnectBlocksChallengeDataType = BaseChallengeDataType & Connect;
type CodeOutputChallengeDataType = BaseChallengeDataType & Code;

type ChallengeDataType =
	| ScqChallengeDataType
	| McqChallengeDataType
	| ConnectBlocksChallengeDataType
	| CodeOutputChallengeDataType;

export type {
	ScqChallengeDataType,
	McqChallengeDataType,
	ConnectBlocksChallengeDataType,
	CodeOutputChallengeDataType,
	ChallengeDataType
};