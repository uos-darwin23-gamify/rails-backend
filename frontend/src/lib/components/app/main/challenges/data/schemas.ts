import { z } from 'zod';

export const challengeOverviewSchema = z.object({
	id: z.string(),
	name: z.string(),
	type: z.string(),
	difficulty: z.string(),
	start_time: z.string().nullable(),
	end_time: z.string().nullable(),
	started: z.boolean(),
	finished: z.boolean()
});

export type ChallengeOverview = z.infer<typeof challengeOverviewSchema>;
