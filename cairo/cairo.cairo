fn main() -> felt252 { 
    fib(16) 
}

fn fib(mut n: felt252) -> felt252 { 
    let mut a: felt252 = 0; 
    let mut b: felt252 = 1;
    while n != 0 { 
        n = n - 1; 
        let temp = b; 
        b = a + b; 
        a = temp; 
    }; 
    a  
}

#[cfg(test)] 
mod tests { 
    use super::fib; 

    #[test] 
    fn it_works() { 
        assert(fib(16) == 987, 'it works!'); 
     } 
}