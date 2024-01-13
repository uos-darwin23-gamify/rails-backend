import { get, writable } from 'svelte/store';
import { authenticationStatus } from '$lib/auth';
import type UserType from '$lib/enums/userType';
import { io } from 'socket.io-client';
import type { Events } from '$lib/types/Events';
import { dev } from '$app/environment';
import { PUBLIC_SOCKET_IO_URL_PRODUCTION } from '$env/static/public';

const createAuthenticatedStore = () => {
	const { subscribe, set } = writable<null | boolean | UserType>(null);

	return {
		subscribe,
		verify: async () => set(await authenticationStatus())
	};
};
export const authenticated = createAuthenticatedStore();

const createSocketConnectionStore = () => {
	const storeInstance = writable<Events>(
		io(dev ? '' : PUBLIC_SOCKET_IO_URL_PRODUCTION, {
			path: '/socket',
			ackTimeout: 10000,
			retries: 3,
			withCredentials: true
		})
	);

	return {
		subscribe: storeInstance.subscribe,
		reset: () =>
			storeInstance.update((oldSocketConnection) => {
				oldSocketConnection?.disconnect();

				return io(dev ? '' : PUBLIC_SOCKET_IO_URL_PRODUCTION, {
					path: '/socket',
					ackTimeout: 10000,
					retries: 3,
					withCredentials: true
				});
			}),
		refresh: () => get(storeInstance).disconnect().connect()
	};
};

export const socketConnection = createSocketConnectionStore();
