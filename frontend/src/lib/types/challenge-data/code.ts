export type CodeOutputChallengeDataType = {
	code: string;
	question_array: {
		question: string;
		select:
			| {
					startLineNumber: number;
					startColumn: number;
					endLineNumber: number;
					endColumn: number;
			  }
			| undefined;
	}[];
};
