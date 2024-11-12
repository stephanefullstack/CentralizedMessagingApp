// src/cable.js
import { createConsumer } from '@rails/actioncable';

const CableApp = {};
CableApp.cable = createConsumer('ws://localhost:3000/cable');

export default CableApp;
