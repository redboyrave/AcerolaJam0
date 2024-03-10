shader_type particles;

void start() {
	if (LIFETIME > 5.0) {
		RESTART_POSITION;
		RESTART_VELOCITY;
	}

	// Called when a particle is spawned.
}

void process() {
	if (LIFETIME > 5.){
		RESTART;
	}
	// Called every frame on existing particles (according to the Fixed FPS property).
}
