const app = Vue.createApp({
    data() {
        return {
            hudVisible: true,
            fuelHudVisible: false,
            stressVisible: false,
            armourOff: false,
            staminaVisible: false,
            health: 0,
            armour: 0,
            hunger: 0,
            thirst: 0,
            stress: 0,
            stamina: 0,
            voice: 0,
            fuel: 0,
            talking: false,
            radio: false,
            lastFuelDataTimestamp: null,
            voiceIcon: 'fas fa-microphone',
            voiceColor: '#bbbbbb',
            devMode: false,
            devInterval: null
        }
    },
    mounted() {
      window.addEventListener('message', this.handleMessage);
        // this.startDevMode();

    },
    methods: {
        handleMessage(event) {
            const data = event.data;

            if (data.toggle !== undefined) {
                this.hudVisible = data.toggle;
            }

            if (data.togglefuel !== undefined) {
                this.handleFuelData(data);
            }

            if (data.stressshow !== undefined) {
                this.stressVisible = data.stressshow;
            }

            // Update HUD values
            if (data.health !== undefined) this.health = data.health;
            if (data.armour !== undefined) this.armour = data.armour;
            if (data.hunger !== undefined) this.hunger = data.hunger;
            if (data.thirst !== undefined) this.thirst = data.thirst;
            if (data.stress !== undefined) this.stress = data.stress;
            if (data.stamina !== undefined) this.stamina = data.stamina;
            if (data.voice !== undefined) this.voice = data.voice;
            if (data.fuel !== undefined) this.fuel = data.fuel;

            // Handle visibility toggles
            if (data.armouroff !== undefined) this.armourOff = data.armouroff;
            if (data.staminaoff !== undefined) this.staminaVisible = data.staminaoff;

            // Handle voice states
            if (data.talking !== undefined) {
                this.talking = data.talking === "1";
                this.updateVoiceStatus(data);
            }

            if (data.radio !== undefined) {
                this.radio = data.radio === "1";
                this.updateVoiceStatus(data);
            }
        },
        handleFuelData(data) {
            const currentTimestamp = Date.now();
            const isEnabled = data.togglefuel === 1;

            if (isEnabled) {
                this.lastFuelDataTimestamp = currentTimestamp;
                this.fuelHudVisible = true;
            } else if (
                this.lastFuelDataTimestamp !== null &&
                currentTimestamp - this.lastFuelDataTimestamp >= 10000
            ) {
                this.fuelHudVisible = false;
            }
        },
        updateVoiceStatus(data) {
            if (this.talking) {
                this.voiceColor = this.radio ? '#8000ff' : '#ffae00';
                this.voiceIcon = this.radio ? 'fas fa-walkie-talkie' : 'fas fa-microphone';
            } else {
                this.voiceColor = '#bbbbbb';
                this.voiceIcon = 'fas fa-microphone';
            }
        },
        // Add new dev mode methods
        toggleDevMode() {
            this.devMode = !this.devMode;
            if (this.devMode) {
                this.startDevMode();
            } else {
                this.stopDevMode();
            }
        },
        startDevMode() {
            let values = [0, 25, 50, 75, 100];
            let currentIndex = 0;
            
            // Show all HUD elements in dev mode
            this.hudVisible = true;
            this.fuelHudVisible = true;
            this.stressVisible = true;
            this.staminaVisible = true;
            this.armourOff = false;

            this.devInterval = setInterval(() => {
                let value = values[currentIndex];
                
                // Update all progress bars
                this.health = value;
                this.armour = value;
                this.hunger = value;
                this.thirst = value;
                this.stress = value;
                this.stamina = value;
                this.voice = value;
                this.fuel = value;

                // Move to next value or reset to beginning
                currentIndex = (currentIndex + 1) % values.length;
            }, 1000); // Change values every second
        },
        stopDevMode() {
            if (this.devInterval) {
                clearInterval(this.devInterval);
                this.devInterval = null;
            }
            // Reset all values to 0
            this.health = 0;
            this.armour = 0;
            this.hunger = 0;
            this.thirst = 0;
            this.stress = 0;
            this.stamina = 0;
            this.voice = 0;
            this.fuel = 0;
        }
    }
}).mount('#app');