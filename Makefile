-include .env

.PHONY: all test test-zk clean deploy fund help install snapshot format anvil install deploy deploy-zk deploy-zk-sepolia deploy-sepolia verify

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install cyfrin/foundry-devops@0.2.2 --no-commit && forge install foundry-rs/forge-std@v1.9.1 --no-commit && forge install openzeppelin/openzeppelin-contracts@v5.0.2 --no-commit

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

test-zk :; foundryup-zksync && forge test --zksync && foundryup

coverage-report:; forge coverage --report lcov && genhtml lcov.info --branch-coverage --output-dir coverage

test-report:; make coverage-report -w

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

deploy-snft:
	@forge script script/DeploySaiNFT.s.sol:DeploySaiNFT --rpc-url http://localhost:8545 --account local_2266 --broadcast

mint-snft:
	@forge script script/Interactions.s.sol:MintSaiNFT --rpc-url http://localhost:8545 --account local_2266 --broadcast
	

deploy-mnft:
	@forge script script/DeployMoodNFT.s.sol:DeployMoodNFT --rpc-url http://localhost:8545 --account local_2266 --broadcast

mint-mnft:
	@forge script script/Interactions.s.sol:MintMoodNFT --rpc-url http://localhost:8545 --account local_2266 --broadcast

flip-mnft:
	@forge script script/Interactions.s.sol:FlipMoodNFT --rpc-url http://localhost:8545 --account local_2266 --broadcast

deploy-snft-sepolia:
	@forge script script/DeploySaiNFT.s.sol:DeploySaiNFT --rpc-url $(SEPOLIA_RPC_URL) --account main_sepolia_account --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY)

mint-snft-sepolia:
	@forge script script/Interactions.s.sol:MintSaiNFT --rpc-url $(SEPOLIA_RPC_URL) --account main_sepolia_account --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY)

deploy-mnft-sepolia:
	@forge script script/DeployMoodNFT.s.sol:DeployMoodNFT --rpc-url $(SEPOLIA_RPC_URL) --account main_sepolia_account --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY)

mint-mnft-sepolia:
	@forge script script/Interactions.s.sol:MintMoodNFT --rpc-url $(SEPOLIA_RPC_URL) --account main_sepolia_account --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY)
	
flip-mnft-sepolia:
	@forge script script/Interactions.s.sol:FlipMoodNFT --rpc-url $(SEPOLIA_RPC_URL) --account main_sepolia_account --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY)