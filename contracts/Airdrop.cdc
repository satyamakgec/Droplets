import FungibleTokenMintable from "./utility/FungibleTokenMintable.cdc"
import FungibleToken from "./utility/FungibleToken.cdc"
import MerkleProof from "./MerkleProoof.cdc"
import Bytes32 from "./Bytes32.cdc"

/// Airdrop contract.
/// Facilitates the distribution of the different types of fungibleTokens and 
/// NonFungibleTokens for masses using the Merkle proof.
pub contract Airdrop {

	pub resource DropPublic {
		/// Allows claiming the entitled amount from the given resource or capability.
		/// Proof every index should not be more than 32 bytes; I don't know what is
		/// is the best alternative type here, so I am using string for now.
		pub fun claim(capability: Capability, amount: UFix64, proof: [Bytes32])
	}
	
	/// Below resource only supporting the FungibleToken for now, but it will
	/// similarly support the NFTs.
	pub resource Drop {
		// Type that can differentiate the resource from other onchain resources.
		let dropSupportedType: Type
		// It should be bytes32, so we have to check that its length is 32.
		let merkleRoot: Bytes32
		// Resource that will allow to mint the fungible tokens.
		let minterResource: @FungibleTokenMintable.Minter?
        // Or we can use the provider capability.
		let fundDistributor: Capability<&{FungibleToken.Provider}>? 

		init(
			dropSupportedType: Type, 
			merkleRoot: Bytes32, 
			minterResource: @FungibleTokenMintable.Minter?, 
			fundDistributor: Capability<&{FungibleToken.Provider}>?
		) {
			// TODO: Add check that value should not be zero
			self.dropSupportedType = dropSupportedType
			self.merkleRoot = merkleRoot
			
			// Either one of the non-nil from minterResource & fundDistributor
			self.minterResource = minterResource
			self.fundDistributor = fundDistributor
		}

		
		pub fun claim(capability: Capability, amount: UFix64, proof: [Bytes32]) {
			// Below is the pseudo-code for claiming the tokens
			// Pack the provided variables and create a hash that would act
			// as the target node.
				let node = HashAlgorithm.SHA3_256.hash(pack(capability.address,amount))
	      assert(MerkleProof.verify(proof, node, self.merkleRoot), message: "Invalid proof")
				
			// Now it is simple, Mint or withdraw from the provider and add into the capability.  
		}

	}

	pub fun	createDrop(...): @Drop {
		return <-new Drop(...)
	}
}