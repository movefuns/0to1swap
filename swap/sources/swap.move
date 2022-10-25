module move_funs_swap::swap {

    use aptos_framework::coin::{Coin, value};
    use aptos_framework::coin;
    use move_funs_swap::lp_coin::Lp;
    use move_funs_swap::lp_coin;
    use std::signer;

    const ERROR_MUST_ADMIN:u64 = 0x0001;

    struct Pool<phantom CoinX, phantom CoinY> has key {
        coin_x: Coin<CoinX>,
        coin_y: Coin<CoinY>,
    }


    public fun create_pool<X, Y>(sender: &signer) {
        assert!(signer::address_of(sender) == @move_funs_swap,ERROR_MUST_ADMIN);
        lp_coin::init<X,Y>(sender);
        move_to(sender, Pool<X, Y> {
            coin_x: coin::zero(),
            coin_y: coin::zero()
        })
    }


    public fun add<X, Y>(coin_x: Coin<X>, coin_y: Coin<Y>): Coin<Lp<X, Y>>
    acquires Pool {
        let pool = borrow_global_mut<Pool<X, Y>>(@move_funs_swap);
        let x_value = value(&coin_x);
        let y_value = value(&coin_y);
        coin::merge(&mut pool.coin_x, coin_x);
        coin::merge(&mut pool.coin_y, coin_y);

        lp_coin::mint<X, Y>((x_value + y_value)*2)
    }


    public fun remove<X, Y>(coin:Coin<Lp<X,Y>>):(Coin<X>,Coin<Y>)acquires Pool {
        let pool = borrow_global_mut<Pool<X, Y>>(@move_funs_swap);
        let lp_value = coin::value(&coin);
        lp_coin::burn(coin);
        let coinx = coin::extract(&mut pool.coin_x,lp_value);
        let coiny = coin::extract(&mut pool.coin_y,lp_value);
        (coinx,coiny)
    }


    public fun is_exists<X, Y>(): bool {
        exists<Pool<X, Y>>(@move_funs_swap)
    }


    /// usdc -> usdt
    public fun swap_x_to_y<In, Out>(coinx: Coin<In>): Coin<Out>acquires Pool {
        let pool = borrow_global_mut<Pool<In, Out>>(@move_funs_swap);
        let value = coin::value(&coinx);
        coin::merge(&mut pool.coin_x, coinx);
        coin::extract(&mut pool.coin_y, value)
    }


    /// usdc -> usdt
    public fun swap_y_to_x<In, Out>(coin_in: Coin<In>): Coin<Out>acquires Pool {
        let pool = borrow_global_mut<Pool<Out, In>>(@move_funs_swap);
        let value = coin::value(&coin_in);
        coin::merge(&mut pool.coin_y, coin_in);
        coin::extract(&mut pool.coin_x, value)
    }
}
