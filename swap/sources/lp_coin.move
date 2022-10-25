module move_funs_swap::lp_coin {
    use aptos_framework::coin;
    use std::string;
    use aptos_framework::coin::{BurnCapability, MintCapability, Coin};

    friend  move_funs_swap::swap;
    friend  move_funs_swap::router;

    struct Lp<phantom X, phantom Y> has key {}


    struct HoldCap<phantom X, phantom Y> has key {
        burn: BurnCapability<Lp<X,Y>>,
        mint: MintCapability<Lp<X,Y>>,


    }

    public entry fun init<X,Y>(singer: &signer) {

        let (burn, freeze, mint) = coin::initialize<Lp<X,Y>>(
            singer,
            string::utf8(b"Lp"),
            string::utf8(b"Lp"),
            8,
            true,
        );
        coin::destroy_freeze_cap(freeze);

        move_to(singer, HoldCap {
            burn,
            mint
        });
    }


    public(friend)  fun mint<X,Y>(amount: u64): Coin<Lp<X,Y>>  acquires HoldCap {
        let cap = borrow_global<HoldCap<X,Y>>(@move_funs_swap);
        coin::mint(amount, &cap.mint)
    }


    public(friend)  fun burn<X,Y>(burn_coin:Coin<Lp<X,Y>>)  acquires HoldCap {
        let cap = borrow_global_mut<HoldCap<X,Y>>(@move_funs_swap);
        coin::burn(burn_coin, &cap.burn);
    }
}
