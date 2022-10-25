module move_funs_dao::usdc {

    use aptos_framework::coin;
    use std::string;
    use aptos_framework::coin::{BurnCapability, MintCapability};
    use std::signer;

    struct USDC has key {}

    struct HoldCap has key {
        burn: BurnCapability<USDC>,
        mint: MintCapability<USDC>,
    }

    public entry fun init(singer: &signer) {
        let (burn, freeze, mint) = coin::initialize<USDC>(
            singer,
            string::utf8(b"USDC"),
            string::utf8(b"usdc"),
            8,
            true,
        );
        coin::destroy_freeze_cap(freeze);

        move_to(singer, HoldCap {
            burn,
            mint
        });
    }


    public entry fun mint_me(singer: &signer, amount: u64)acquires HoldCap {
        let cap = borrow_global<HoldCap>(@move_funs_dao);
        let coin = coin::mint(amount, &cap.mint);

        if(!coin::is_account_registered<USDC>(signer::address_of(singer))){
            coin::register<USDC>(singer);
        };

        coin::deposit(signer::address_of(singer), coin);
    }
}
