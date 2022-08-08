/**

# The Flow Fungible Token standard

## `FungibleToken` contract interface

The interface that all Fungible Token contracts would have to conform to.
If a users wants to deploy a new token contract, their contract
would need to implement the FungibleToken interface.

Their contract would have to follow all the rules and naming
that the interface specifies.

## `Vault` resource

Each account that owns tokens would need to have an instance
of the Vault resource stored in their account storage.

The Vault resource has methods that the owner and other users can call.

## `Provider`, `Receiver`, and `Balance` resource interfaces

These interfaces declare pre-conditions and post-conditions that restrict
the execution of the functions in the Vault.

They are separate because it gives the user the ability to share
a reference to their Vault that only exposes the fields functions
in one or more of the interfaces.

It also gives users the ability to make custom resources that implement
these interfaces to do various things with the tokens.
For example, a faucet can be implemented by conforming
to the Provider interface.

By using resources and interfaces, users of Fungible Token contracts
can send and receive tokens peer-to-peer, without having to interact
with a central ledger smart contract. To send tokens to another user,
a user would simply withdraw the tokens from their Vault, then call
the deposit function on another user's Vault to complete the transfer.

*/

import FungibleToken from "./FungibleToken.cdc"

/// FungibleToken
///
/// The interface that Fungible Token contracts implement.
///
pub contract interface FungibleTokenMintable: FungibleToken {

    /// TokensMinted
    ///
    /// The event that is emitted when tokens are minted.
    pub event TokensMinted(amount: amount)


    pub resource interface Minter {

        /// The amount of tokens that the minter is allowed to mint
        pub var allowedAmount: UFix64

        /// mintTokens
        ///
        /// Function that mints new tokens, adds them to the total supply,
        /// and returns them to the calling context.
        ///
        pub fun mintTokens(amount: UFix64): @FungibleToken.Vault {
            pre {
                amount > 0.0: "Amount minted must be greater than zero"
                amount <= self.allowedAmount: "Amount minted must be less than the allowed amount"
            }
        }

        init(allowedAmount: UFix64)
    }
}