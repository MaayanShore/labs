rule totalSupplyAfterMint(address account, uint256 amount) {
    env e; 
    
    mint(e, account, amount);
    
    uint256 userBalanceAfter = balanceOf(account);
    uint256 totalAfter = totalSupply();
    
    // Verify that the total supply of the system is at least the current balance of the account.
    assert totalAfter >=  userBalanceAfter, "total supply is less than a user's balance";
}