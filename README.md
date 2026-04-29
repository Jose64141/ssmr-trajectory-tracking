# LSTM-Enhanced Deep Reinforcement Learning for Robust Trajectory Tracking Control of Skid-Steer Mobile Robots Under Terra-Mechanical Constraints
![](https://drive.google.com/uc?export=view&id=1Hc_6TIyF99shEmt_njKgT6FXgRZolA8n)
This repository contains the code for a trajectory tracking controller for skid-steer mobile robots using LSTM-enhanced Deep Reinforcement Learning.

## Requirements

 - MATLAB R2024b
	 - Simulink
	 - Reinforcement Learning Toolbox
	 - Parallel Computing Toolbox
	 - Curve Fitting Toolbox
## Contents
The repository is composed of two folders
	

	│  
	├── Results/												# Results presentation
	│   ├── <test_name>/										# Results graphs
	│   └── graph_<test_name>.mlx								# Graphs generation
	└── Train/													# Training procedure and results
			├── +support/										# Simulation utilities
			└── +train/											# Training utilities
			│	├── <algorith>Train.mlx							# RL algorithm-specific hyperparameters and instantiation
			│	└── defaultHyperparams.mlx						# Common hyperparameters and network architecture instantiation
			│	└── lemRandomRobotResetFcn.m					# Domain randomization utility
			├── try/											# Trials
			│		└── lem/									# Training environment type
			│				└── <model>/						# Model training and testing results
			│						├── <model>Agent.mat		# Agent checkpoint
			│						├── trainStats.mat			# Training metrics
			│						└── out_<test_name>.mat		# Test simulation output
			├── PathFollowerTest.mlx							# Testing procedure
			├── PathFollowerTrain.mlx							# Training procedure
		    ├── pathFollowingRobot.slx                            # Nominal simulation environment
		    └── pathFollowingRobotPerturb.slx                     # Environment with external disturbances
## Usage
### Overview
Execute the  `PathFollowerTrain.mlx` to perform model training, and  `PathFollowerTest.mlx` for model testing.
### Training		
The `PathFollowerTrain.mlx` script contains the environment simulation and model setup to perform model training, allowing the selection of robot and trajectory parameters, and model algorithms. The implemented algorithms are:
 - DDPG
 - DDPG-LSTM
 - TD3
 - TD3-LSTM
 - SAC
 - SAC-LSTM
 - PPO
 - PPO-LSTM
The `defaultHyperparams.mlx` script contains the network architecture and optimization configuration used for all algorithms, considering state and state-action critic networks, in addition stochastic and deterministic networks. Each algorithm has its own instantiating script which specific hyperparameters, as well as defining the training device. As of current, the default is CPU. 
To train the models, define the model instances `models` dictionary. Training is performed by following a lemniscate-shaped trajectory, considering reference randomization in the `lemRandomRobotResetFcn.m` script, modifying lemniscate scale, center and phase. 
## Testing
The `PathFollowerTest.mlx` script perform test simulations, considering a lemniscate, square and mine trajectory. To select models to test, define the  `models` list with the keys of the  `models` dictionary used in the training procedure. The script considers multiple trajectory scenarios, in addition to external disturbances and robot model parameters modifications. The disturbance simulation environment considers to constant disturbance instants, with separate direction. To enable this behavior, define the `leftPerturbT` and `rightPerturbT` variables with the simulation time instant in which to apply the disturbances, in seconds. If the value is a decimal, it will be rounded up. The disturbances' magnitude are defined by the `du` and `dw` variables, for the linear and angular input velocities respectively. To disable the disturbances, set the time instants to a negative value.
## Results
The `graph_<test_name>.mlx` script generates comparative visualizations of each trained model performance, in addition to tracking and control metrics, loading previously executed tests results in the  `Train/try/lem/<model>` folders. Moreover, `graph_lem.mlx` plots cumulative rewards from the training statistics of each models. Each test plots and metrics are saved on their respective folder, each graph in PNG, PDF and EPS file formats. 

