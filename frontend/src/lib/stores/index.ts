import { get, readable, writable } from 'svelte/store';
import { authenticationStatus } from '$lib/auth';
import type UserType from '$lib/enums/UserType';
import { io } from 'socket.io-client';
import type { Events } from '$lib/types/Events';
import loader from '@monaco-editor/loader';
import { browser } from '$app/environment';

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
		io({
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

				return io({
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

export const monaco = readable(
	(() => {
		if (browser) {
			loader.config({});
			return loader.init();
		}
	})()
);
