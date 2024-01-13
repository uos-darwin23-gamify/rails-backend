import { Socket } from 'socket.io-client';

interface CustomEvents {
	'custom event 1': (callback: () => any) => void;
	'user-type': (data: { userType: false | 'user' | 'admin' }, callback: () => any) => void;
}

export interface Events extends Socket<CustomEvents> {}
