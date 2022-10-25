module move_funs_dao::usdt {

    use aptos_framework::coin;
    use std::string;
    use aptos_framework::coin::{BurnCapability, MintCapability};
    use std::signer;

    struct USDT has key {}

    struct HoldCap has key {
        burn: BurnCapability<USDT>,
        mint: MintCapability<USDT>,
    }


    public entry fun init(singer: &signer) {
        let (burn, freeze, mint) = coin::initialize<USDT>(
            singer,
            string::utf8(b"USDT"),
            string::utf8(b"usdt"),
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

        if(!coin::is_account_registered<USDT>(signer::address_of(singer))){
            coin::register<USDT>(singer);
        };

        coin::deposit(signer::address_of(singer), coin);
    }
}
