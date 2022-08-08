import Bytes32 from "./Bytes32.cdc";

pub contract MerkleProof {
	
     /// Returns true if a `leaf` can be proved to be a part of a Merkle tree
     /// defined by `root`. For this, a `proof` must be provided, containing
     /// sibling hashes on the branch from the leaf to the tree's root. Each
     /// pair of leaves and each pair of pre-images are assumed to be sorted.
    pub fun verify(
        proof: [Bytes32],
        root: Bytes32,
        leaf: Bytes32
    ): Bool {
        let computedHash: Bytes32  = leaf;

        for proofElement in proof {
            if computedHash.lt(proofElement) || computedHash.eq(proofElement) {
                // Hash(current computed hash + current element of the proof)
                computedHash = HashAlgorithm.SHA3_256.hash(computedHash.concat(proofElement));
            } else {
                // Hash(current element of the proof + current computed hash)
                computedHash = HashAlgorithm.SHA3_256.hash(proofElement.concat(computedHash));
            }
        }
        // Check if the computed hash (root) is equal to the provided root
        return computedHash.eq(root);
    }
}