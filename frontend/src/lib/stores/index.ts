import { writable } from 'svelte/store';
import { authenticationStatus } from '$lib/auth';
import type UserType from '$lib/enums/userType';

const createAuthenticatedStore = () => {
	const { subscribe, set } = writable<null | boolean | UserType>(null);

	return {
		subscribe,
		verify: async () => set(await authenticationStatus())
	};
};
export const authenticated = createAuthenticatedStore();
