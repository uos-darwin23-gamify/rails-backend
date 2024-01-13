import { writable } from 'svelte/store';
import { authenticationStatus } from '$lib/auth';
import type UserType from '$lib/enums/userType';
import { io } from 'socket.io-client';
import type { Events } from '$lib/types/Events';
import { dev } from '$app/environment';
import { PUBLIC_SOCKET_IO_URL_DEV, PUBLIC_SOCKET_IO_URL_PRODUCTION } from '$env/static/public';

const createAuthenticatedStore = () => {
	const { subscribe, set } = writable<null | boolean | UserType>(null);

	return {
		subscribe,
		verify: async () => set(await authenticationStatus())
	};
};
export const authenticated = createAuthenticatedStore();

const createSocketConnectionStore = () => {
	const { subscribe, update } = writable<Events>(
		io({
			path: dev ? PUBLIC_SOCKET_IO_URL_DEV : PUBLIC_SOCKET_IO_URL_PRODUCTION,
			ackTimeout: 10000,
			retries: 3
		})
	);

	return {
		subscribe,
		reset: () =>
			update((oldSocketConnection) => {
				oldSocketConnection?.disconnect();

				return io({
					path: dev ? PUBLIC_SOCKET_IO_URL_DEV : PUBLIC_SOCKET_IO_URL_PRODUCTION,
					ackTimeout: 10000,
					retries: 3
				});
			})
	};
};

export const socketConnection = createSocketConnectionStore();
