module move_funs_swap::router {
    use move_funs_swap::swap;
    use aptos_framework::coin;
    use move_funs_swap::swap::{is_exists, swap_x_to_y, swap_y_to_x, remove};
    use std::signer;
    use move_funs_swap::lp_coin::Lp;


    public entry fun create_pool<CoinX, CoinY>(sender: &signer) {
        swap::create_pool<CoinX, CoinY>(sender)
    }

    public entry fun add_to_pool<CoinX, CoinY>(sender: &signer, amount_x: u64, amount_y: u64) {
        let coin_x = coin::withdraw<CoinX>(sender, amount_x);
        let coin_y = coin::withdraw<CoinY>(sender, amount_y);
        let lp_token = swap::add(coin_x, coin_y);

        if(!coin::is_account_registered<Lp<CoinX, CoinY>>(signer::address_of(sender))){
          coin::register<Lp<CoinX, CoinY>>(sender);
        };
        coin::deposit(signer::address_of(sender), lp_token);
    }


    public entry fun remove_from_pool<CoinX, CoinY>(sender: &signer, lp: u64) {
        let token = coin::withdraw<Lp<CoinX, CoinY>>(sender, lp);
        let (x, y) = remove(token);
        coin::deposit(signer::address_of(sender), x);
        coin::deposit(signer::address_of(sender), y);
    }


    public entry fun swap<CoinIn, CoinOut>(sender: &signer, amount: u64) {
        assert!(is_exists<CoinIn, CoinOut>() || is_exists<CoinOut, CoinIn>(), 0x0001);

        let coin_x = coin::withdraw<CoinIn>(sender, amount);

        if (is_exists<CoinIn, CoinOut>()) {
            let coin_out = swap_x_to_y<CoinIn, CoinOut>(coin_x);
            coin::deposit(signer::address_of(sender), coin_out)
        }else {
            let coin_out = swap_y_to_x<CoinIn, CoinOut>(coin_x);
            coin::deposit(signer::address_of(sender), coin_out)
        }
    }
}
